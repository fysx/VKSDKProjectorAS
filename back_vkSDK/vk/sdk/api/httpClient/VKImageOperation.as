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
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Handler;
import android.os.Looper;

import com.vk.sdk.api.VKError;

import org.apache.http.client.methods.HttpGet;

public class VKImageOperation extends VKHttpOperation {

    public var imageDensity:Number;
    /**
     * Create new operation for loading prepared Http request.
     *
     * @param imageUrl URL for image
     */
    public function VKImageOperation(imageUrl:String) {
        super(new HttpGet(imageUrl));
    }
    /**
     * Set listener for current operation
     * @param listener Listener subclasses VKHTTPOperationCompleteListener
     */
    public function setImageOperationListener(listener:VKImageOperationListener):void {
        this.setCompleteListener(new VKOperationCompleteListener() {
            
override public function onComplete():void {
                if (VKImageOperation.this.state() != VKOperationState.Finished || mLastException != null) {
                    listener.onError(VKImageOperation.this, generateError(mLastException));
                } else {
                    var response:Array= getResponseData();
                    var captchaImage:Bitmap= BitmapFactory.decodeByteArray(response, 0, response.length);
                    if (imageDensity > 0) {
                        captchaImage = Bitmap.createScaledBitmap(captchaImage, int((captchaImage.getWidth() * imageDensity)), int((captchaImage.getHeight() * imageDensity)), true);
                    }
                    var result:Bitmap= captchaImage;
                    new Handler(Looper.getMainLooper()).post(new Runnable() {
                        
override public function run():void {
                            listener.onComplete(VKImageOperation.this, result);
                        }
                    });
                }
            }
        });
    }
}

import android.graphics.Bitmap;
import com.vk.sdk.api.VKError;

    /**
     * Class representing operation listener for VKHttpOperation
     */
    public static abstract 
internal class VKImageOperationListener  extends VKHTTPOperationCompleteListener
    {
        public function onComplete(operation:VKImageOperation, image:Bitmap):void {
        }

        public function onError(operation:VKImageOperation, error:VKError):void {
        }
    }
}