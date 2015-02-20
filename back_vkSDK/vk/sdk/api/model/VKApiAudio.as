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
 * Audio.java
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
 * An audio object describes an audio file and contains the following fields.
 */
public class VKApiAudio extends VKApiAttachment implements Identifiable, android.os.Parcelable {

    /**
     * Audio ID.
     */
    public var id:int;

    /**
     * Audio owner ID.
     */
    public var owner_id:int;

    /**
     * Artist name.
     */
    public var artist:String;

    /**
     * Audio file title.
     */
    public var title:String;

    /**
     * Duration (in seconds).
     */
    public var duration:int;

    /**
     * Link to mp3.
     */
    public var url:String;

    /**
     * ID of the lyrics (if available) of the audio file.
     */
    public var lyrics_id:int;

    /**
     * ID of the album containing the audio file (if assigned).
     */
    public var album_id:int;

    /**
     * Genre ID. See the list of audio genres.
     */
    public var genre:int;

    /**
     * An access key using for get information about hidden objects.
     */
    public var access_key:String;

	public function VKApiAudio(from:JSONObject) {
		parse(from);
	}
    /**
     * Fills an Audio instance from JSONObject.
     */
    public function parse(from:JSONObject):VKApiAudio {
        id = from.optInt("id");
        owner_id = from.optInt("owner_id");
        artist = from.optString("artist");
        title = from.optString("title");
        duration = from.optInt("duration");
        url = from.optString("url");
        lyrics_id = from.optInt("lyrics_id");
        album_id = from.optInt("album_id");
        genre = from.optInt("genre_id");
        access_key = from.optString("access_key");
        return this;
    }

    /**
     * Creates an Audio instance from Parcel.
     */
    public function VKApiAudio(in:Parcel) {
        this.id = in.readInt();
        this.owner_id = in.readInt();
        this.artist = in.readString();
        this.title = in.readString();
        this.duration = in.readInt();
        this.url = in.readString();
        this.lyrics_id = in.readInt();
        this.album_id = in.readInt();
        this.genre = in.readInt();
        this.access_key = in.readString();
    }

    /**
     * Creates empty Audio instance.
     */
    public function VKApiAudio() {

    }

    
override public function getId():int {
        return id;
    }

    
override public function toAttachmentString():CharSequence {
        var result:StringBuilder= new StringBuilder(TYPE_AUDIO).append(owner_id).append('_').append(id);
        if(!TextUtils.isEmpty(access_key)) {
            result.append('_');
            result.append(access_key);
        }
        return result;
    }

    
override public function getType():String {
        return TYPE_AUDIO;
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        dest.writeInt(this.id);
        dest.writeInt(this.owner_id);
        dest.writeString(this.artist);
        dest.writeString(this.title);
        dest.writeInt(this.duration);
        dest.writeString(this.url);
        dest.writeInt(this.lyrics_id);
        dest.writeInt(this.album_id);
        dest.writeInt(this.genre);
        dest.writeString(this.access_key);
    }

    public static Creator<VKApiAudio> CREATOR = new Creator<VKApiAudio>() {
        public function createFromParcel(source:Parcel):VKApiAudio {
            return new VKApiAudio(source);
        }

        public VKApiAudio[] newArray(var size:int) {
            return new VKApiAudio[size];
        }
    }
}

import staticcom.vk.sdk.api.model.VKAttachments.
;

    /**
     * Audio object genres.
     */
    public static 
internal class Genre {

        private function Genre() {}

        public static var ROCK:int= 1;
        public static var POP:int= 2;
        public static var RAP_AND_HIPHOP:int= 3;
        public static var EASY_LISTENING:int= 4;
        public static var DANCE_AND_HOUSE:int= 5;
        public static var INSTRUMENTAL:int= 6;
        public static var METAL:int= 7;
        public static var DUBSTEP:int= 8;
        public static var JAZZ_AND_BLUES:int= 9;
        public static var DRUM_AND_BASS:int= 10;
        public static var TRANCE:int= 11;
        public static var CHANSON:int= 12;
        public static var ETHNIC:int= 13;
        public static var ACOUSTIC_AND_VOCAL:int= 14;
        public static var REGGAE:int= 15;
        public static var CLASSICAL:int= 16;
        public static var INDIE_POP:int= 17;
        public static var OTHER:int= 18;
        public static var SPEECH:int= 19;
        public static var ALTERNATIVE:int= 21;
        public static var ELECTROPOP_AND_DISCO:int= 22;
    }

}