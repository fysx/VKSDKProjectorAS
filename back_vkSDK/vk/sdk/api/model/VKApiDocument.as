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

package com.vk.sdk.api.model {
import android.os.Parcel;
import android.os.Parcelable;
import android.text.TextUtils;

import org.json.JSONException;
import org.json.JSONObject;
import static com.vk.sdk.api.model.VKAttachments.*;

/**
 * A document object describes a document file.
 */
public class VKApiDocument extends VKApiAttachment implements Parcelable, Identifiable {

    /**
     * Document ID.
     */
    public var id:int;

    /**
     * ID of the user or group who uploaded the document.
     */
    public var owner_id:int;

    /**
     * Document title.
     */
    public var title:String;

    /**
     * Document size (in bytes).
     */
    public var size:Number;

    /**
     * Document extension.
     */
    public var ext:String;

    /**
     * Document URL for downloading.
     */
    public var url:String;

    /**
     * URL of the 100x75px image (if the file is graphical).
     */
    public var photo_100:String;

    /**
     * URL of the 130x100px image (if the file is graphical).
     */
    public var photo_130:String;

    /**
     * Array of all photos.
     */
    public var photo:VKPhotoSizes= new VKPhotoSizes();

    /**
     * An access key using for get information about hidden objects.
     */
    public var access_key:String;

    private var mIsGif:Boolean;
    private var mIsImage:Boolean;

	public function VKApiDocument(from:JSONObject) {
		parse(from);
	}
    /**
     * Fills a Doc instance from JSONObject.
     */
    public function parse(jo:JSONObject):VKApiDocument {
        id = jo.optInt("id");
        owner_id = jo.optInt("owner_id");
        title = jo.optString("title");
        size = jo.optLong("size");
        ext = jo.optString("ext");
        url = jo.optString("url");
        access_key = jo.optString("access_key");

        photo_100 = jo.optString("photo_100");
        if(!TextUtils.isEmpty(photo_100)) {
            photo.add(VKApiPhotoSize.create(photo_100, 100, 75));
        }
        photo_130 = jo.optString("photo_130");
        if(!TextUtils.isEmpty(photo_130)) {
            photo.add(VKApiPhotoSize.create(photo_130, 130, 100));
        }
        photo.sort();
        return this;
    }

    /**
     * Creates a Doc instance from Parcel.
     */
    public function VKApiDocument(in:Parcel) {
        this.id = in.readInt();
        this.owner_id = in.readInt();
        this.title = in.readString();
        this.size = in.readLong();
        this.ext = in.readString();
        this.url = in.readString();
        this.photo_100 = in.readString();
        this.photo_130 = in.readString();
        this.photo = in.readParcelable(VKPhotoSizes.class.getClassLoader());
        this.access_key = in.readString();
        this.mIsImage = in.readByte() != 0;
        this.mIsGif = in.readByte() != 0;
    }

    /**
     * Creates empty Doc instance.
     */
    public function VKApiDocument() {

    }

    public function isImage():Boolean {
        mIsImage = mIsImage ||
                "jpg" == (ext) ||
                "jpeg" == (ext) ||
                "png" == (ext) ||
                "bmp" == (ext);
        return mIsImage;
    }

    public function isGif():Boolean {
        mIsGif = mIsGif || "gif" == (ext);
        return mIsGif;
    }

    
override public function getId():int {
        return id;
    }

    
override public function toString():String {
        return title;
    }

    
override public function toAttachmentString():CharSequence {
        var result:StringBuilder= new StringBuilder(TYPE_DOC).append(owner_id).append('_').append(id);
        if(!TextUtils.isEmpty(access_key)) {
            result.append('_');
            result.append(access_key);
        }
        return result;
    }

    
override public function getType():String {
        return TYPE_DOC;
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        dest.writeInt(this.id);
        dest.writeInt(this.owner_id);
        dest.writeString(this.title);
        dest.writeLong(this.size);
        dest.writeString(this.ext);
        dest.writeString(this.url);
        dest.writeString(this.photo_100);
        dest.writeString(this.photo_130);
        dest.writeParcelable(this.photo, flags);
        dest.writeString(this.access_key);
        dest.writeByte(mIsImage ? byte(1 ): byte(0));
        dest.writeByte(mIsGif ? byte(1 ): byte(0));
    }

    public static Creator<VKApiDocument> CREATOR = new Creator<VKApiDocument>() {
        public function createFromParcel(source:Parcel):VKApiDocument {
            return new VKApiDocument(source);
        }

        public VKApiDocument[] newArray(var size:int) {
            return new VKApiDocument[size];
        }
    };
}
}