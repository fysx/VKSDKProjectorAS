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
 * Post.java
 * vk-android-sdk
 *
 * Created by Babichev Vitaly on 19.01.14.
 * Copyright (c) 2014 VK. All rights reserved.
 */
package com.vk.sdk.api.model {
import android.os.Parcel;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * A post object describes a wall post.
 */
public class VKApiPost extends VKAttachments.VKApiAttachment implements Identifiable, android.os.Parcelable {

    /**
     * Post ID on the wall, positive number
     */
    public var id:int;

    /**
     * Wall owner ID.
     */
    public var to_id:int;

    /**
     * ID of the user who posted.
     */
    public var from_id:int;

    /**
     * Date (in Unix time) the post was added.
     */
    public var date:Number;

    /**
     * Text of the post.
     */
    public var text:String;

    /**
     * ID of the wall owner the post to which the reply is addressed (if the post is a reply to another wall post).
     */
    public var reply_owner_id:int;

    /**
     * ID of the wall post to which the reply is addressed (if the post is a reply to another wall post).
     */
    public var reply_post_id:int;

    /**
     * True, if the post was created with "Friends only" option.
     */
    public var friends_only:Boolean;

    /**
     * Number of comments.
     */
    public var comments_count:int;

    /**
     * Whether the current user can leave comments to the post (false — cannot, true — can)
     */
    public var can_post_comment:Boolean;

    /**
     * Number of users who liked the post.
     */
    public var likes_count:int;

    /**
     * Whether the user liked the post (false — not liked, true — liked)
     */
    public var user_likes:Boolean;

    /**
     * Whether the user can like the post (false — cannot, true — can).
     */
    public var can_like:Boolean;

    /**
     * Whether the user can repost (false — cannot, true — can).
     */
    public var can_publish:Boolean;

    /**
     * Number of users who copied the post.
     */
    public var reposts_count:int;

    /**
     * Whether the user reposted the post (false — not reposted, true — reposted).
     */
    public var user_reposted:Boolean;

    /**
     * Type of the post, can be: post, copy, reply, postpone, suggest.
     */
    public var post_type:String;

    /**
     * Information about attachments to the post (photos, links, etc.), if any;
     */
    public var attachments:VKAttachments= new VKAttachments();

    /**
     * Information about location.
     */
    public var geo:VKApiPlace;

    /**
     * ID of the author (if the post was published by a community and signed by a user).
     */
    public var signer_id:int;

    /**
     * List of history of the reposts.
     */
    public VKList<VKApiPost> copy_history;

	public function VKApiPost(from:JSONObject) {
		parse(from);
	}
    /**
     * Fills a Post instance from JSONObject.
     */
    public function parse(source:JSONObject):VKApiPost {
        id = source.optInt("id");
        to_id = source.optInt("to_id");
        from_id = source.optInt("from_id");
        date = source.optLong("date");
        text = source.optString("text");
        reply_owner_id = source.optInt("reply_owner_id");
        reply_post_id = source.optInt("reply_post_id");
        friends_only = ParseUtils.parseBoolean(source, "friends_only");
        var comments:JSONObject= source.optJSONObject("comments");
        if(comments != null) {
            comments_count = comments.optInt("count");
            can_post_comment = ParseUtils.parseBoolean(comments, "can_post");
        }
        var likes:JSONObject= source.optJSONObject("likes");
        if(likes != null) {
            likes_count = likes.optInt("count");
            user_likes = ParseUtils.parseBoolean(likes, "user_likes");
            can_like = ParseUtils.parseBoolean(likes, "can_like");
            can_publish = ParseUtils.parseBoolean(likes, "can_publish");
        }
        var reposts:JSONObject= source.optJSONObject("reposts");
        if(reposts != null) {
            reposts_count = reposts.optInt("count");
            user_reposted = ParseUtils.parseBoolean(reposts, "user_reposted");
        }
        post_type = source.optString("post_type");
        attachments.fill(source.optJSONArray("attachments"));
        var geo:JSONObject= source.optJSONObject("geo");
        if(geo != null) {
            this.geo = new VKApiPlace().parse(geo);
        }
        signer_id = source.optInt("signer_id");
        copy_history = new VKList<VKApiPost>(source.optJSONArray("copy_history"), VKApiPost.class);
        return this;
    }

    /**
     * Creates a Post instance from Parcel.
     */
    public function VKApiPost(in:Parcel) {
        this.id = in.readInt();
        this.to_id = in.readInt();
        this.from_id = in.readInt();
        this.date = in.readLong();
        this.text = in.readString();
        this.reply_owner_id = in.readInt();
        this.reply_post_id = in.readInt();
        this.friends_only = in.readByte() != 0;
        this.comments_count = in.readInt();
        this.can_post_comment = in.readByte() != 0;
        this.likes_count = in.readInt();
        this.user_likes = in.readByte() != 0;
        this.can_like = in.readByte() != 0;
        this.can_publish = in.readByte() != 0;
        this.reposts_count = in.readInt();
        this.user_reposted = in.readByte() != 0;
        this.post_type = in.readString();
        this.attachments = in.readParcelable(VKAttachments.class.getClassLoader());
        this.geo = in.readParcelable(VKApiPlace.class.getClassLoader());
        this.signer_id = in.readInt();
    }

    /**
     * Creates empty Post instance.
     */
    public function VKApiPost() {

    }

    
override public function getId():int {
        return id;
    }

    
override public function toAttachmentString():CharSequence {
        return new StringBuilder(VKAttachments.TYPE_POST).append(to_id).append('_').append(id);
    }

    
override public function getType():String {
        return VKAttachments.TYPE_POST;
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        dest.writeInt(this.id);
        dest.writeInt(this.to_id);
        dest.writeInt(this.from_id);
        dest.writeLong(this.date);
        dest.writeString(this.text);
        dest.writeInt(this.reply_owner_id);
        dest.writeInt(this.reply_post_id);
        dest.writeByte(friends_only ? byte(1 ): byte(0));
        dest.writeInt(this.comments_count);
        dest.writeByte(can_post_comment ? byte(1 ): byte(0));
        dest.writeInt(this.likes_count);
        dest.writeByte(user_likes ? byte(1 ): byte(0));
        dest.writeByte(can_like ? byte(1 ): byte(0));
        dest.writeByte(can_publish ? byte(1 ): byte(0));
        dest.writeInt(this.reposts_count);
        dest.writeByte(user_reposted ? byte(1 ): byte(0));
        dest.writeString(this.post_type);
        dest.writeParcelable(attachments, flags);
        dest.writeParcelable(this.geo, flags);
        dest.writeInt(this.signer_id);
    }

    public static Creator<VKApiPost> CREATOR = new Creator<VKApiPost>() {
        public function createFromParcel(source:Parcel):VKApiPost {
            return new VKApiPost(source);
        }

        public VKApiPost[] newArray(var size:int) {
            return new VKApiPost[size];
        }
    };

}
}