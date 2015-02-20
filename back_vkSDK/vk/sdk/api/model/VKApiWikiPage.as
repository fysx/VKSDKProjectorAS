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
 * WikiPage.java
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
 * Describes a Wiki page.
 */
public class VKApiWikiPage extends VKAttachments.VKApiAttachment implements android.os.Parcelable {

    /**
     * Wiki page ID;
     */
    public var id:int;

    /**
     * ID of the group the wiki page belongs to;
     */
    public var group_id:int;

    /**
     * ID of the page creator.
     */
    public var creator_id:int;

    /**
     * Wiki page name.
     */
    public var title:String;

    /**
     * Text of the wiki page.
     */
    public var source:String;

    /**
     * Whether a user can edit page text (false — cannot, true — can).
     */
    public var current_user_can_edit:Boolean;

    /**
     * Whether a user can edit page access permissions (false — cannot, true — can).
     */
    public var current_user_can_edit_access:Boolean;

    /**
     * Who can view the wiki page(0 — only community managers, 1 — only community members, 2 — all users).
     */
    public var who_can_view:int;

    /**
     * Who can edit the wiki page (0 — only community managers, 1 — only community members, 2 — all users).
     */
    public var who_can_edit:int;

    /**
     * ID of the last user who edited the page.
     */
    public var editor_id:int;

    /**
     * Date of the last change.
     */
    public var edited:Number;

    /**
     * Page creation date.
     */
    public var created:Number;

    /**
     * Title of the parent page for navigation, if any.
     */
    public var parent:String;

    /**
     * Title of the second parent page for navigation, if any.
     */
    public var parent2:String;

	public function VKApiWikiPage(from:JSONObject) {
		parse(from);
	}
    /**
     * Fills a WikiPage instance from JSONObject.
     */
    public function parse(source:JSONObject):VKApiWikiPage {
        id = source.optInt("id");
        group_id = source.optInt("group_id");
        creator_id = source.optInt("creator_id");
        title = source.optString("title");
        this.source = source.optString("source");
        current_user_can_edit = ParseUtils.parseBoolean(source, "current_user_can_edit");
        current_user_can_edit_access = ParseUtils.parseBoolean(source, "current_user_can_edit_access");
        who_can_view = source.optInt("who_can_view");
        who_can_edit = source.optInt("who_can_edit");
        editor_id = source.optInt("editor_id");
        edited = source.optLong("edited");
        created = source.optLong("created");
        parent = source.optString("parent");
        parent2 = source.optString("parent2");
        return this;
    }

    /**
     * Creates a WikiPage instance from Parcel.
     */
    public function VKApiWikiPage(in:Parcel) {
        this.id = in.readInt();
        this.group_id = in.readInt();
        this.creator_id = in.readInt();
        this.title = in.readString();
        this.source = in.readString();
        this.current_user_can_edit = in.readByte() != 0;
        this.current_user_can_edit_access = in.readByte() != 0;
        this.who_can_view = in.readInt();
        this.who_can_edit = in.readInt();
        this.editor_id = in.readInt();
        this.edited = in.readLong();
        this.created = in.readLong();
        this.parent = in.readString();
        this.parent2 = in.readString();
    }

    /**
     * Creates empty WikiPage instance.
     */
    public function VKApiWikiPage() {

    }

    
override public function toAttachmentString():CharSequence {
        return new StringBuilder(TYPE_WIKI_PAGE).append(group_id).append('_').append(id);
    }

    
override public function getType():String {
        return TYPE_WIKI_PAGE;
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        dest.writeInt(this.id);
        dest.writeInt(this.group_id);
        dest.writeInt(this.creator_id);
        dest.writeString(this.title);
        dest.writeString(this.source);
        dest.writeByte(current_user_can_edit ? byte(1 ): byte(0));
        dest.writeByte(current_user_can_edit_access ? byte(1 ): byte(0));
        dest.writeInt(this.who_can_view);
        dest.writeInt(this.who_can_edit);
        dest.writeInt(this.editor_id);
        dest.writeLong(this.edited);
        dest.writeLong(this.created);
        dest.writeString(this.parent);
        dest.writeString(this.parent2);
    }

    public static Creator<VKApiWikiPage> CREATOR = new Creator<VKApiWikiPage>() {
        public function createFromParcel(source:Parcel):VKApiWikiPage {
            return new VKApiWikiPage(source);
        }

        public VKApiWikiPage[] newArray(var size:int) {
            return new VKApiWikiPage[size];
        }
    };

    
override public function getId():int {
        return id;
    }
}
}