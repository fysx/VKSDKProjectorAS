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

package com.vk.sdk.api {
/**
 * Constants for api. List is not full
 */
public class VKApiConst {
    //Commons
    public static const USER_ID:String= "user_id";
    public static const USER_IDS:String= "user_ids";
    public static const FIELDS:String= "fields";
    public static const SORT:String= "sort";
    public static const OFFSET:String= "offset";
    public static const COUNT:String= "count";
    public static const OWNER_ID:String= "owner_id";

    //auth
    public static const VERSION:String= "v";
    public static const HTTPS:String= "https";
    public static const LANG:String= "lang";
    public static const ACCESS_TOKEN:String= "access_token";
    public static const SIG:String= "sig";

    //get users
    public static const NAME_CASE:String= "name_case";

    //Get subscriptions
    public static const EXTENDED:String= "extended";

    //Search
    public static const Q:String= "q";
    public static const CITY:String= "city";
    public static const COUNTRY:String= "country";
    public static const HOMETOWN:String= "hometown";
    public static const UNIVERSITY_COUNTRY:String= "university_country";
    public static const UNIVERSITY:String= "university";
    public static const UNIVERSITY_YEAR:String= "university_year";
    public static const SEX:String= "sex";
    public static const STATUS:String= "status";
    public static const AGE_FROM:String= "age_from";
    public static const AGE_TO:String= "age_to";
    public static const BIRTH_DAY:String= "birth_day";
    public static const BIRTH_MONTH:String= "birth_month";
    public static const BIRTH_YEAR:String= "birth_year";
    public static const ONLINE:String= "online";
    public static const HAS_PHOTO:String= "has_photo";
    public static const SCHOOL_COUNTRY:String= "school_country";
    public static const SCHOOL_CITY:String= "school_city";
    public static const SCHOOL:String= "school";
    public static const SCHOOL_YEAR:String= "school_year";
    public static const RELIGION:String= "religion";
    public static const INTERESTS:String= "interests";
    public static const COMPANY:String= "company";
    public static const POSITION:String= "position";
    public static const GROUP_ID:String= "group_id";

    public static const FRIENDS_ONLY:String= "friends_only";
    public static const FROM_GROUP:String= "from_group";
    public static const MESSAGE:String= "message";
    public static const ATTACHMENTS:String= "attachments";
    public static const SERVICES:String= "services";
    public static const SIGNED:String= "signed";
    public static const PUBLISH_DATE:String= "publish_date";
    public static const LAT:String= "lat";
    public static const LONG:String= "long";
    public static const PLACE_ID:String= "place_id";
    public static const POST_ID:String= "post_id";

    //Errors
    public static const ERROR_CODE:String= "error_code";
    public static const ERROR_MSG:String= "error_msg";
    public static const REQUEST_PARAMS:String= "request_params";

    //Captcha
    public static const CAPTCHA_IMG:String= "captcha_img";
    public static const CAPTCHA_SID:String= "captcha_sid";
    public static const CAPTCHA_KEY:String= "captcha_key";
    public static const REDIRECT_URI:String= "redirect_uri";

    //Photos
    public static const PHOTO:String= "photo";
    public static const PHOTOS:String= "photos";
    public static const ALBUM_ID:String= "album_id";
    public static const PHOTO_IDS:String= "photo_ids";
    public static const PHOTO_SIZES:String= "photo_sizes";
    public static const REV:String= "rev";
    public static const FEED_TYPE:String= "feed_type";
    public static const FEED:String= "feed";

    //Enums
    enum VKProgressType {
        VKProgressTypeUpload,
        VKProgressTypeDownload
    }

    //Events
    public static const VKCaptchaAnsweredEvent:String= "VKCaptchaAnsweredEvent";
}
}