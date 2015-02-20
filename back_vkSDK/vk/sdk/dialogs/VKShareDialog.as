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
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.support.v4.app.DialogFragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.HorizontalScrollView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.vk.sdk.R;
import com.vk.sdk.VKSdk;
import com.vk.sdk.VKUIHelper;
import com.vk.sdk.api.VKApi;
import com.vk.sdk.api.VKApiConst;
import com.vk.sdk.api.VKError;
import com.vk.sdk.api.VKParameters;
import com.vk.sdk.api.VKRequest;
import com.vk.sdk.api.VKResponse;
import com.vk.sdk.api.httpClient.VKHttpClient;
import com.vk.sdk.api.httpClient.VKImageOperation;
import com.vk.sdk.api.model.VKApiLink;
import com.vk.sdk.api.model.VKApiPhoto;
import com.vk.sdk.api.model.VKAttachments;
import com.vk.sdk.api.model.VKPhotoArray;
import com.vk.sdk.api.model.VKWallPostResult;
import com.vk.sdk.api.photo.VKUploadImage;
import com.vk.sdk.api.photo.VKUploadWallPhotoRequest;
import com.vk.sdk.util.VKStringJoiner;
import com.vk.sdk.util.VKUtil;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Share dialog for making post directly to VK.
 * Now it supports: attaching 1 named link, attaching photos with upload,
 * attaching photos already uploaded to VK.
 * Example usage:
 * <pre>
 * {@code VKPhotoArray photos = new VKPhotoArray();
    photos.add(new VKApiPhoto("photo-47200925_314622346"));
    new VKShareDialog()
        .setText("I created this post with VK Android SDK\nSee additional information below\n#vksdk")
        .setUploadedPhotos(photos)
        .setAttachmentImages(new VKUploadImage[]{
            new VKUploadImage(myBitmap, VKImageParameters.pngImage())
        })
        .setAttachmentLink("VK Android SDK information", "https://vk.com/dev/android_sdk")
        .setShareDialogListener(new VKShareDialog.VKShareDialogListener() {
            public void onVkShareComplete(int postId) {

            }
            public void onVkShareCancel() {

            }
        })
        .show(getFragmentManager(), "VK_SHARE_DIALOG");
 }
 * </pre>
 */
public class VKShareDialog extends DialogFragment {
    static private var SHARE_TEXT_KEY:String= "ShareText";
    static private var SHARE_LINK_KEY:String= "ShareLink";
    static private var SHARE_IMAGES_KEY:String= "ShareImages";
    static private var SHARE_UPLOADED_IMAGES_KEY:String= "ShareUploadedImages";

    static private var SHARE_PHOTO_HEIGHT:int= 100;
    static private var SHARE_PHOTO_CORNER_RADIUS:int= 3;
    static private var SHARE_PHOTO_MARGIN_LEFT:int= 10;

    private var mShareTextField:EditText;
    private var mSendButton:Button;
    private var mSendProgress:ProgressBar;
    private var mPhotoLayout:LinearLayout;
    private var mPhotoScroll:HorizontalScrollView;

    private var mAttachmentLink:UploadingLink;
    private var mAttachmentImages:Array;
    private var mExistingPhotos:VKPhotoArray;
    private var mAttachmentText:CharSequence;

    private var mListener:VKShareDialogListener;

    /**
     * Sets images that will be uploaded with post
     * @param images array of VKUploadImage objects with image data and upload parameters
     * @return Returns this dialog for chaining
     */
    public function setAttachmentImages(images:Array):VKShareDialog {
        mAttachmentImages = images;
        return this;
    }

    /**
     * Sets this dialog post text. User can change that text
     * @param textToPost Text for post
     * @return Returns this dialog for chaining
     */
    public function setText(textToPost:CharSequence):VKShareDialog {
        mAttachmentText = textToPost;
        return this;
    }

    /**
     * Sets dialog link with link name
     * @param linkTitle A small description for your link
     * @param linkUrl Url that link follows
     * @return Returns this dialog for chaining
     */
    public function setAttachmentLink(linkTitle:String, linkUrl:String):VKShareDialog {
        mAttachmentLink = new UploadingLink(linkTitle, linkUrl);
        return this;
    }

    /**
     * Sets array of already uploaded photos from VK, that will be attached to post
     * @param photos Prepared array of {@link VKApiPhoto} objects
     * @return Returns this dialog for chaining
     */
    public function setUploadedPhotos(photos:VKPhotoArray):VKShareDialog {
        mExistingPhotos = photos;
        return this;
    }

    /**
     * Sets this dialog listener
     * @param listener {@link VKShareDialogListener} object
     * @return Returns this dialog for chaining
     */
    public function setShareDialogListener(listener:VKShareDialogListener):VKShareDialog {
        mListener = listener;
        return this;
    }

    
override public function onCreateDialog(savedInstanceState:Bundle):Dialog {
        var context:Context= getActivity();
        var mInternalView:View= LayoutInflater.from(context).inflate(R.layout.vk_share_dialog, null);

        assert mInternalView != null;

        mSendButton             = Button(mInternalView.findViewById(R.id.sendButton));
        mSendProgress           = ProgressBar(mInternalView.findViewById(R.id.sendProgress));
        mPhotoLayout            = LinearLayout(mInternalView.findViewById(R.id.imagesContainer));
        mShareTextField         = EditText(mInternalView.findViewById(R.id.shareText));
        mPhotoScroll            = HorizontalScrollView(mInternalView.findViewById(R.id.imagesScrollView));

        var mAttachmentLinkLayout:LinearLayout= LinearLayout(mInternalView.findViewById(R.id.attachmentLinkLayout));

        mSendButton.setOnClickListener(sendButtonPress);

        //Attachment text
        if (savedInstanceState != null) {
            mShareTextField.setText(savedInstanceState.getString(SHARE_TEXT_KEY));
            mAttachmentLink   = savedInstanceState.getParcelable(SHARE_LINK_KEY);
            mAttachmentImages = (VKUploadImage[]) savedInstanceState.getParcelableArray(SHARE_IMAGES_KEY);
            mExistingPhotos   = savedInstanceState.getParcelable(SHARE_UPLOADED_IMAGES_KEY);
        } else if (mAttachmentText != null) {
            mShareTextField.setText(mAttachmentText);
        }

        //Attachment photos
        mPhotoLayout.removeAllViews();
        if (mAttachmentImages != null) {
            for (VKUploadImage mAttachmentImage : mAttachmentImages) {
                addBitmapToPreview(mAttachmentImage.mImageData);
            }
            mPhotoLayout.setVisibility(View.VISIBLE);
        }

        if (mExistingPhotos != null) {
            processExistingPhotos();
        }
        if (mExistingPhotos == null && mAttachmentImages == null) {
            mPhotoLayout.setVisibility(View.GONE);
        }

        //Attachment link
        if (mAttachmentLink != null) {
            var linkTitle:TextView= TextView(mAttachmentLinkLayout.findViewById(R.id.linkTitle)),
                     linkHost  = TextView(mAttachmentLinkLayout.findViewById(R.id.linkHost));

            linkTitle.setText(mAttachmentLink.linkTitle);
            linkHost.setText(VKUtil.getHost(mAttachmentLink.linkUrl));
            mAttachmentLinkLayout.setVisibility(View.VISIBLE);
        } else {
            mAttachmentLinkLayout.setVisibility(View.GONE);
        }
        var result:Dialog= new Dialog(context);
        result.requestWindowFeature(Window.FEATURE_NO_TITLE);
        result.setContentView(mInternalView);
        result.setCancelable(true);
        result.setOnCancelListener(new DialogInterface.OnCancelListener() {
            
override public function onCancel(dialogInterface:DialogInterface):void {
                if (mListener != null) {
                    mListener.onVkShareCancel();
                }
                VKShareDialog.this.dismiss();
            }
        });
        return result;
    }

    
override public function onStart():void {
        super.onStart();
        var lp:WindowManager.LayoutParams= new WindowManager.LayoutParams();
        lp.copyFrom(getDialog().getWindow().getAttributes());
        lp.height = WindowManager.LayoutParams.WRAP_CONTENT;
        lp.width  = WindowManager.LayoutParams.MATCH_PARENT;
        getDialog().getWindow().setAttributes(lp);
    }

    
override public function onSaveInstanceState(outState:Bundle):void {
        super.onSaveInstanceState(outState);
        outState.putString(SHARE_TEXT_KEY, mShareTextField.getText().toString());
        if (mAttachmentLink != null)
            outState.putParcelable(SHARE_LINK_KEY, mAttachmentLink);
        if (mAttachmentImages != null)
            outState.putParcelableArray(SHARE_IMAGES_KEY, mAttachmentImages);
        if (mExistingPhotos != null)
            outState.putParcelable(SHARE_UPLOADED_IMAGES_KEY, mExistingPhotos);
    }

    private function setIsLoading(loading:Boolean):void {
        if (loading) {
            mSendButton.setVisibility(View.GONE);
            mSendProgress.setVisibility(View.VISIBLE);
            mShareTextField.setEnabled(false);
            mPhotoLayout.setEnabled(false);
        } else {
            mSendButton.setVisibility(View.VISIBLE);
            mSendProgress.setVisibility(View.GONE);
            mShareTextField.setEnabled(true);
            mPhotoLayout.setEnabled(true);
        }
    }
    private function processExistingPhotos():void {
        ArrayList<String> photosToLoad = new ArrayList<String>(mExistingPhotos.size());
        for (VKApiPhoto photo : mExistingPhotos) {
            photosToLoad.add("" + photo.owner_id + '_' + photo.id);
        }
        var photosById:VKRequest= new VKRequest("photos.getById",
                VKParameters.from(VKApiConst.PHOTO_SIZES, 1, VKApiConst.PHOTOS, VKStringJoiner.join(photosToLoad, ",")),
                VKRequest.HttpMethod.GET, VKPhotoArray.class);
        photosById.executeWithListener(new VKRequest.VKRequestListener() {
            
override public function onComplete(response:VKResponse):void {
                var photos:VKPhotoArray= VKPhotoArray(response.parsedModel);
                for (VKApiPhoto photo : photos) {
                    if (photo.src.getByType('q') != null) {
                        loadAndAddPhoto(photo.src.getByType('q'));
                    } else if (photo.src.getByType('p') != null) {
                        loadAndAddPhoto(photo.src.getByType('p'));
                    } else if (photo.src.getByType('m') != null) {
                        loadAndAddPhoto(photo.src.getByType('m'));
                    }
                    //else ignore that strange photo
                }
            }

            
override public function onError(error:VKError):void {
                if (VKSdk.DEBUG) {
                    Log.w(VKSdk.SDK_TAG, "Cannot load photos for share: " + error.toString());
                }
            }
        });
    }
    private function loadAndAddPhoto(photoUrl:String):void {
        var op:VKImageOperation= new VKImageOperation(photoUrl);
        op.setImageOperationListener(new VKImageOperation.VKImageOperationListener() {
            
override public function onComplete(operation:VKImageOperation, image:Bitmap):void {
                addBitmapToPreview(image);
            }
        });
        VKHttpClient.enqueueOperation(op);
    }
    private function addBitmapToPreview(sourceBitmap:Bitmap):void {
        if (getActivity() == null) return;
        var b:Bitmap= VKUIHelper.getRoundedCornerBitmap(sourceBitmap, SHARE_PHOTO_HEIGHT, SHARE_PHOTO_CORNER_RADIUS);
        var iv:ImageView= new ImageView(getActivity());
        iv.setImageBitmap(b);
        iv.setAdjustViewBounds(true);

        var params:LinearLayout.LayoutParams= new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        params.setMargins(mPhotoLayout.getChildCount() > 0? SHARE_PHOTO_MARGIN_LEFT : 0, 0, 0, 0);

        mPhotoLayout.addView(iv, params);
        mPhotoLayout.invalidate();
        mPhotoScroll.invalidate();
    }
    private function makePostWithAttachments(attachments:VKAttachments):void {

        if (attachments == null) {
            attachments = new VKAttachments();
        }
        if (mExistingPhotos != null) {
            attachments.addAll(mExistingPhotos);
        }
        if (mAttachmentLink != null) {
            attachments.add(new VKApiLink(mAttachmentLink.linkUrl));
        }
        var message:String= mShareTextField.getText().toString();

        var userId:Long= Long.parseLong(VKSdk.getAccessToken().userId);
        var wallPost:VKRequest= VKApi.wall().post(VKParameters.from(VKApiConst.OWNER_ID, userId, VKApiConst.MESSAGE, message, VKApiConst.ATTACHMENTS, attachments.toAttachmentsString()));
        wallPost.executeWithListener(new VKRequest.VKRequestListener() {
            
override public function onError(error:VKError):void {
                setIsLoading(false);
            }

            
override public function onComplete(response:VKResponse):void {
                setIsLoading(false);
                var res:VKWallPostResult= VKWallPostResult(response.parsedModel);
                if (mListener != null) {
                    mListener.onVkShareComplete(res.post_id);
                }
                dismiss();
            }
        });
    }

    var sendButtonPress:View.OnClickListener= new View.OnClickListener() {
        
override public function onClick(view:View):void {
            setIsLoading(true);
            if (mAttachmentImages != null) {
                var userId:Long= Long.parseLong(VKSdk.getAccessToken().userId);
                var photoRequest:VKUploadWallPhotoRequest= new VKUploadWallPhotoRequest(mAttachmentImages, userId, 0);
                photoRequest.executeWithListener(new VKRequest.VKRequestListener() {
                    
override public function onComplete(response:VKResponse):void {
                        var photos:VKPhotoArray= VKPhotoArray(response.parsedModel);
                        var attachments:VKAttachments= new VKAttachments(photos);
                        makePostWithAttachments(attachments);
                    }

                    
override public function onError(error:VKError):void {
                        setIsLoading(false);
                    }
                });
            } else {
                makePostWithAttachments(null);
            }
        }
    };

    
override public function onCancel(dialog:DialogInterface):void {
        super.onCancel(dialog);
        if (mListener != null) {
            mListener.onVkShareCancel();
        }
    }
}

import android.os.Parcel;
import android.os.Parcelable;
import com.vk.sdk.R;

    static private 
internal class UploadingLink implements Parcelable {
        public var linkTitle:String, linkUrl;
        public function UploadingLink(title:String, url:String) {
            linkTitle = title;
            linkUrl = url;
        }

        
override public function describeContents():int {
            return 0;
        }

        
override public function writeToParcel(dest:Parcel, flags:int):void {
            dest.writeString(this.linkTitle);
            dest.writeString(this.linkUrl);
        }

        private function UploadingLink(in:Parcel) {
            this.linkTitle = in.readString();
            this.linkUrl = in.readString();
        }

        public static Parcelable.Creator<UploadingLink> CREATOR = new Parcelable.Creator<UploadingLink>() {
            public function createFromParcel(source:Parcel):UploadingLink {
                return new UploadingLink(source);
            }

            public UploadingLink[] newArray(var size:int) {
                return new UploadingLink[size];
            }
        };
    }

import android.app.Dialog;

    public static 
internal interface VKShareDialogListener {
        public function onVkShareComplete(postId:int):void ;
        public function onVkShareCancel():void ;
    }
}