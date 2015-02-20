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
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import static com.vk.sdk.api.model.ParseUtils.parseBoolean;
import static com.vk.sdk.api.model.ParseUtils.parseInt;
import static com.vk.sdk.api.model.VKAttachments.*;

/**
 * Describes a photo object from VK.
 */
public class VKApiPhoto extends VKAttachments.VKApiAttachment implements Parcelable, Identifiable {

    /**
     * Photo ID, positive number
     */
    public var id:int;

    /**
     * Photo album ID.
     */
    public var album_id:int;

    /**
     * ID of the user or community that owns the photo.
     */
    public var owner_id:int;

    /**
     * Width (in pixels) of the original photo.
     */
    public var width:int;

    /**
     * Height (in pixels) of the original photo.
     */
    public var height:int;

    /**
     * Text describing the photo.
     */
    public var text:String;

    /**
     * Date (in Unix time) the photo was added.
     */
    public var date:Number;

    /**
     * URL of image with maximum size 75x75px.
     */
    public var photo_75:String;

    /**
     * URL of image with maximum size 130x130px.
     */
    public var photo_130:String;

    /**
     * URL of image with maximum size 604x604px.
     */
    public var photo_604:String;

    /**
     * URL of image with maximum size 807x807px.
     */
    public var photo_807:String;

    /**
     * URL of image with maximum size 1280x1024px.
     */
    public var photo_1280:String;

    /**
     * URL of image with maximum size 2560x2048px.
     */
    public var photo_2560:String;

    /**
     * All photo thumbs in photo sizes.
     * It has data even if server returned them without {@code PhotoSizes} format.
     */
    public var src:VKPhotoSizes= new VKPhotoSizes();

    /**
     * Information whether the current user liked the photo.
     */
    public var user_likes:Boolean;

    /**
     * Whether the current user can comment on the photo
     */
    public var can_comment:Boolean;

    /**
     * Number of likes on the photo.
     */
    public var likes:int;

    /**
     * Number of comments on the photo.
     */
    public var comments:int;

    /**
     * Number of tags on the photo.
     */
    public var tags:int;

    /**
     * An access key using for get information about hidden objects.
     */
    public var access_key:String;

	public function VKApiPhoto(from:JSONObject) {
		parse(from);
	}
    /**
     * Fills a Photo instance from JSONObject.
     */
    public function parse(from:JSONObject):VKApiPhoto {
        album_id = from.optInt("album_id");
        date = from.optLong("date");
        height = from.optInt("height");
        width = from.optInt("width");
        owner_id = from.optInt("owner_id");
        id = from.optInt("id");
        text = from.optString("text");
        access_key = from.optString("access_key");

        photo_75 = from.optString("photo_75");
        photo_130 = from.optString("photo_130");
        photo_604 = from.optString("photo_604");
        photo_807 = from.optString("photo_807");
        photo_1280 = from.optString("photo_1280");
        photo_2560 = from.optString("photo_2560");

        var likes:JSONObject= from.optJSONObject("likes");
        this.likes = ParseUtils.parseInt(likes, "count");
        this.user_likes = ParseUtils.parseBoolean(likes, "user_likes");
        comments = parseInt(from.optJSONObject("comments"), "count");
        tags = parseInt(from.optJSONObject("tags"), "count");
        can_comment = parseBoolean(from, "can_comment");

        src.setOriginalDimension(width, height);
        var photo_sizes:JSONArray= from.optJSONArray("sizes");
        if(photo_sizes != null) {
            src.fill(photo_sizes);
        } else {
            if(!TextUtils.isEmpty(photo_75)) {
                src.add(VKApiPhotoSize.create(photo_75, VKApiPhotoSize.S, width, height));
            }
            if(!TextUtils.isEmpty(photo_130)) {
                src.add(VKApiPhotoSize.create(photo_130, VKApiPhotoSize.M, width, height));
            }
            if(!TextUtils.isEmpty(photo_604)) {
                src.add(VKApiPhotoSize.create(photo_604, VKApiPhotoSize.X, width, height));
            }
            if(!TextUtils.isEmpty(photo_807)) {
                src.add(VKApiPhotoSize.create(photo_807, VKApiPhotoSize.Y, width, height));
            }
            if(!TextUtils.isEmpty(photo_1280)) {
                src.add(VKApiPhotoSize.create(photo_1280, VKApiPhotoSize.Z, width, height));
            }
            if(!TextUtils.isEmpty(photo_2560)) {
                src.add(VKApiPhotoSize.create(photo_2560, VKApiPhotoSize.W, width, height));
            }
            src.sort();
        }
        return this;
    }

    /**
     * Creates a Photo instance from Parcel.
     */
    public function VKApiPhoto(in:Parcel) {
        this.id = in.readInt();
        this.album_id = in.readInt();
        this.owner_id = in.readInt();
        this.width = in.readInt();
        this.height = in.readInt();
        this.text = in.readString();
        this.date = in.readLong();
        this.src = in.readParcelable(VKPhotoSizes.class.getClassLoader());
        this.photo_75 = in.readString();
        this.photo_130 = in.readString();
        this.photo_604 = in.readString();
        this.photo_807 = in.readString();
        this.photo_1280 = in.readString();
        this.photo_2560 = in.readString();
        this.user_likes = in.readByte() != 0;
        this.can_comment = in.readByte() != 0;
        this.likes = in.readInt();
        this.comments = in.readInt();
        this.tags = in.readInt();
        this.access_key = in.readString();
    }

    /**
     * Init photo object with attachment string like photo45898586_334180483
     * @param photoAttachmentString string of format photo[OWNER_ID]_[PHOTO_ID]
     */
    public function VKApiPhoto(photoAttachmentString:String) {
        if (photoAttachmentString.startsWith(TYPE_PHOTO)) {
            photoAttachmentString = photoAttachmentString.substring(TYPE_PHOTO.length());
            var ids:Array= photoAttachmentString.split("_");
            this.owner_id = Integer.parseInt(ids[0]);
            this.id       = Integer.parseInt(ids[1]);
        }
    }

    /**
     * Creates empty Photo instance.
     */
    public function VKApiPhoto() {

    }

    
override public function getId():int {
        return id;
    }

    
override public function toAttachmentString():CharSequence {
        var result:StringBuilder= new StringBuilder(TYPE_PHOTO).append(owner_id).append('_').append(id);
        if(!TextUtils.isEmpty(access_key)) {
            result.append('_');
            result.append(access_key);
        }
        return result;
    }

    
override public function getType():String {
        return TYPE_PHOTO;
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        dest.writeInt(this.id);
        dest.writeInt(this.album_id);
        dest.writeInt(this.owner_id);
        dest.writeInt(this.width);
        dest.writeInt(this.height);
        dest.writeString(this.text);
        dest.writeLong(this.date);
        dest.writeParcelable(this.src, flags);
        dest.writeString(this.photo_75);
        dest.writeString(this.photo_130);
        dest.writeString(this.photo_604);
        dest.writeString(this.photo_807);
        dest.writeString(this.photo_1280);
        dest.writeString(this.photo_2560);
        dest.writeByte(user_likes ? byte(1 ): byte(0));
        dest.writeByte(can_comment ? byte(1 ): byte(0));
        dest.writeInt(this.likes);
        dest.writeInt(this.comments);
        dest.writeInt(this.tags);
        dest.writeString(this.access_key);
    }

    public static Creator<VKApiPhoto> CREATOR = new Creator<VKApiPhoto>() {
        public function createFromParcel(source:Parcel):VKApiPhoto {
            return new VKApiPhoto(source);
        }

        public VKApiPhoto[] newArray(var size:int) {
            return new VKApiPhoto[size];
        }
    };

}
}