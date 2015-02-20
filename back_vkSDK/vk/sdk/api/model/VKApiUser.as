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
 * User.java
 * vk-android-sdk
 *
 * Created by Babichev Vitaly on 18.01.14.
 * Copyright (c) 2014 VK. All rights reserved.
 */
package com.vk.sdk.api.model {
import android.os.Parcel;
import android.text.TextUtils;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * User object describes a user profile.
 */
public class VKApiUser extends VKApiOwner implements android.os.Parcelable {

    /**
     * Field name for {@link #online} param.
     */
    public static var FIELD_ONLINE:String= "online";

    /**
     * Field name for {@link #online_mobile} param.
     */
    public static var FIELD_ONLINE_MOBILE:String= "online_mobile";

    /**
     * Field name for {@link #photo_50} param.
     */
    public static var FIELD_PHOTO_50:String= "photo_50";

    /**
     * Field name for {@link #photo_100} param.
     */
    public static var FIELD_PHOTO_100:String= "photo_100";

    /**
     * Field name for {@link #photo_200} param.
     */
    public static var FIELD_PHOTO_200:String= "photo_200";

    /**
     * All required for fill all fields.
     */
    public static var FIELDS_DEFAULT:String= TextUtils.join(",", new String[]{FIELD_ONLINE, FIELD_ONLINE_MOBILE, FIELD_PHOTO_50, FIELD_PHOTO_100, FIELD_PHOTO_200});

    /**
     * First name of user.
     */
    public var first_name:String= "DELETED";

    /**
     * Last name of user.
     */
    public var last_name:String= "DELETED";

    /**
     * Information whether the user is online.
     */
    public var online:Boolean;

    /**
     * If user utilizes a mobile application or site mobile version, it returns online_mobile as additional.
     */
    public var online_mobile:Boolean;

    /**
     * URL of default square photo of the user with 50 pixels in width.
     */
    public var photo_50:String= "http://vk.com/images/camera_c.gif";

    /**
     * URL of default square photo of the user with 100 pixels in width.
     */
    public var photo_100:String= "http://vk.com/images/camera_b.gif";

    /**
     * URL of default square photo of the user with 200 pixels in width.
     */
    public var photo_200:String= "http://vk.com/images/camera_a.gif";

    /**
     * {@link #photo_50}, {@link #photo_100}, {@link #photo_200} included here in Photo Sizes format.
     */
    public var photo:VKPhotoSizes= new VKPhotoSizes();

	public function VKApiUser(from:JSONObject) {
		parse(from);
	}
    /**
     * Fills an user object from server response.
     */
    public function parse(from:JSONObject):VKApiUser {
        super.parse(from);
        first_name = from.optString("first_name", first_name);
        last_name = from.optString("last_name", last_name);
        online = ParseUtils.parseBoolean(from, FIELD_ONLINE);
        online_mobile = ParseUtils.parseBoolean(from, FIELD_ONLINE_MOBILE);

        photo_50 = from.optString(FIELD_PHOTO_50, photo_50);
        if(!TextUtils.isEmpty(photo_50)) {
            photo.add(VKApiPhotoSize.create(photo_50, 50));
        }
        photo_100 = from.optString(FIELD_PHOTO_100, photo_100);
        if(!TextUtils.isEmpty(photo_100)) {
            photo.add(VKApiPhotoSize.create(photo_100, 100));
        }
        photo_200 = from.optString(FIELD_PHOTO_200, null);
        if(!TextUtils.isEmpty(photo_200)) {
            photo.add(VKApiPhotoSize.create(photo_200, 200));
        }
        photo.sort();
        return this;
    }

    /**
     * Creates an User instance from Parcel.
     */
    public function VKApiUser(in:Parcel) {
        super(in);
        this.first_name = in.readString();
        this.last_name = in.readString();
        this.online = in.readByte() != 0;
        this.online_mobile = in.readByte() != 0;
        this.photo_50 = in.readString();
        this.photo_100 = in.readString();
        this.photo_200 = in.readString();
        this.photo = in.readParcelable(VKPhotoSizes.class.getClassLoader());
        this.full_name = in.readString();
    }

    /**
     * Creates empty User instance.
     */
    public function VKApiUser() {

    }

    private var full_name:String;

    /**
     * @return full user name
     */
    
override public function toString():String {
        if(full_name == null) {
            full_name = first_name + ' ' + last_name;
        }
        return full_name;
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        super.writeToParcel(dest, flags);
        dest.writeString(this.first_name);
        dest.writeString(this.last_name);
        dest.writeByte(online ? byte(1 ): byte(0));
        dest.writeByte(online_mobile ? byte(1 ): byte(0));
        dest.writeString(this.photo_50);
        dest.writeString(this.photo_100);
        dest.writeString(this.photo_200);
        dest.writeParcelable(this.photo, flags);
        dest.writeString(this.full_name);
    }

    public static Creator<VKApiUser> CREATOR = new Creator<VKApiUser>() {
        public function createFromParcel(source:Parcel):VKApiUser {
            return new VKApiUser(source);
        }

        public VKApiUser[] newArray(var size:int) {
            return new VKApiUser[size];
        }
    };
}
}