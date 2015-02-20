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
import android.os.Parcelable;
import android.text.TextUtils;
import org.json.JSONObject;

/**
 * Represents full community profile.
 */
public class VKApiCommunityFull extends VKApiCommunity implements Parcelable {

    /**
     * Filed city from VK fields set
     */
    public static var CITY:String= "city";

    /**
     * Filed country from VK fields set
     */
    public static var COUNTRY:String= "country";

    /**
     * Filed place from VK fields set
     */
    public static var PLACE:String= "place";

    /**
     * Filed description from VK fields set
     */
    public static var DESCRIPTION:String= "description";

    /**
     * Filed wiki_page from VK fields set
     */
    public static var WIKI_PAGE:String= "wiki_page";

    /**
     * Filed members_count from VK fields set
     */
    public static var MEMBERS_COUNT:String= "members_count";

    /**
     * Filed counters from VK fields set
     */
    public static var COUNTERS:String= "counters";

    /**
     * Filed start_date from VK fields set
     */
    public static var START_DATE:String= "start_date";

    /**
     * Filed end_date from VK fields set
     */
    public static var END_DATE:String= "end_date";

    /**
     * Filed can_post from VK fields set
     */
    public static var CAN_POST:String= "can_post";

    /**
     * Filed can_see_all_posts from VK fields set
     */
    public static var CAN_SEE_ALL_POSTS:String= "can_see_all_posts";

    /**
     * Filed status from VK fields set
     */
    public static var STATUS:String= "status";

    /**
     * Filed contacts from VK fields set
     */
    public static var CONTACTS:String= "contacts";

    /**
     * Filed links from VK fields set
     */
    public static var LINKS:String= "links";

    /**
     * Filed fixed_post from VK fields set
     */
    public static var FIXED_POST:String= "fixed_post";

    /**
     * Filed verified from VK fields set
     */
    public static var VERIFIED:String= "verified";

    /**
     * Filed blacklisted from VK fields set
     */
    public static var BLACKLISTED:String= "blacklisted";

    /**
     * Filed site from VK fields set
     */
    public static var SITE:String= "site";

    /**
     * Filed activity from VK fields set
     */
    public static var ACTIVITY:String= "activity";

    /**
     * City specified in information about community.
     */
    public var city:VKApiCity;

    /**
     * Country specified in information about community.
     */
    public var country:VKApiCountry;

    /**
     * Audio which broadcasting to status.
     */
    public var status_audio:VKApiAudio;

    /**
     * The location which specified in information about community
     */
    public var place:VKApiPlace;

    /**
     * Community description text.
     */
    public var description:String;

    /**
     * Name of the home wiki-page of the community.
     */
    public var wiki_page:String;

    /**
     * Number of community members.
     */
    public var members_count:int;

    /**
     * Counters object with community counters.
     */
    public var counters:Counters;

    /**
     * Returned only for meeting and contain start time of the meeting as unixtime.
     */
    public var start_date:Number;

    /**
     * Returned only for meeting and contain end time of the meeting as unixtime.
     */
    public var end_date:Number;

    /**
     * Whether the current user can post on the community's wall
     */
    public var can_post:Boolean;

    /**
     * Whether others' posts on the community's wall can be viewed
     */
    public var can_see_all_posts:Boolean;

    /**
     * Group status.
     */
    public var status:String;

    /**
     * Information from public page contact module.
     */
    public VKList<Contact> contacts;

    /**
     * Information from public page links module.
     */
    public VKList<Link> links;

    /**
     * ID of fixed post of this community.
     */
    public var fixed_post:int;

    /**
     * Information whether the community has a verified page in VK
     */
    public var verified:Boolean;

    /**
     * URL of community site
     */
    public var site:String;

    /**
     * Information whether the current community has add current user to the blacklist.
     */
    public var blacklisted:Boolean;

    public function VKApiCommunityFull() {
        super();
    }

    public function parse(jo:JSONObject):VKApiCommunityFull {
        super.parse(jo);

        var city:JSONObject= jo.optJSONObject(CITY);
        if(city != null) {
            this.city = new VKApiCity().parse(city);
        }
        var country:JSONObject= jo.optJSONObject(COUNTRY);
        if(country != null) {
            this.country = new VKApiCountry().parse(country);
        }

        var place:JSONObject= jo.optJSONObject(PLACE);
        if(place != null) this.place = new VKApiPlace().parse(place);

        description = jo.optString(DESCRIPTION);
        wiki_page = jo.optString(WIKI_PAGE);
        members_count = jo.optInt(MEMBERS_COUNT);

        var counters:JSONObject= jo.optJSONObject(COUNTERS);
        if(counters != null) this.counters = new Counters(place);

        start_date = jo.optLong(START_DATE);
        end_date = jo.optLong(END_DATE);
        can_post = ParseUtils.parseBoolean(jo, CAN_POST);
        can_see_all_posts = ParseUtils.parseBoolean(jo, CAN_SEE_ALL_POSTS);
        status = jo.optString(STATUS);

        var status_audio:JSONObject= jo.optJSONObject("status_audio");
        if(status_audio != null) this.status_audio = new VKApiAudio().parse(status_audio);

        contacts = new VKList<Contact>(jo.optJSONArray(CONTACTS), Contact.class);
        links = new VKList<Link>(jo.optJSONArray(LINKS), Link.class);
        fixed_post = jo.optInt(FIXED_POST);
        verified = ParseUtils.parseBoolean(jo, VERIFIED);
        blacklisted = ParseUtils.parseBoolean(jo, VERIFIED);
        site = jo.optString(SITE);
        return this;
    }
}

import org.json.JSONObject;
import android.os.Parcel;
import android.os.Parcelable;

    public static 
internal class Counters implements Parcelable {

        /**
         * Значение в том случае, если счетчик не был явно указан.
         */
        public static var NO_COUNTER:int= -1;

        public var photos:int= NO_COUNTER;
        public var albums:int= NO_COUNTER;
        public var audios:int= NO_COUNTER;
        public var videos:int= NO_COUNTER;
        public var topics:int= NO_COUNTER;
        public var docs:int= NO_COUNTER;

        public function Counters(from:JSONObject) {
            photos = from.optInt("photos", photos);
            albums = from.optInt("albums", albums);
            audios = from.optInt("audios", audios);
            videos = from.optInt("videos", videos);
            topics = from.optInt("topics", topics);
            docs = from.optInt("docs", docs);
        }

        
override public function describeContents():int {
            return 0;
        }

        
override public function writeToParcel(dest:Parcel, flags:int):void {
            dest.writeInt(this.photos);
            dest.writeInt(this.albums);
            dest.writeInt(this.audios);
            dest.writeInt(this.videos);
            dest.writeInt(this.topics);
            dest.writeInt(this.docs);
        }

        private function Counters(in:Parcel) {
            this.photos = in.readInt();
            this.albums = in.readInt();
            this.audios = in.readInt();
            this.videos = in.readInt();
            this.topics = in.readInt();
            this.docs = in.readInt();
        }

        public static Creator<Counters> CREATOR = new Creator<Counters>() {
            public function createFromParcel(source:Parcel):Counters {
                return new Counters(source);
            }

            public Counters[] newArray(var size:int) {
                return new Counters[size];
            }
        };
    }

import org.json.JSONObject;
import android.os.Parcel;
import android.os.Parcelable;

    public static 
internal class Contact extends VKApiModel implements Parcelable, Identifiable {
        public var user_id:int;
        public var user:VKApiUser;
        public var email:String;
        public var desc:String;

        public function Contact(from:JSONObject) {
            parse(from);
        }

	    public function parse(from:JSONObject):Contact {
		    user_id = from.optInt("user_id");
		    desc = from.optString("desc");
		    email = from.optString("email");
		    return this;
	    }

        
override public function describeContents():int {
            return 0;
        }

        
override public function writeToParcel(dest:Parcel, flags:int):void {
            dest.writeInt(this.user_id);
            dest.writeString(this.desc);

        }

        private function Contact(in:Parcel) {
            this.user_id = in.readInt();
            this.desc = in.readString();
        }

        public static Creator<Contact> CREATOR = new Creator<Contact>() {
            public function createFromParcel(source:Parcel):Contact {
                return new Contact(source);
            }

            public Contact[] newArray(var size:int) {
                return new Contact[size];
            }
        };

        
override public function getId():int {
            return user_id;
        }

        
override public function toString():String {
            if(user != null) {
                return user.toString();
            } else if(email != null) {
                return email;
            }
            return null;
        }
    }

import org.json.JSONObject;
import android.os.Parcel;
import android.text.TextUtils;
import android.os.Parcelable;

    public static 
internal class Link extends VKApiModel implements Parcelable, Identifiable {

        public var url:String;
        public var name:String;
        public var desc:String;
        public var photo:VKPhotoSizes= new VKPhotoSizes();

        public function Link(from:JSONObject) {
            parse(from);
        }
	    public function parse(from:JSONObject):Link {
		    url = from.optString("url");
		    name = from.optString("name");
		    desc = from.optString("desc");

		    var photo_50:String= from.optString("photo_50");
		    if(!TextUtils.isEmpty(photo_50)) {
			    photo.add(VKApiPhotoSize.create(photo_50, 50));
		    }
		    var photo_100:String= from.optString("photo_100");
		    if(!TextUtils.isEmpty(photo_100)) {
			    photo.add(VKApiPhotoSize.create(photo_100, 100));
		    }
		    photo.sort();
		    return this;
	    }

        
override public function describeContents():int {
            return 0;
        }

        
override public function writeToParcel(dest:Parcel, flags:int):void {
            dest.writeString(this.url);
            dest.writeString(this.name);
            dest.writeString(this.desc);
            dest.writeParcelable(this.photo, flags);
        }

        public function Link(in:Parcel) {
            this.url = in.readString();
            this.name = in.readString();
            this.desc = in.readString();
            this.photo = in.readParcelable(null);
        }

        public static Creator<Link> CREATOR = new Creator<Link>() {
            public function createFromParcel(source:Parcel):Link {
                return new Link(source);
            }

            public Link[] newArray(var size:int) {
                return new Link[size];
            }
        };

        
override public function getId():int {
            return 0;
        }
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        super.writeToParcel(dest, flags);
        dest.writeParcelable(this.city, flags);
        dest.writeParcelable(this.country, flags);
        dest.writeParcelable(this.status_audio, flags);
        dest.writeParcelable(this.place, flags);
        dest.writeString(this.description);
        dest.writeString(this.wiki_page);
        dest.writeInt(this.members_count);
        dest.writeParcelable(this.counters, flags);
        dest.writeLong(this.start_date);
        dest.writeLong(this.end_date);
        dest.writeByte(can_post ? byte(1 ): byte(0));
        dest.writeByte(can_see_all_posts ? byte(1 ): byte(0));
        dest.writeString(this.status);
        dest.writeParcelable(this.contacts, flags);
        dest.writeParcelable(this.links, flags);
        dest.writeInt(this.fixed_post);
        dest.writeByte(verified ? byte(1 ): byte(0));
        dest.writeString(this.site);
        dest.writeByte(blacklisted ? byte(1 ): byte(0));
    }

    public function VKApiCommunityFull(in:Parcel) {
        super(in);
        this.city = in.readParcelable(VKApiCity.class.getClassLoader());
        this.country = in.readParcelable(VKApiCountry.class.getClassLoader());
        this.status_audio = in.readParcelable(VKApiAudio.class.getClassLoader());
        this.place = in.readParcelable(VKApiPlace.class.getClassLoader());
        this.description = in.readString();
        this.wiki_page = in.readString();
        this.members_count = in.readInt();
        this.counters = in.readParcelable(Counters.class.getClassLoader());
        this.start_date = in.readLong();
        this.end_date = in.readLong();
        this.can_post = in.readByte() != 0;
        this.can_see_all_posts = in.readByte() != 0;
        this.status = in.readString();
        this.contacts = in.readParcelable(VKList.class.getClassLoader());
        this.links = in.readParcelable(VKList.class.getClassLoader());
        this.fixed_post = in.readInt();
        this.verified = in.readByte() != 0;
        this.site = in.readString();
        this.blacklisted = in.readByte() != 0;
    }

    public static Creator<VKApiCommunityFull> CREATOR = new Creator<VKApiCommunityFull>() {
        public function createFromParcel(source:Parcel):VKApiCommunityFull {
            return new VKApiCommunityFull(source);
        }

        public VKApiCommunityFull[] newArray(var size:int) {
            return new VKApiCommunityFull[size];
        }
    };
}