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

package com.vk.sdk.dialogs {
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Bitmap;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.view.inputmethod.EditorInfo;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.vk.sdk.R;
import com.vk.sdk.VKUIHelper;
import com.vk.sdk.api.VKError;
import com.vk.sdk.api.httpClient.VKHttpClient;
import com.vk.sdk.api.httpClient.VKImageOperation;

/**
 * Dialog fo displaying captcha
 */
public class VKCaptchaDialog {
    private var mCaptchaError:VKError;
    private var mCaptchaAnswer:EditText;
    private var mCaptchaImage:ImageView;
    private var mProgressBar:ProgressBar;
    private var mDensity:Number;

    public function VKCaptchaDialog(captchaError:VKError) {

        mCaptchaError = captchaError;
    }

    /**
     * Prepare, create and show dialog for displaying captcha
     */
    public function show():void {
        var context:Context= VKUIHelper.getTopActivity();
	    if (context == null) return;
        var innerView:View= LayoutInflater.from(context).inflate(R.layout.vk_captcha_dialog, null);
        assert innerView != null;
        mCaptchaAnswer = EditText(innerView.findViewById(R.id.captchaAnswer));
        mCaptchaImage  = ImageView(innerView.findViewById(R.id.imageView));
        mProgressBar   = ProgressBar(innerView.findViewById(R.id.progressBar));

        mDensity = context.getResources().getDisplayMetrics().density;
        var dialog:AlertDialog= new AlertDialog.Builder(context).setView(innerView).create();
        mCaptchaAnswer.setOnFocusChangeListener(new View.OnFocusChangeListener() {
            
override public function onFocusChange(v:View, hasFocus:Boolean):void {
                if (hasFocus) {
                    dialog.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_VISIBLE);
                }
            }
        });
        mCaptchaAnswer.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            
override public function onEditorAction(textView:TextView, actionId:int, keyEvent:KeyEvent):Boolean {
                if (actionId == EditorInfo.IME_ACTION_SEND) {
                    sendAnswer();
                    dialog.dismiss();
                    return true;
                }
                return false;
            }
        });

        dialog.setButton(AlertDialog.BUTTON_NEGATIVE, context.getString(android.R.string.ok),
                new DialogInterface.OnClickListener() {
                    public function onClick(dialog:DialogInterface, which:int):void {
                        sendAnswer();
                        dialog.dismiss();
                    }
                });
        dialog.setOnCancelListener(new DialogInterface.OnCancelListener() {
            
override public function onCancel(dialogInterface:DialogInterface):void {
                dialog.dismiss();
                mCaptchaError.request.cancel();
            }
        });
        loadImage();
        dialog.show();
    }
    private function sendAnswer():void {
        mCaptchaError.answerCaptcha(mCaptchaAnswer.getText() != null ? mCaptchaAnswer.getText().toString() : "");
    }
    private function loadImage():void {
        var imageOperation:VKImageOperation= new VKImageOperation(mCaptchaError.captchaImg);
        imageOperation.imageDensity     = mDensity;
        imageOperation.setImageOperationListener(new VKImageOperation.VKImageOperationListener() {
            
override public function onComplete(operation:VKImageOperation, image:Bitmap):void {
                mCaptchaImage.setImageBitmap(image);
                mCaptchaImage.setVisibility(View.VISIBLE);
                mProgressBar.setVisibility(View.GONE);
            }

            
override public function onError(operation:VKImageOperation, error:VKError):void {
                loadImage();
            }
        });
        VKHttpClient.enqueueOperation(imageOperation);
    }
}
}