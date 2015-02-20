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
import java.util.ArrayList;

/**
 * Application Access Permissions
 * @see <a href="http://vk.com/dev/permissions">http://vk.com/dev/permissions</a>
 */
public class VKScopes {

    private function VKScopes() {}

    /**
     * User allowed to send notifications to him/her.
     */
    public static var NOTIFY:String= "notify";
    
    /**
     * Access to friends.
     */
    public static var FRIENDS:String= "friends";
    
    /**
     * Access to photos.
     */
    public static var PHOTOS:String= "photos";  
    
    /**
     * Access to audios.
     */
    public static var AUDIO:String= "audio";
    
    /**
     * Access to videos.
     */
    public static var VIDEO:String= "video"; 
    
    /**
     * Access to documents.
     */
    public static var DOCS:String= "docs";
    
    /**
     * Access to user notes.
     */
    public static var NOTES:String= "notes";
    
    /**
     * Access to wiki pages.
     */
    public static var PAGES:String= "pages";
    
    /**
     * Access to user status.
     */
    public static var STATUS:String= "status";
    
    /**
     * Access to offers (obsolete methods).
     */
    public static var OFFERS:String= "offers";
    
    /**
     * Access to questions (obsolete methods).
     */
    public static var QUESTIONS:String= "questions";
    
    /**
     * Access to standard and advanced methods for the wall.
     */
    public static var WALL:String= "wall";
    
    /**
     * Access to user groups.
     */
    public static var GROUPS:String= "groups";
    
    /**
     * Access to advanced methods for messaging.
     */
    public static var MESSAGES:String= "messages";
    
    /**
     * Access to notifications about answers to the user.
     */
    public static var NOTIFICATIONS:String= "notifications";
    
    /**
     * Access to statistics of user groups and applications where he/she is an administrator.
     */
    public static var STATS:String= "stats";
    
    /**
     * Access to advanced methods for <a href="http://vk.com/dev/ads">Ads API</a>.
     */
    public static var ADS:String= "ads";
    
    /**
     * Access to API at any time from a third party server.
     */
    public static var OFFLINE:String= "offline"; 
    
    /**
     * Possibility to make API requests without HTTPS. <br />
     * <b>Note that this functionality is under testing and can be changed.</b>
     */
    public static var NOHTTPS:String= "nohttps";

    /**
     * Converts integer value of permissions into arraylist of constants
     * @param permissions integer permissions value
     * @return ArrayList contains string constants of permissions (scope)
     */
    public static ArrayList<String> parse(var permissions:int) {
        ArrayList<String> result = new ArrayList<String>();
        if ((permissions & 1) > 0) result.add(NOTIFY);
        if ((permissions & 2) > 0) result.add(FRIENDS);
        if ((permissions & 4) > 0) result.add(PHOTOS);
        if ((permissions & 8) > 0) result.add(AUDIO);
        if ((permissions & 16) > 0) result.add(VIDEO);
        if ((permissions & 128) > 0) result.add(PAGES);
        if ((permissions & 1024) > 0) result.add(STATUS);
        if ((permissions & 2048) > 0) result.add(NOTES);
        if ((permissions & 4096) > 0) result.add(MESSAGES);
        if ((permissions & 8192) > 0) result.add(WALL);
        if ((permissions & 32768) > 0) result.add(ADS);
        if ((permissions & 65536) > 0) result.add(OFFLINE);
        if ((permissions & 131072) > 0) result.add(DOCS);
        if ((permissions & 262144) > 0) result.add(GROUPS);
        if ((permissions & 524288) > 0) result.add(NOTIFICATIONS);
        if ((permissions & 1048576) > 0) result.add(STATS);
        return result;
    }
    
}
}