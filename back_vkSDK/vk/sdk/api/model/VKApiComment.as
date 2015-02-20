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
 * Comment.java
 * vk-android-sdk
 *
 * Created by Babichev Vitaly on 19.01.14.
 * Copyright (c) 2014 VK. All rights reserved.
 */
package com.vk.sdk.api.model {
import android.os.Parcel;

import org.json.JSONObject;

/**
 * Comment object describes a comment.
 */
public class VKApiComment extends VKApiModel implements Identifiable, android.os.Parcelable
{

	/**
	 * Comment ID, positive number
	 */
	public var id:int;

	/**
	 * Comment author ID.
	 */
	public var from_id:int;

	/**
	 * Date when the comment was added as unixtime.
	 */
	public var date:Number;

	/**
	 * Text of the comment
	 */
	public var text:String;

	/**
	 * ID of the user or community to whom the reply is addressed (if the comment is a reply to another comment).
	 */
	public var reply_to_user:int;

	/**
	 * ID of the comment the reply to which is represented by the current comment (if the comment is a reply to another comment).
	 */
	public var reply_to_comment:int;

	/**
	 * Number of likes on the comment.
	 */
	public var likes:int;

	/**
	 * Information whether the current user liked the comment.
	 */
	public var user_likes:Boolean;

	/**
	 * Whether the current user can like on the comment.
	 */
	public var can_like:Boolean;

	/**
	 * Information about attachments in the comments (photos, links, etc.;)
	 */
	public var attachments:VKAttachments= new VKAttachments();

	public function VKApiComment(from:JSONObject)
	{
		parse(from);
	}

	/**
	 * Fills a Comment instance from JSONObject.
	 */
	public function parse(from:JSONObject):VKApiComment {
		id = from.optInt("id");
		from_id = from.optInt("from_id");
		date = from.optLong("date");
		text = from.optString("text");
		reply_to_user = from.optInt("reply_to_user");
		reply_to_comment = from.optInt("reply_to_comment");
		attachments.fill(from.optJSONArray("attachments"));
		var likes:JSONObject= from.optJSONObject("likes");
		this.likes = ParseUtils.parseInt(likes, "count");
		this.user_likes = ParseUtils.parseBoolean(likes, "user_likes");
		this.can_like = ParseUtils.parseBoolean(likes, "can_like");
		return this;
	}

	/**
	 * Creates a Comment instance from Parcel.
	 */
	public function VKApiComment(in:Parcel)
	{
		this.id = in.readInt();
		this.from_id = in.readInt();
		this.date = in.readLong();
		this.text = in.readString();
		this.reply_to_user = in.readInt();
		this.reply_to_comment = in.readInt();
		this.likes = in.readInt();
		this.user_likes = in.readByte() != 0;
		this.can_like = in.readByte() != 0;
		this.attachments = in.readParcelable(VKAttachments.class.getClassLoader());
	}


	/**
	 * Creates empty Comment instance.
	 */
	public function VKApiComment()
	{

	}

	
override public function getId():int {
		return id;
	}

	
override public function describeContents():int {
		return 0;
	}

	
override public function writeToParcel(dest:Parcel, flags:int):void {
		dest.writeInt(this.id);
		dest.writeInt(this.from_id);
		dest.writeLong(this.date);
		dest.writeString(this.text);
		dest.writeInt(this.reply_to_user);
		dest.writeInt(this.reply_to_comment);
		dest.writeInt(this.likes);
		dest.writeByte(user_likes ? byte(1 ): byte(0));
		dest.writeByte(can_like ? byte(1 ): byte(0));
		dest.writeParcelable(this.attachments, flags);
	}

	public static Creator<VKApiComment> CREATOR = new Creator<VKApiComment>()
	{
		public function createFromParcel(source:Parcel):VKApiComment {
			return new VKApiComment(source);
		}

		public VKApiComment[] newArray(var size:int)
		{
			return new VKApiComment[size];
		}
	};
}
}