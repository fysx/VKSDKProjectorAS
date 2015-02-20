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

import org.apache.http.client.methods.HttpUriRequest;
import org.json.JSONObject;

/**
 * Operation for loading HTTP-requests that may return json response
 */
public class VKJsonOperation extends VKHttpOperation {
	private var mResponseJson:JSONObject;

    /**
     * Create new operation with request
     * @param uriRequest Request prepared manually or with VKHttpClient
     */
    public function VKJsonOperation(uriRequest:HttpUriRequest) {
        super(uriRequest);
    }

    /**
     * Generate JSON-response for current operation
     * @return Parsed JSON object from response string
     */
    public function getResponseJson():JSONObject {
        if (mResponseJson == null) {
            var response:String= getResponseString();
            if (response == null)
                return null;
            try {
                mResponseJson = new JSONObject(response);
            } catch (e:Exception) {
                mLastException = e;
            }
        }
        return mResponseJson;
    }

    
override protected function postExecution():Boolean {
        if (!super.postExecution())
            return false;
        mResponseJson = getResponseJson();
        return true;
    }

    /**
     * Not available for JSONOperation
     * @deprecated This method is deprecated for this class
     * @param listener Listener subclasses VKHTTPOperationCompleteListener
     */
    
override public function setHttpOperationListener(listener:VKHTTPOperationCompleteListener):void {
        throw new UnsupportedOperationException("This operation is now available for this class");
    }

    /**
     * Sets that json operation listener
     * @param listener Listener object for that operation
     */
    public function setJsonOperationListener(listener:VKJSONOperationCompleteListener):void {
        if (listener == null) {
            super.setCompleteListener(null);
            return;
        }

        this.setCompleteListener(new VKOperationCompleteListener() {
            
override public function onComplete():void {
                if (VKJsonOperation.this.state() != VKOperationState.Finished || mLastException != null) {
                    listener.onError(VKJsonOperation.this, generateError(mLastException));
                } else {
                    listener.onComplete(VKJsonOperation.this, mResponseJson);
                }
            }
        });
    }
}

import org.json.JSONObject;
import com.vk.sdk.api.VKError;

    /**
     * Class representing operation listener for VKJsonOperation
     */
    public static abstract 
internal class VKJSONOperationCompleteListener extends VKAbstractCompleteListener<VKJsonOperation, JSONObject> {
        public function onComplete(operation:VKJsonOperation, response:JSONObject):void {
        }

        public function onError(operation:VKJsonOperation, error:VKError):void {
        }
    }
}