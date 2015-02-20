/**
 * AppInfo.java
 * vk-android-sdk
 *
 * Created by Babichev Vitaly on 19.01.14.
 * Copyright (c) 2014 VK. All rights reserved.
 */
package com.vk.sdk.api.model {
import android.os.Parcel;
import android.text.TextUtils;
import org.json.JSONObject;
import static com.vk.sdk.api.model.VKAttachments.*;

/**
 * Describes information about application in the post.
 */
public class VKApiApplicationContent extends VKApiAttachment implements android.os.Parcelable {

    /**
     * ID of the application that posted on the wall;
     */
    public var id:int;

    /**
     * Application name
     */
    public var name:String;

    /**
     * Image URL for preview with maximum width in 130px
     */
    public var photo_130:String;

    /**
     * Image URL for preview with maximum width in 130px
     */
    public var photo_604:String;

    /**
     * Image URL for preview;
     */
    public var photo:VKPhotoSizes= new VKPhotoSizes();

	public function VKApiApplicationContent(source:JSONObject) {
		parse(source);
	}
    /**
     * Fills an ApplicationContent instance from JSONObject.
     */
    public function parse(source:JSONObject):VKApiApplicationContent {
        id = source.optInt("id");
        name = source.optString("name");
        photo_130 = source.optString("photo_130");
        if(!TextUtils.isEmpty(photo_130)) {
            photo.add(VKApiPhotoSize.create(photo_130, 130));
        }
        photo_604 = source.optString("photo_604");
        if(!TextUtils.isEmpty(photo_604)) {
            photo.add(VKApiPhotoSize.create(photo_604, 604));
        }
        return this;
    }

    /**
     * Creates an ApplicationContent instance from Parcel.
     */
    public function VKApiApplicationContent(in:Parcel) {
        this.id = in.readInt();
        this.name = in.readString();
        this.photo_130 = in.readString();
        this.photo_604 = in.readString();
        this.photo = in.readParcelable(VKPhotoSizes.class.getClassLoader());
    }

    /**
     * Creates empty ApplicationContent instance.
     */
    public function VKApiApplicationContent() {

    }

    
override public function toAttachmentString():CharSequence {
        throw new UnsupportedOperationException("Attaching app info is not supported by VK.com API");
    }

    
override public function getType():String {
        return TYPE_APP;
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        dest.writeInt(this.id);
        dest.writeString(this.name);
        dest.writeString(this.photo_130);
        dest.writeString(this.photo_604);
        dest.writeParcelable(this.photo, flags);
    }

    public static Creator<VKApiApplicationContent> CREATOR = new Creator<VKApiApplicationContent>() {
        public function createFromParcel(source:Parcel):VKApiApplicationContent {
            return new VKApiApplicationContent(source);
        }

        public VKApiApplicationContent[] newArray(var size:int) {
            return new VKApiApplicationContent[size];
        }
    };

    
override public function getId():int {
        return id;
    }
}
}