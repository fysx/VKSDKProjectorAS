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

/**
 * Video.java
 * VK Dev
 *
 * Created by Babichev Vitaly on 29.09.13.
 * Copyright (c) 2013 VK. All rights reserved.
 */
package com.vk.sdk.api.model {
import android.os.Parcel;
import android.os.Parcelable;
import android.text.TextUtils;

import org.json.JSONException;
import org.json.JSONObject;

import static com.vk.sdk.api.model.ParseUtils.parseBoolean;
import static com.vk.sdk.api.model.VKAttachments.*;

/**
 * A video object describes an video file.
 */
public class VKApiVideo extends VKAttachments.VKApiAttachment implements Parcelable, Identifiable {

    /**
     * Video ID.
     */
    public var id:int;

    /**
     * Video owner ID.
     */
    public var owner_id:int;

    /**
     * Video album ID.
     */
    public var album_id:int;

    /**
     * Video title.
     */
    public var title:String;

    /**
     * Text describing video.
     */
    public var description:String;

    /**
     * Duration of the video in seconds.
     */
    public var duration:int;

    /**
     * String with video+vid key.
     */
    public var link:String;

    /**
     * Date when the video was added, as unixtime.
     */
    public var date:Number;

    /**
     * Number of views of the video.
     */
    public var views:int;

    /**
     * URL of the page with a player that can be used to play a video in the browser.
     * Flash and HTML5 video players are supported; the player is always zoomed to fit
     * the window size.
     */
    public var player:String;

    /**
     * URL of the video cover image with the size of 130x98px.
     */
    public var photo_130:String;

    /**
     * URL of the video cover image with the size of 320x240px.
     */
    public var photo_320:String;

    /**
     * URL of the video cover image with the size of 640x480px (if available).
     */
    public var photo_640:String;

    /**
     * Array of all photos.
     */
    public var photo:VKPhotoSizes= new VKPhotoSizes();

    /**
     * An access key using for get information about hidden objects.
     */
    public var access_key:String;

    /**
     * Number of comments on the video.
     */
    public var comments:int;

    /**
     * Whether the current user can comment on the video
     */
    public var can_comment:Boolean;

    /**
     * Whether the current user can repost this video
     */
    public var can_repost:Boolean;

    /**
     * Information whether the current user liked the video.
     */
    public var user_likes:Boolean;

    /**
     * Information whether the the video should be repeated.
     */
    public var repeat:Boolean;

    /**
     * Number of likes on the video.
     */
    public var likes:int;

    /**
     * Privacy to view of this video.
     */
    public var privacy_view:int;

    /**
     * Privacy to comment of this video.
     */
    public var privacy_comment:int;

    /**
     * URL of video with height of 240 pixels. Returns only if you use direct auth.
     */
    public var mp4_240:String;

    /**
     * URL of video with height of 360 pixels. Returns only if you use direct auth.
     */
    public var mp4_360:String;

    /**
     * URL of video with height of 480 pixels. Returns only if you use direct auth.
     */
    public var mp4_480:String;

    /**
     * URL of video with height of 720 pixels. Returns only if you use direct auth.
     */
    public var mp4_720:String;

    /**
     * URL of the external video link.
     */
    public var external:String;

	public function VKApiVideo(from:JSONObject) {
		parse(from);
	}
    /**
     * Fills a Video instance from JSONObject.
     */
    public function parse(from:JSONObject):VKApiVideo {
        id = from.optInt("id");
        owner_id = from.optInt("owner_id");
        title = from.optString("title");
        description = from.optString("description");
        duration = from.optInt("duration");
        link = from.optString("link");
        date = from.optLong("date");
        views = from.optInt("views");
        comments = from.optInt("comments");
        player = from.optString("player");
        access_key = from.optString("access_key");
        album_id = from.optInt("album_id");

        var likes:JSONObject= from.optJSONObject("likes");
        if(likes != null) {
            this.likes = likes.optInt("count");
            user_likes = parseBoolean(likes, "user_likes");
        }
        can_comment = parseBoolean(from, "can_comment");
        can_repost = parseBoolean(from, "can_repost");
        repeat = parseBoolean(from, "repeat");

        privacy_view = VKPrivacy.parsePrivacy(from.optJSONObject("privacy_view"));
        privacy_comment = VKPrivacy.parsePrivacy(from.optJSONObject("privacy_comment"));

        var files:JSONObject= from.optJSONObject("files");
        if(files != null) {
            mp4_240 = files.optString("mp4_240");
            mp4_360 = files.optString("mp4_360");
            mp4_480 = files.optString("mp4_480");
            mp4_720 = files.optString("mp4_720");
            external = files.optString("external");
        }

        photo_130 = from.optString("photo_130");
        if(!TextUtils.isEmpty(photo_130)) {
            photo.add(VKApiPhotoSize.create(photo_130, 130));
        }

        photo_320 = from.optString("photo_320");
        if(!TextUtils.isEmpty(photo_320)) {
            photo.add(VKApiPhotoSize.create(photo_320, 320));
        }

        photo_640 = from.optString("photo_640");
        if(!TextUtils.isEmpty(photo_640)) {
            photo.add(VKApiPhotoSize.create(photo_640, 640));
        }
        return this;
    }

    /**
     * Creates a Video instance from Parcel.
     */
    public function VKApiVideo(in:Parcel) {
        this.id = in.readInt();
        this.owner_id = in.readInt();
        this.album_id = in.readInt();
        this.title = in.readString();
        this.description = in.readString();
        this.duration = in.readInt();
        this.link = in.readString();
        this.date = in.readLong();
        this.views = in.readInt();
        this.player = in.readString();
        this.photo_130 = in.readString();
        this.photo_320 = in.readString();
        this.photo_640 = in.readString();
        this.photo = in.readParcelable(VKPhotoSizes.class.getClassLoader());
        this.access_key = in.readString();
        this.comments = in.readInt();
        this.can_comment = in.readByte() != 0;
        this.can_repost = in.readByte() != 0;
        this.user_likes = in.readByte() != 0;
        this.repeat = in.readByte() != 0;
        this.likes = in.readInt();
        this.privacy_view = in.readInt();
        this.privacy_comment = in.readInt();
        this.mp4_240 = in.readString();
        this.mp4_360 = in.readString();
        this.mp4_480 = in.readString();
        this.mp4_720 = in.readString();
        this.external = in.readString();
    }

    /**
     * Creates empty Video instance.
     */
    public function VKApiVideo() {

    }

    
override public function getId():int {
        return id;
    }

    
override public function toAttachmentString():CharSequence {
        var result:StringBuilder= new StringBuilder(TYPE_VIDEO).append(owner_id).append('_').append(id);
        if(!TextUtils.isEmpty(access_key)) {
            result.append('_');
            result.append(access_key);
        }
        return result;
    }

    
override public function getType():String {
        return TYPE_VIDEO;
    }

    
override public function toString():String {
        return title;
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        dest.writeInt(this.id);
        dest.writeInt(this.owner_id);
        dest.writeInt(this.album_id);
        dest.writeString(this.title);
        dest.writeString(this.description);
        dest.writeInt(this.duration);
        dest.writeString(this.link);
        dest.writeLong(this.date);
        dest.writeInt(this.views);
        dest.writeString(this.player);
        dest.writeString(this.photo_130);
        dest.writeString(this.photo_320);
        dest.writeString(this.photo_640);
        dest.writeParcelable(this.photo, flags);
        dest.writeString(this.access_key);
        dest.writeInt(this.comments);
        dest.writeByte(can_comment ? byte(1 ): byte(0));
        dest.writeByte(can_repost ? byte(1 ): byte(0));
        dest.writeByte(user_likes ? byte(1 ): byte(0));
        dest.writeByte(repeat ? byte(1 ): byte(0));
        dest.writeInt(this.likes);
        dest.writeInt(this.privacy_view);
        dest.writeInt(this.privacy_comment);
        dest.writeString(this.mp4_240);
        dest.writeString(this.mp4_360);
        dest.writeString(this.mp4_480);
        dest.writeString(this.mp4_720);
        dest.writeString(this.external);
    }

    public static Creator<VKApiVideo> CREATOR = new Creator<VKApiVideo>() {
        public function createFromParcel(source:Parcel):VKApiVideo {
            return new VKApiVideo(source);
        }

        public VKApiVideo[] newArray(var size:int) {
            return new VKApiVideo[size];
        }
    };
}
}