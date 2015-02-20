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
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import static com.vk.sdk.api.model.ParseUtils.parseBoolean;
import static com.vk.sdk.api.model.ParseUtils.parseLong;

/**
 * Represents full user profile.
 */
public class VKApiUserFull extends VKApiUser implements android.os.Parcelable {

    /**
     * Filed last_seen from VK fields set
     */
    public static const LAST_SEEN:String= "last_seen";

    /**
     * Filed bdate from VK fields set
     */
    public static const BDATE:String= "bdate";

    /**
     * Filed city from VK fields set
     */
    public static const CITY:String= "city";

    /**
     * Filed country from VK fields set
     */
    public static const COUNTRY:String= "country";

    /**
     * Filed universities from VK fields set
     */
    public static const UNIVERSITIES:String= "universities";

    /**
     * Filed schools from VK fields set
     */
    public static const SCHOOLS:String= "schools";

    /**
     * Filed activity from VK fields set
     */
    public static const ACTIVITY:String= "activity";

    /**
     * Filed personal from VK fields set
     */
    public static const PERSONAL:String= "personal";

    /**
     * Filed sex from VK fields set
     */
    public static const SEX:String= "sex";

    /**
     * Filed site from VK fields set
     */
    public static const SITE:String= "site";

    /**
     * Filed contacts from VK fields set
     */
    public static const CONTACTS:String= "contacts";

    /**
     * Filed can_post from VK fields set
     */
    public static const CAN_POST:String= "can_post";

    /**
     * Filed can_see_all_posts from VK fields set
     */
    public static const CAN_SEE_ALL_POSTS:String= "can_see_all_posts";

    /**
     * Filed can_write_private_message from VK fields set
     */
    public static const CAN_WRITE_PRIVATE_MESSAGE:String= "can_write_private_message";

    /**
     * Filed relation from VK fields set
     */
    public static const RELATION:String= "relation";

    /**
     * Filed counters from VK fields set
     */
    public static const COUNTERS:String= "counters";

    /**
     * Filed activities from VK fields set
     */
    public static const ACTIVITIES:String= "activities";

    /**
     * Filed interests from VK fields set
     */
    public static const INTERESTS:String= "interests";

    /**
     * Filed movies from VK fields set
     */
    public static const MOVIES:String= "movies";

    /**
     * Filed tv from VK fields set
     */
    public static const TV:String= "tv";

    /**
     * Filed books from VK fields set
     */
    public static const BOOKS:String= "books";

    /**
     * Filed games from VK fields set
     */
    public static const GAMES:String= "games";

    /**
     * Filed about from VK fields set
     */
    public static const ABOUT:String= "about";

    /**
     * Filed quotes from VK fields set
     */
    public static const QUOTES:String= "quotes";

    /**
     * Filed connections from VK fields set
     */
    public static const CONNECTIONS:String= "connections";

    /**
     * Filed relatives from VK fields set
     */
    public static const RELATIVES:String= "relatives";

    /**
     * Filed wall_default from VK fields set
     */
    public static const WALL_DEFAULT:String= "wall_default";

    /**
     * Filed verified from VK fields set
     */
    public static const VERIFIED:String= "verified";

    /**
     * Filed screen_name from VK fields set
     */
    public static const SCREEN_NAME:String= "screen_name";

    /**
     * Filed blacklisted_by_me from VK fields set
     */
    public static const BLACKLISTED_BY_ME:String= "blacklisted_by_me";

    /**
     * Text of user status.
     */
    public var activity:String;

    /**
     * Audio which broadcasting to status.
     */
    public var status_audio:VKApiAudio;

    /**
     * User's date of birth.  Returned as DD.MM.YYYY or DD.MM (if birth year is hidden).
     */
    public var bdate:String;

    /**
     * City specified on user's page in "Contacts" section.
     */
    public var city:VKApiCity;

    /**
     * Country specified on user's page in "Contacts" section.
     */
    public var country:VKApiCountry;

    /**
     * Last visit date(in Unix time).
     */
    public var last_seen:Number;

    /**
     * List of user's universities
     */
    public VKList<VKApiUniversity> universities;

    /**
     * List of user's schools
     */
    public VKList<VKApiSchool> schools;

    /**
     * Views on smoking.
     * @see {@link Attitude}
     */
    public var smoking:int;

    /**
     * Views on alcohol.
     * @see {@link Attitude}
     */
    public var alcohol:int;

    /**
     * Views on policy.
     * @see {@link com.vk.sdk.api.model.VKApiUserFull.Political}
     */
    public var political:int;

    /**
     * Life main stuffs.
     * @see {@link com.vk.sdk.api.model.VKApiUserFull.LifeMain}
     */
    public var life_main:int;

    /**
     * People main stuffs.
     * @see {@link com.vk.sdk.api.model.VKApiUserFull.PeopleMain}
     */
    public var people_main:int;

    /**
     * Stuffs that inspire the user.
     */
    public var inspired_by:String;

    /**
     * List of user's languages
     */
    public var langs:Array;

    /**
     * Religion of user
     */
    public var religion:String;

    /**
     * Name of user's account in Facebook
     */
    public var facebook:String;

    /**
     * ID of user's facebook
     */
    public var facebook_name:String;

    /**
     * Name of user's account in LiveJournal
     */
    public var livejournal:String;

    /**
     * Name of user's account in Skype
     */
    public var skype:String;

    /**
     * URL of user's site
     */
    public var site:String;

    /**
     * Name of user's account in Twitter
     */
    public var twitter:String;

    /**
     * Name of user's account in Instagram
     */
    public var instagram:String;

    /**
     * User's mobile phone number
     */
    public var mobile_phone:String;

    /**
     * User's home phone number
     */
    public var home_phone:String;

    /**
     * Page screen name.
     */
    public var screen_name:String;

    /**
     * Nickname of user.
     */
    public var nickname:String;

    /**
     * User's activities
     */
    public var activities:String;

    /**
     * User's interests
     */
    public var interests:String;

    /**
     * User's favorite movies
     */
    public var movies:String;

    /**
     * User's favorite TV Shows
     */
    public var tv:String;

    /**
     * User's favorite books
     */
    public var books:String;

    /**
     * User's favorite games
     */
    public var games:String;

    /**
     * User's about information
     */
    public var about:String;

    /**
     * User's favorite quotes
     */
    public var quotes:String;

    /**
     * Information whether others can posts on user's wall.
     */
    public var can_post:Boolean;

    /**
     * Information whether others' posts on user's wall can be viewed
     */
    public var can_see_all_posts:Boolean;

    /**
     * Information whether private messages can be sent to this user.
     */
    public var can_write_private_message:Boolean;

    /**
     * Information whether user can comment wall posts.
     */
    public var wall_comments:Boolean;

    /**
     * Information whether the user is banned in VK.
     */
    public var is_banned:Boolean;

    /**
     * Information whether the user is deleted in VK.
     */
    public var is_deleted:Boolean;

    /**
     * Information whether the user's post of wall shows by default.
     */
    public var wall_default_owner:Boolean;

    /**
     * Information whether the user has a verified page in VK
     */
    public var verified:Boolean;

    /**
     * User sex.
     * @see {@link com.vk.sdk.api.model.VKApiUserFull.Sex}
     */
    public var sex:int;

    /**
     * Set of user's counters.
     */
    public var counters:Counters;

    /**
     * Relationship status.
     * @see {@link com.vk.sdk.api.model.VKApiUserFull.Relation}
     */
    public var relation:int;

    /**
     * List of user's relatives
     */
    public VKList<Relative> relatives;

    /**
     * Information whether the current user has add this user to the blacklist.
     */
    public var blacklisted_by_me:Boolean;

	public function VKApiUserFull(from:JSONObject) {
		parse(from);
	}
    public function parse(user:JSONObject):VKApiUserFull {
        super.parse(user);

        // general
        last_seen = parseLong(user.optJSONObject(LAST_SEEN), "time");
        bdate = user.optString(BDATE);

        var city:JSONObject= user.optJSONObject(CITY);
        if(city != null) {
            this.city = new VKApiCity().parse(city);
        }
        var country:JSONObject= user.optJSONObject(COUNTRY);
        if(country != null) {
            this.country = new VKApiCountry().parse(country);
        }

        // education
        universities = new VKList<VKApiUniversity>(user.optJSONArray(UNIVERSITIES), VKApiUniversity.class);
        schools = new VKList<VKApiSchool>(user.optJSONArray(SCHOOLS), VKApiSchool.class);

        // status
        activity = user.optString(ACTIVITY);

        var status_audio:JSONObject= user.optJSONObject("status_audio");
        if(status_audio != null) this.status_audio = new VKApiAudio().parse(status_audio);

        // personal views
        var personal:JSONObject= user.optJSONObject(PERSONAL);
        if (personal != null) {
            smoking = personal.optInt("smoking");
            alcohol = personal.optInt("alcohol");
            political = personal.optInt("political");
            life_main = personal.optInt("life_main");
            people_main = personal.optInt("people_main");
            inspired_by = personal.optString("inspired_by");
            religion = personal.optString("religion");
            if (personal.has("langs")) {
                var langs:JSONArray= personal.optJSONArray("langs");
                if (langs != null) {
                    this.langs = new String[langs.length()];
                    for (var i:int= 0; i < langs.length(); i++) {
                        this.langs[i] = langs.optString(i);
                    }
                }
            }
        }

        // contacts
        facebook = user.optString("facebook");
        facebook_name = user.optString("facebook_name");
        livejournal = user.optString("livejournal");
        site = user.optString(SITE);
        screen_name = user.optString("screen_name", "id" + id);
        skype = user.optString("skype");
        mobile_phone = user.optString("mobile_phone");
        home_phone = user.optString("home_phone");
        twitter = user.optString("twitter");
        instagram = user.optString("instagram");

        // personal info
        about = user.optString(ABOUT);
        activities = user.optString(ACTIVITIES);
        books = user.optString(BOOKS);
        games = user.optString(GAMES);
        interests = user.optString(INTERESTS);
        movies = user.optString(MOVIES);
        quotes = user.optString(QUOTES);
        tv = user.optString(TV);

        // settings
        nickname = user.optString("nickname", null);
        can_post = parseBoolean(user, CAN_POST);
        can_see_all_posts = parseBoolean(user, CAN_SEE_ALL_POSTS);
        blacklisted_by_me = parseBoolean(user, BLACKLISTED_BY_ME);
        can_write_private_message = parseBoolean(user, CAN_WRITE_PRIVATE_MESSAGE);
        wall_comments = parseBoolean(user, WALL_DEFAULT);
        var deactivated:String= user.optString("deactivated");
        is_deleted = "deleted" == (deactivated);
        is_banned = "banned" == (deactivated);
        wall_default_owner = "owner" == (user.optString(WALL_DEFAULT));
        verified = parseBoolean(user, VERIFIED);

        // other
        sex = user.optInt(SEX);
        var counters:JSONObject= user.optJSONObject(COUNTERS);
        if (counters != null) this.counters = new Counters(counters);

        relation = user.optInt(RELATION);

        if (user.has(RELATIVES)) {
            if (relatives == null) {
                relatives = new VKList<Relative>();
            }
            relatives.fill(user.optJSONArray(RELATIVES), Relative.class);
        }
        return this;
    }
}

import org.json.JSONObject;
import android.os.Parcel;
import staticcom.vk.sdk.api.model.ParseUtils.parseLong

    public static 
internal class Relative extends VKApiModel implements android.os.Parcelable, Identifiable {

        public var id:int;
        public var name:String;

        
override public function getId():int {
            return id;
        }

        
override public function parse(response:JSONObject):Relative {
            id = response.optInt("id");
            name = response.optString("name");
            return this;
        }

        
override public function describeContents():int {
            return 0;
        }

        
override public function writeToParcel(dest:Parcel, flags:int):void {
            dest.writeInt(this.id);
            dest.writeString(this.name);
        }

        private function Relative(in:Parcel) {
            this.id = in.readInt();
            this.name = in.readString();
        }

        public static Creator<Relative> CREATOR = new Creator<Relative>() {
            public function createFromParcel(source:Parcel):Relative {
                return new Relative(source);
            }

            public Relative[] newArray(var size:int) {
                return new Relative[size];
            }
        };
    }

import org.json.JSONObject;
import android.os.Parcel;
import staticcom.vk.sdk.api.model.ParseUtils.parseLong

    public static 
internal class Counters implements android.os.Parcelable {
        /**
         * Count was not in server response.
         */
        public static var NO_COUNTER:int= -1;

        public var albums:int= NO_COUNTER;
        public var videos:int= NO_COUNTER;
        public var audios:int= NO_COUNTER;
        public var notes:int= NO_COUNTER;
        public var friends:int= NO_COUNTER;
        public var photos:int= NO_COUNTER;
        public var groups:int= NO_COUNTER;
        public var online_friends:int= NO_COUNTER;
        public var mutual_friends:int= NO_COUNTER;
        public var user_videos:int= NO_COUNTER;
        public var followers:int= NO_COUNTER;
        public var subscriptions:int= NO_COUNTER;
        public var pages:int= NO_COUNTER;

        Counters(var counters:JSONObject) {
            albums = counters.optInt("albums", albums);
            audios = counters.optInt("audios", audios);
            followers = counters.optInt("followers", followers);
            photos = counters.optInt("photos", photos);
            friends = counters.optInt("friends", friends);
            groups = counters.optInt("groups", groups);
            mutual_friends = counters.optInt("mutual_friends", mutual_friends);
            notes = counters.optInt("notes", notes);
            online_friends = counters.optInt("online_friends", online_friends);
            user_videos = counters.optInt("user_videos", user_videos);
            videos = counters.optInt("videos", videos);
            subscriptions = counters.optInt("subscriptions", subscriptions);
            pages = counters.optInt("pages", pages);
        }

        
override public function describeContents():int {
            return 0;
        }

        
override public function writeToParcel(dest:Parcel, flags:int):void {
            dest.writeInt(this.albums);
            dest.writeInt(this.videos);
            dest.writeInt(this.audios);
            dest.writeInt(this.notes);
            dest.writeInt(this.friends);
            dest.writeInt(this.photos);
            dest.writeInt(this.groups);
            dest.writeInt(this.online_friends);
            dest.writeInt(this.mutual_friends);
            dest.writeInt(this.user_videos);
            dest.writeInt(this.followers);
            dest.writeInt(this.subscriptions);
            dest.writeInt(this.pages);
        }

        private function Counters(in:Parcel) {
            this.albums = in.readInt();
            this.videos = in.readInt();
            this.audios = in.readInt();
            this.notes = in.readInt();
            this.friends = in.readInt();
            this.photos = in.readInt();
            this.groups = in.readInt();
            this.online_friends = in.readInt();
            this.mutual_friends = in.readInt();
            this.user_videos = in.readInt();
            this.followers = in.readInt();
            this.subscriptions = in.readInt();
            this.pages = in.readInt();
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

import staticcom.vk.sdk.api.model.ParseUtils.parseLong

    public static 
internal class Sex {
        private function Sex() {
        }

        public static const FEMALE:int= 1;
        public static const MALE:int= 2;
    }

import staticcom.vk.sdk.api.model.ParseUtils.parseLong

    public static 
internal class Relation {
        private function Relation() {
        }

        public static const SINGLE:int= 1;
        public static const RELATIONSHIP:int= 2;
        public static const ENGAGED:int= 3;
        public static const MARRIED:int= 4;
        public static const COMPLICATED:int= 5;
        public static const SEARCHING:int= 6;
        public static const IN_LOVE:int= 7;
    }

import staticcom.vk.sdk.api.model.ParseUtils.parseLong

    public static 
internal class Attitude {
        private function Attitude() {
        }

        public static const VERY_NEGATIVE:int= 1;
        public static const NEGATIVE:int= 2;
        public static const COMPROMISABLE:int= 3;
        public static const NEUTRAL:int= 4;
        public static const POSITIVE:int= 5;
    }

import staticcom.vk.sdk.api.model.ParseUtils.parseLong

    public static 
internal class Political {
        private function Political() {
        }

        public static const COMMUNNIST:int= 1;
        public static const SOCIALIST:int= 2;
        public static const CENTRIST:int= 3;
        public static const LIBERAL:int= 4;
        public static const CONSERVATIVE:int= 5;
        public static const MONARCHIST:int= 6;
        public static const ULTRACONSERVATIVE:int= 7;
        public static const LIBERTARIAN:int= 8;
        public static const APATHETIC:int= 9;
    }

import staticcom.vk.sdk.api.model.ParseUtils.parseLong

    public static 
internal class LifeMain {
        private function LifeMain() {
        }

        public static const FAMILY_AND_CHILDREN:int= 1;
        public static const CAREER_AND_MONEY:int= 2;
        public static const ENTERTAINMENT_AND_LEISURE:int= 3;
        public static const SCIENCE_AND_RESEARCH:int= 4;
        public static const IMPROOVING_THE_WORLD:int= 5;
        public static const PERSONAL_DEVELOPMENT:int= 6;
        public static const BEAUTY_AND_ART:int= 7;
        public static const FAME_AND_INFLUENCE:int= 8;
    }

import staticcom.vk.sdk.api.model.ParseUtils.parseLong

    public static 
internal class PeopleMain {
        private function PeopleMain() {
        }

        public static const INTELLECT_AND_CREATIVITY:int= 1;
        public static const KINDNESS_AND_HONESTLY:int= 2;
        public static const HEALTH_AND_BEAUTY:int= 3;
        public static const WEALTH_AND_POWER:int= 4;
        public static const COURAGE_AND_PERSISTENCE:int= 5;
        public static const HUMOR_AND_LOVE_FOR_LIFE:int= 6;
    }

import android.os.Parcel;
import staticcom.vk.sdk.api.model.ParseUtils.parseLong

    public static 
internal class RelativeType {
        private function RelativeType() {
        }

        public static const PARTNER:String= "partner";
        public static const GRANDCHILD:String= "grandchild";
        public static const GRANDPARENT:String= "grandparent";
        public static const CHILD:String= "child";
        public static const SUBLING:String= "sibling";
        public static const PARENT:String= "parent";
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        super.writeToParcel(dest, flags);
        dest.writeString(this.activity);
        dest.writeParcelable(this.status_audio, flags);
        dest.writeString(this.bdate);
        dest.writeParcelable(this.city, flags);
        dest.writeParcelable(this.country, flags);
        dest.writeLong(this.last_seen);
        dest.writeParcelable(this.universities, flags);
        dest.writeParcelable(this.schools, flags);
        dest.writeInt(this.smoking);
        dest.writeInt(this.alcohol);
        dest.writeInt(this.political);
        dest.writeInt(this.life_main);
        dest.writeInt(this.people_main);
        dest.writeString(this.inspired_by);
        dest.writeStringArray(this.langs);
        dest.writeString(this.religion);
        dest.writeString(this.facebook);
        dest.writeString(this.facebook_name);
        dest.writeString(this.livejournal);
        dest.writeString(this.skype);
        dest.writeString(this.site);
        dest.writeString(this.twitter);
        dest.writeString(this.instagram);
        dest.writeString(this.mobile_phone);
        dest.writeString(this.home_phone);
        dest.writeString(this.screen_name);
        dest.writeString(this.activities);
        dest.writeString(this.interests);
        dest.writeString(this.movies);
        dest.writeString(this.tv);
        dest.writeString(this.books);
        dest.writeString(this.games);
        dest.writeString(this.about);
        dest.writeString(this.quotes);
        dest.writeByte(can_post ? byte(1 ): byte(0));
        dest.writeByte(can_see_all_posts ? byte(1 ): byte(0));
        dest.writeByte(can_write_private_message ? byte(1 ): byte(0));
        dest.writeByte(wall_comments ? byte(1 ): byte(0));
        dest.writeByte(is_banned ? byte(1 ): byte(0));
        dest.writeByte(is_deleted ? byte(1 ): byte(0));
        dest.writeByte(wall_default_owner ? byte(1 ): byte(0));
        dest.writeByte(verified ? byte(1 ): byte(0));
        dest.writeInt(this.sex);
        dest.writeParcelable(this.counters, flags);
        dest.writeInt(this.relation);
        dest.writeParcelable(this.relatives, flags);
        dest.writeByte(blacklisted_by_me ? byte(1 ): byte(0));
    }
    public function VKApiUserFull() {}
    public function VKApiUserFull(in:Parcel) {
        super(in);
        this.activity = in.readString();
        this.status_audio = in.readParcelable(VKApiAudio.class.getClassLoader());
        this.bdate = in.readString();
        this.city = in.readParcelable(VKApiCity.class.getClassLoader());
        this.country = in.readParcelable(VKApiCountry.class.getClassLoader());
        this.last_seen = in.readLong();
        this.universities = in.readParcelable(VKList.class.getClassLoader());
        this.schools = in.readParcelable(VKList.class.getClassLoader());
        this.smoking = in.readInt();
        this.alcohol = in.readInt();
        this.political = in.readInt();
        this.life_main = in.readInt();
        this.people_main = in.readInt();
        this.inspired_by = in.readString();
        this.langs = in.createStringArray();
        this.religion = in.readString();
        this.facebook = in.readString();
        this.facebook_name = in.readString();
        this.livejournal = in.readString();
        this.skype = in.readString();
        this.site = in.readString();
        this.twitter = in.readString();
        this.instagram = in.readString();
        this.mobile_phone = in.readString();
        this.home_phone = in.readString();
        this.screen_name = in.readString();
        this.activities = in.readString();
        this.interests = in.readString();
        this.movies = in.readString();
        this.tv = in.readString();
        this.books = in.readString();
        this.games = in.readString();
        this.about = in.readString();
        this.quotes = in.readString();
        this.can_post = in.readByte() != 0;
        this.can_see_all_posts = in.readByte() != 0;
        this.can_write_private_message = in.readByte() != 0;
        this.wall_comments = in.readByte() != 0;
        this.is_banned = in.readByte() != 0;
        this.is_deleted = in.readByte() != 0;
        this.wall_default_owner = in.readByte() != 0;
        this.verified = in.readByte() != 0;
        this.sex = in.readInt();
        this.counters = in.readParcelable(Counters.class.getClassLoader());
        this.relation = in.readInt();
        this.relatives = in.readParcelable(VKList.class.getClassLoader());
        this.blacklisted_by_me = in.readByte() != 0;
    }

    public static Creator<VKApiUserFull> CREATOR = new Creator<VKApiUserFull>() {
        public function createFromParcel(source:Parcel):VKApiUserFull {
            return new VKApiUserFull(source);
        }

        public VKApiUserFull[] newArray(var size:int) {
            return new VKApiUserFull[size];
        }
    };
}