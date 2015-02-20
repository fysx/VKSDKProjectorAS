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
 * Message.java
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
 * A message object describes a private message
 */
public class VKApiMessage extends VKApiModel implements Identifiable, android.os.Parcelable {

    /**
     * 	Message ID. (Not returned for forwarded messages), positive number
     */
    public var id:int;

    /**
     * For an incoming message, the user ID of the author. For an outgoing message, the user ID of the receiver.
     */
    public var user_id:int;

    /**
     * 	Date (in Unix time) when the message was sent.
     */
    public var date:Number;

    /**
     * Message status (false — not read, true — read). (Not returned for forwarded messages.)
     */
    public var read_state:Boolean;

    /**
     * Message type (false — received, true — sent). (Not returned for forwarded messages.)
     */
    public var out:Boolean;

    /**
     * Title of message or chat.
     */
    public var title:String;

    /**
     * Body of the message.
     */
    public var body:String;

    /**
     * List of media-attachments;
     */
    public var attachments:VKAttachments= new VKAttachments();

    /**
     * Array of forwarded messages (if any).
     */
    public VKList<VKApiMessage> fwd_messages;

    /**
     *	Whether the message contains smiles (false — no, true — yes).
     */
    public var emoji:Boolean;

    /**
     * Whether the message is deleted (false — no, true — yes).
     */
    public var deleted:Boolean;

	public function VKApiMessage(from:JSONObject) {
		parse(from);
	}
    /**
     * Fills a Message instance from JSONObject.
     */
    public function parse(source:JSONObject):VKApiMessage {
        id = source.optInt("id");
        user_id = source.optInt("user_id");
        date = source.optLong("date");
        read_state = ParseUtils.parseBoolean(source, "read_state");
        out = ParseUtils.parseBoolean(source, "out");
        title = source.optString("title");
        body = source.optString("body");
        attachments .fill(source.optJSONArray("attachments"));
        fwd_messages = new VKList<VKApiMessage>(source.optJSONArray("fwd_messages"), VKApiMessage.class);
        emoji = ParseUtils.parseBoolean(source, "emoji");
        deleted = ParseUtils.parseBoolean(source, "deleted");
        return this;
    }

    /**
     * Creates a Message instance from Parcel.
     */
    public function VKApiMessage(in:Parcel) {
        this.id = in.readInt();
        this.user_id = in.readInt();
        this.date = in.readLong();
        this.read_state = in.readByte() != 0;
        this.out = in.readByte() != 0;
        this.title = in.readString();
        this.body = in.readString();
        this.attachments = in.readParcelable(VKAttachments.class.getClassLoader());
        this.fwd_messages = in.readParcelable(VKList.class.getClassLoader());
        this.emoji = in.readByte() != 0;
        this.deleted = in.readByte() != 0;
    }

    /**
     * Creates empty Country instance.
     */
    public function VKApiMessage() {

    }

    
override public function getId():int {
        return id;
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        dest.writeInt(this.id);
        dest.writeInt(this.user_id);
        dest.writeLong(this.date);
        dest.writeByte(read_state ? byte(1 ): byte(0));
        dest.writeByte(out ? byte(1 ): byte(0));
        dest.writeString(this.title);
        dest.writeString(this.body);
        dest.writeParcelable(attachments, flags);
        dest.writeParcelable(this.fwd_messages, flags);
        dest.writeByte(emoji ? byte(1 ): byte(0));
        dest.writeByte(deleted ? byte(1 ): byte(0));
    }

    public static Creator<VKApiMessage> CREATOR = new Creator<VKApiMessage>() {
        public function createFromParcel(source:Parcel):VKApiMessage {
            return new VKApiMessage(source);
        }

        public VKApiMessage[] newArray(var size:int) {
            return new VKApiMessage[size];
        }
    };
}
}