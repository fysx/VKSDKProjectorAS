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

package com.vk.sdk.api.photo {
import com.vk.sdk.VKSdk;
import com.vk.sdk.api.VKError;
import com.vk.sdk.api.VKRequest;
import com.vk.sdk.api.VKResponse;
import com.vk.sdk.api.httpClient.VKAbstractOperation;
import com.vk.sdk.api.httpClient.VKHttpClient;
import com.vk.sdk.api.httpClient.VKJsonOperation;
import com.vk.sdk.api.httpClient.VKJsonOperation.VKJSONOperationCompleteListener;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;

/**
 * Provides common part of photo upload process
 */
public abstract 
internal class VKUploadPhotoBase extends VKRequest {
	private static const serialVersionUID:Number= -4566961568409572159L;
	/**
     * ID of album to upload
     */
    protected var mAlbumId:Number;
    /**
     * ID of group to upload
     */
    protected var mGroupId:Number;
    /**
     * ID of user wall to upload
     */
    protected var mUserId:Number;
    /**
     * Image to upload
     */
    protected var mImages:Array;

    protected abstract function getServerRequest():VKRequest ;

    protected abstract function getSaveRequest(response:JSONObject):VKRequest ;

    public function VKUploadPhotoBase() {
        super(null);
    }

    
override public function getOperation():VKAbstractOperation {
        return new VKUploadImageOperation();
    }
}

import org.json.JSONObject;
import com.vk.sdk.api.VKRequest;
import java.io.File;
import com.vk.sdk.api.VKError;
import com.vk.sdk.api.httpClient.VKAbstractOperation;
import com.vk.sdk.api.httpClient.VKJsonOperation.VKJSONOperationCompleteListener;
import org.json.JSONException;
import com.vk.sdk.api.httpClient.VKHttpClient;
import com.vk.sdk.api.httpClient.VKJsonOperation;
import com.vk.sdk.VKSdk;
import com.vk.sdk.api.VKResponse;

    protected 
internal class VKUploadImageOperation extends VKAbstractOperation {
		protected var lastOperation:VKAbstractOperation;

        
override public function start():void {
            var originalListener:VKRequestListener= VKUploadPhotoBase.this.requestListener;

            VKUploadPhotoBase.this.requestListener = new VKRequestListener() {
                
override public function onComplete(response:VKResponse):void {
                    setState(VKOperationState.Finished);
                    response.request = VKUploadPhotoBase.this;
                    if (originalListener != null)
                        originalListener.onComplete(response);
                }

                
override public function onError(error:VKError):void {
                    setState(VKOperationState.Finished);
                    error.request = VKUploadPhotoBase.this;
                    if (originalListener != null)
                        originalListener.onError(error);
                }

                
override public function onProgress(progressType:VKProgressType, bytesLoaded:Number,
                                       bytesTotal:Number):void {
                    if (originalListener != null)
                        originalListener.onProgress(progressType, bytesLoaded, bytesTotal);
                }
            };
            setState(VKOperationState.Executing);

            var serverRequest:VKRequest= getServerRequest();

            serverRequest.setRequestListener(new VKRequestListener() {
                
override public function onComplete(response:VKResponse):void {
                    try {
                        var postFileRequest:VKJsonOperation= new VKJsonOperation(
                                VKHttpClient.fileUploadRequest(response.json.getJSONObject("response").getString("upload_url"), mImages));
                        postFileRequest.setJsonOperationListener(new VKJSONOperationCompleteListener() {
                            
override public function onComplete(operation:VKJsonOperation,
                                                   response:JSONObject):void {

                                var saveRequest:VKRequest= getSaveRequest(response);
                                saveRequest.setRequestListener(new VKRequestListener() {
                                    
override public function onComplete(response:VKResponse):void {
                                        requestListener.onComplete(response);
                                        setState(VKOperationState.Finished);
                                    }

                                    
override public function onError(error:VKError):void {
                                        requestListener.onError(error);
                                    }
                                });
                                lastOperation = saveRequest.getOperation();
                                VKHttpClient.enqueueOperation(lastOperation);
                            }

                            
override public function onError(operation:VKJsonOperation, error:VKError):void {
                                requestListener.onError(error);
                            }
                        });

                        lastOperation = postFileRequest;
                        VKHttpClient.enqueueOperation(lastOperation);
                    } catch (e:JSONException) {
                        if (VKSdk.DEBUG)
                            e.printStackTrace();
                        var error:VKError= new VKError(VKError.VK_JSON_FAILED);
                        error.httpError = e;
                        error.errorMessage = e.getMessage();
                        requestListener.onError(error);
                    }
//					postFileRequest.progressBlock = _uploadRequest.progressBlock;
                }

                
override public function onError(error:VKError):void {
                    if (requestListener != null)
                        requestListener.onError(error);
                }
            });
            lastOperation = serverRequest.getOperation();
            VKHttpClient.enqueueOperation(lastOperation);
        }

        
override public function cancel():void {
            if (lastOperation != null)
                lastOperation.cancel();
            super.cancel();
        }

        
override public function finish():void {
            super.finish();
            lastOperation = null;
        }
    }

}