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
 * Link.java
 * vk-android-sdk
 *
 * Created by Babichev Vitaly on 19.01.14.
 * Copyright (c) 2014 VK. All rights reserved.
 */
package com.vk.sdk.api.model {
import android.os.Parcel;

import org.json.JSONException;
import org.json.JSONObject;
import static com.vk.sdk.api.model.VKAttachments.*;

/**
 * A link object describes a link attachment
 */
public class VKApiLink extends VKAttachments.VKApiAttachment implements android.os.Parcelable {

    /**
     * Link URL
     */
    public var url:String;

    /**
     * Link title
     */
    public var title:String;

    /**
     * Link description;
     */
    public var description:String;

    /**
     * Image preview URL for the link (if any).
     */
    public var image_src:String;

    /**
     * ID wiki page with content for the preview of the page contents
     * ID is returned as "ownerid_pageid".
     */
    public var preview_page:String;

    /**
     * Creates link attachment to attach it to the post
     * @param url full URL of link
     */
    public function VKApiLink(url:String) {
        this.url = url;
    }

	public function VKApiLink(from:JSONObject) {
		parse(from);
	}
    /**
     * Fills a Link instance from JSONObject.
     */
    public function parse(source:JSONObject):VKApiLink {
        url = source.optString("url");
        title = source.optString("title");
        description = source.optString("description");
        image_src = source.optString("image_src");
        preview_page = source.optString("preview_page");
        return this;
    }

    /**
     * Creates a Link instance from Parcel.
     */
    private function VKApiLink(in:Parcel) {
        this.url = in.readString();
        this.title = in.readString();
        this.description = in.readString();
        this.image_src = in.readString();
        this.preview_page = in.readString();
    }

    /**
     * Creates empty Link instance.
     */
    public function VKApiLink() {

    }

    
override public function toAttachmentString():CharSequence {
        return url;
    }

    
override public function getType():String {
        return TYPE_LINK;
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        dest.writeString(this.url);
        dest.writeString(this.title);
        dest.writeString(this.description);
        dest.writeString(this.image_src);
        dest.writeString(this.preview_page);
    }

    public static Creator<VKApiLink> CREATOR = new Creator<VKApiLink>() {
        public function createFromParcel(source:Parcel):VKApiLink {
            return new VKApiLink(source);
        }

        public VKApiLink[] newArray(var size:int) {
            return new VKApiLink[size];
        }
    };

    
override public function getId():int {
        return 0;
    }
}
}