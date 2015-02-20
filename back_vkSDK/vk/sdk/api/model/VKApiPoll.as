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
 * PollAttachment.java
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
 * Describes poll on the wall on board.
 */
public class VKApiPoll extends VKAttachments.VKApiAttachment implements android.os.Parcelable {

    /**
     * Poll ID to get information about it using polls.getById method;
     */
    public var id:int;

    /**
     * ID of the user or community that owns this poll.
     */
    public var owner_id:int;

    /**
     * Date (in Unix time) the poll was created.
     */
    public var created:Number;

    /**
     * Question in the poll.
     */
    public var question:String;

    /**
     * The total number of users answered.
     */
    public var votes:int;

    /**
     * Response ID of the current user(if the current user has not yet posted in this poll, it contains 0)
     */
    public var answer_id:int;

    /**
     * Array of answers for this question.
     */
    public VKList<Answer> answers;

	public function VKApiPoll(from:JSONObject) {
		parse(from);
	}
    /**
     * Fills a Poll instance from JSONObject.
     */
    public function parse(source:JSONObject):VKApiPoll {
        id = source.optInt("id");
        owner_id = source.optInt("owner_id");
        created = source.optLong("created");
        question = source.optString("question");
        votes = source.optInt("votes");
        answer_id = source.optInt("answer_id");
        answers = new VKList<Answer>(source.optJSONArray("answers"), Answer.class);
        return this;
    }

    /**
     * Creates a Poll instance from Parcel.
     */
    public function VKApiPoll(in:Parcel) {
        this.id = in.readInt();
        this.owner_id = in.readInt();
        this.created = in.readLong();
        this.question = in.readString();
        this.votes = in.readInt();
        this.answer_id = in.readInt();
        this.answers = in.readParcelable(VKList.class.getClassLoader());
    }

    /**
     * Creates empty Country instance.
     */
    public function VKApiPoll() {

    }

    
override public function toAttachmentString():CharSequence {
        return null;
    }

    
override public function getType():String {
        return TYPE_POLL;
    }

    
override public function getId():int {
        return id;
    }
}

import org.json.JSONObject;
import android.os.Parcel;
import staticcom.vk.sdk.api.model.VKAttachments.

    /**
     * Represents answer for the poll
     */
    public static 
internal class Answer extends VKApiModel implements Identifiable, android.os.Parcelable {

        /**
         * ID of the answer for the question
         */
        public var id:int;

        /**
         * Text of the answer
         */
        public var text:String;

        /**
         * Number of users that voted for this answer
         */
        public var votes:int;

        /**
         * Rate of this answer in percent
         */
        public var rate:Number;

        public function parse(source:JSONObject):Answer {
            id = source.optInt("id");
            text = source.optString("text");
            votes = source.optInt("votes");
            rate = source.optDouble("rate");
            return this;
        }

        
override public function describeContents():int {
            return 0;
        }

        
override public function writeToParcel(dest:Parcel, flags:int):void {
            dest.writeInt(this.id);
            dest.writeString(this.text);
            dest.writeInt(this.votes);
            dest.writeDouble(this.rate);
        }

        public function Answer(in:Parcel) {
            this.id = in.readInt();
            this.text = in.readString();
            this.votes = in.readInt();
            this.rate = in.readDouble();
        }

        public static Creator<Answer> CREATOR = new Creator<Answer>() {
            public function createFromParcel(source:Parcel):Answer {
                return new Answer(source);
            }

            public Answer[] newArray(var size:int) {
                return new Answer[size];
            }
        };

        
override public function getId():int {
            return id;
        }
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        dest.writeInt(this.id);
        dest.writeInt(this.owner_id);
        dest.writeLong(this.created);
        dest.writeString(this.question);
        dest.writeInt(this.votes);
        dest.writeInt(this.answer_id);
        dest.writeParcelable(this.answers, flags);
    }

    public static Creator<VKApiPoll> CREATOR = new Creator<VKApiPoll>() {
        public function createFromParcel(source:Parcel):VKApiPoll {
            return new VKApiPoll(source);
        }

        public VKApiPoll[] newArray(var size:int) {
            return new VKApiPoll[size];
        }
    };
}