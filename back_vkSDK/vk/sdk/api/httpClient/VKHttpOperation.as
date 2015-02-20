//
//  Copyright (c) 2014 VK.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

package com.vk.sdk.api.httpClient {
import com.vk.sdk.api.VKError;

import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpUriRequest;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.zip.GZIPInputStream;

/**
 * Class for loading any data by HTTP request
 */
public class VKHttpOperation extends VKAbstractOperation {
	/**
     * Request initialized this object
     */
    private var mUriRequest:HttpUriRequest;
    /**
     * Last exception throws while loading or parsing
     */
    protected var mLastException:Exception;
    /**
     * Bytes of HTTP response
     */
    private var mResponseBytes:Array;

    /**
     * Stream for output result of HTTP loading
     */
    public var outputStream:OutputStream;
    /**
     * Standard HTTP response
     */
    public var response:HttpResponse;

    /**
     * String representation of response
     */
    private var mResponseString:String;

    /**
     * Create new operation for loading prepared Http request. Requests may be prepared in VKHttpClient
     *
     * @param uriRequest Prepared request
     */
    public function VKHttpOperation(uriRequest:HttpUriRequest) {
        mUriRequest = uriRequest;
    }

    /**
     * Start current prepared http-operation for result
     */
    
override public function start():void {
        setState(VKOperationState.Executing);
        try {
            if (mUriRequest.isAborted()) return;
            response = VKHttpClient.getClient().execute(mUriRequest);
            var inputStream:InputStream= response.getEntity().getContent();
            var contentEncoding:Header= response.getFirstHeader("Content-Encoding");
            if (contentEncoding != null && contentEncoding.getValue().equalsIgnoreCase("gzip")) {
                inputStream = new GZIPInputStream(inputStream);
            }

            if (outputStream == null) {
                outputStream = new ByteArrayOutputStream();
            }

            var buffer:Array= new byte[1024];
            var bytesRead:int;
            while ((bytesRead = inputStream.read(buffer)) != -1)
                outputStream.write(buffer, 0, bytesRead);
            inputStream.close();
            outputStream.flush();
            if (outputStream is ByteArrayOutputStream) {
                mResponseBytes = (ByteArrayOutputStream(outputStream)).toByteArray();
            }
            outputStream.close();
        } catch (e:Exception) {
            mLastException = e;
        }
        setState(VKOperationState.Finished);
    }

    
override public function finish():void {
        postExecution();
        super.finish();
    }

    /**
     * Calls before providing result, but after response loads
     * @return true is post execution succeed
     */
    protected function postExecution():Boolean {
        return true;
    }

    /**
     * Cancel current operation execution
     */
    
override public function cancel():void {
        VKHttpClient.cancelHttpOperation(this);
        super.cancel();
    }

	/**
	 * Returns request associated with current operation
	 * @return URI request
	 */
	public function getUriRequest():HttpUriRequest { return mUriRequest; }

    /**
     * Get operation response data
     * @return Bytes of response
     */
    public byte[] getResponseData() {
        return mResponseBytes;
    }

    /**
     * Get operation response string, if possible
     * @return Encoded string from response data bytes
     */
    public function getResponseString():String {
        if (mResponseBytes == null)
            return null;
        if (mResponseString == null) {
            try {
                mResponseString = new String(mResponseBytes, "UTF-8");
            } catch (e:UnsupportedEncodingException) {
                mLastException = e;
            }
        }
        return mResponseString;
    }

    /**
     * Generates VKError about that request fails
     * @param e Exception for error
     * @return New generated error
     */
    protected function generateError(e:Exception):VKError {
        var error:VKError;
        if (state() == VKOperationState.Canceled) {
            error = new VKError(VKError.VK_CANCELED);
        } else {
            error = new VKError(VKError.VK_REQUEST_HTTP_FAILED);
        }
        if (e != null) {
            error.errorMessage = e.getMessage();
            if (error.errorMessage == null)
                error.errorMessage = e.toString();
            error.httpError = e;
        }
        return error;
    }

    /**
     * Set listener for current operation
     * @param listener Listener subclasses VKHTTPOperationCompleteListener
     */
    public function setHttpOperationListener(listener:VKHTTPOperationCompleteListener):void {
        this.setCompleteListener(new VKOperationCompleteListener() {
            
override public function onComplete():void {
                if (VKHttpOperation.this.state() != VKOperationState.Finished || mLastException != null) {
                    listener.onError(VKHttpOperation.this, generateError(mLastException));
                } else {
                    listener.onComplete(VKHttpOperation.this, mResponseBytes);
                }
            }
        });
    }
}

import com.vk.sdk.api.VKError;

    /**
     * Class representing operation listener for VKHttpOperation
     */
    public static abstract 
internal class VKHTTPOperationCompleteListener extends VKAbstractCompleteListener<VKHttpOperation, byte[]>
    {
        
override public function onComplete(operation:VKHttpOperation, response:Array):void {
        }

        
override public function onError(operation:VKHttpOperation, error:VKError):void {
        }
    }
}