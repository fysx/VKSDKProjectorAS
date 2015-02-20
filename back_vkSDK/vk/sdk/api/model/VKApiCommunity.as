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
import android.text.TextUtils;

import org.json.JSONObject;

/**
 * Community object describes a community.
 */
public class VKApiCommunity extends VKApiOwner implements android.os.Parcelable, Identifiable {

    private static var TYPE_GROUP:String= "group";
    private static var TYPE_PAGE:String= "page";
    private static var TYPE_EVENT:String= "event";
    static var PHOTO_50:String= "http://vk.com/images/community_50.gif";
    static var PHOTO_100:String= "http://vk.com/images/community_100.gif";

    /**
     * Community name
     */
    public var name:String;

    /**
     * Screen name of the community page (e.g. apiclub or club1).
     */
    public var screen_name:String;

    /**
     * Whether the community is closed
     * @see {@link com.vk.sdk.api.model.VKApiCommunity.Status}
     */
    public var is_closed:int;

    /**
     * Whether a user is the community manager
     */
    public var is_admin:Boolean;

    /**
     * Rights of the user
     * @see {@link AdminLevel}
     */
    public var admin_level:int;

    /**
     * Whether a user is a community member
     */
    public var is_member:Boolean;

    /**
     * Community type
     * @see {@link com.vk.sdk.api.model.VKApiCommunity.Type}
     */
    public var type:int;

    /**
     * URL of the 50px-wide community logo.
     */
    public var photo_50:String;

    /**
     * URL of the 100px-wide community logo.
     */
    public var photo_100:String;

    /**
     * URL of the 200px-wide community logo.
     */
    public var photo_200:String;

    /**
     * {@link #photo_50}, {@link #photo_100}, {@link #photo_200} included here in Photo Sizes format.
     */
    public var photo:VKPhotoSizes= new VKPhotoSizes();

	public function VKApiCommunity(from:JSONObject) {
		parse(from);
	}
    /**
     * Fills a community object from JSONObject
     * @param from JSONObject describes community object according with VK Docs.
     */
    public function parse(from:JSONObject):VKApiCommunity {
        super.parse(from);
        name = from.optString("name");
        screen_name = from.optString("screen_name", String.format("club%d", Math.abs(id)));
        is_closed = from.optInt("is_closed");
        is_admin = ParseUtils.parseBoolean(from, "is_admin");
        admin_level = from.optInt("admin_level");
        is_member = ParseUtils.parseBoolean(from, "is_member");

        photo_50 = from.optString("photo_50", PHOTO_50);
        if(!TextUtils.isEmpty(photo_50)) {
            photo.add(VKApiPhotoSize.create(photo_50, 50));
        }
        photo_100 = from.optString("photo_100", PHOTO_100);
        if(!TextUtils.isEmpty(photo_100)) {
            photo.add(VKApiPhotoSize.create(photo_100, 100));
        }
        photo_200 = from.optString("photo_200", null);
        if(!TextUtils.isEmpty(photo_200)) {
            photo.add(VKApiPhotoSize.create(photo_200, 200));
        }
        photo.sort();

        var type:String= from.optString("type", "group");
        if(TYPE_GROUP == (type)) {
            this.type = Type.GROUP;
        } else if(TYPE_PAGE == (type)) {
            this.type = Type.PAGE;
        } else if(TYPE_EVENT == (type)) {
            this.type = Type.EVENT;
        }
        return this;
    }

    /**
     * Creates a community object from Parcel
     */
    public function VKApiCommunity(in:Parcel) {
        super(in);
        this.name = in.readString();
        this.screen_name = in.readString();
        this.is_closed = in.readInt();
        this.is_admin = in.readByte() != 0;
        this.admin_level = in.readInt();
        this.is_member = in.readByte() != 0;
        this.type = in.readInt();
        this.photo_50 = in.readString();
        this.photo_100 = in.readString();
        this.photo_200 = in.readString();
        this.photo = in.readParcelable(VKPhotoSizes.class.getClassLoader());
    }

    /**
     * Creates empty Community instance.
     */
    public function VKApiCommunity() {

    }

    
override public function toString():String {
        return name;
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        super.writeToParcel(dest, flags);
        dest.writeString(this.name);
        dest.writeString(this.screen_name);
        dest.writeInt(this.is_closed);
        dest.writeByte(is_admin ? byte(1 ): byte(0));
        dest.writeInt(this.admin_level);
        dest.writeByte(is_member ? byte(1 ): byte(0));
        dest.writeInt(this.type);
        dest.writeString(this.photo_50);
        dest.writeString(this.photo_100);
        dest.writeString(this.photo_200);
        dest.writeParcelable(this.photo, flags);
    }

    public static Creator<VKApiCommunity> CREATOR = new Creator<VKApiCommunity>() {
        public function createFromParcel(source:Parcel):VKApiCommunity {
            return new VKApiCommunity(source);
        }

        public VKApiCommunity[] newArray(var size:int) {
            return new VKApiCommunity[size];
        }
    }
}

;

    /**
     * Access level to manage community.
     */
    public static 
internal class AdminLevel {
        private function AdminLevel() {}
        public static var MODERATOR:int= 1;
        public static var EDITOR:int= 2;
        public static var ADMIN:int= 3;
    }

    /**
     * Privacy status of the group.
     */
    public static 
internal class Status {
        private function Status() {}
        public static var OPEN:int= 0;
        public static var CLOSED:int= 1;
        public static var PRIVATE:int= 2;
    }

    /**
     * Types of communities.
     */
    public static 
internal class Type {
        private function Type() {}
        public static var GROUP:int= 0;
        public static var PAGE:int= 1;
        public static var EVENT:int= 2;
    }
}