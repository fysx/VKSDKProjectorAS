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

package com.vk.sdk {
import flash.utils.Dictionary;

/**
 * Presents VK API access token that used for loading API methods and other stuff.
 */
public class VKAccessToken {
    public static const ACCESS_TOKEN:String = "access_token";
    public static const EXPIRES_IN:String = "expires_in";
    public static const USER_ID:String = "user_id";
    public static const SECRET:String = "secret";
    public static const HTTPS_REQUIRED:String = "https_required";
    public static const CREATED:String = "created";
    public static const SUCCESS:String = "success";

    /**
     * String token for use in request parameters
     */
    public var accessToken:String = "";
    /**
     * Time when token expires
     */
    public var expiresIn:int= 0;
    /**
     * Current user id for this token
     */
    public var userId:String = "";
    /**
     * User secret to sign requests (if nohttps used)
     */
    public var secret:String = "";
    /**
     * If user sets "Always use HTTPS" setting in his profile, it will be true
     */
    public var httpsRequired:Boolean= false;

    /**
     * Indicates time of token creation
     */
    public var created:Number = 0;

	public function VKAccessToken(accessToken_:String, expiresIn_:int, userId_:String, secret_:String, httpsRequired_:Boolean):void {
		accessToken = accessToken_;
		expiresIn = expiresIn_;
		userId = userId_;
		secret = secret_;
		httpsRequired = httpsRequired_;
	}
    /**
     * Retrieve token from key-value query string
     *
     * @param urlString string that contains URL-query part with token. E.g. access_token=eee&expires_in=0...
     * @return parsed token
     */
    public static function tokenFromUrlString(urlString:String):VKAccessToken {
    /*    if (urlString == null)
            return null;
        Map<String, String> parameters = VKUtil.explodeQueryString(urlString);

        return tokenFromParameters(parameters);*/
		return null;
    }

    /**
     * Retrieve token from key-value map
     *
     * @param parameters map that contains token info
     * @return Parsed token
     */
	/*
    public static function tokenFromParameters(Map<String, String> parameters):VKAccessToken {
        if (parameters == null || parameters.size() == 0)
            return null;
        var token:VKAccessToken= new VKAccessToken();
        try {
            token.accessToken = parameters.get(ACCESS_TOKEN);
            token.expiresIn = Integer.parseInt(parameters.get(EXPIRES_IN));
            token.userId = parameters.get(USER_ID);
            token.secret = parameters.get(SECRET);
            token.httpsRequired = false;

            if (parameters.containsKey(HTTPS_REQUIRED)) {
                token.httpsRequired = parameters.get(HTTPS_REQUIRED) == ("1");
            } else if (token.secret == null) {
                token.httpsRequired = true;
            }

            if (parameters.containsKey(CREATED)) {
                token.created = Long.parseLong(parameters.get(CREATED));
            } else {
                token.created = System.currentTimeMillis();
            }

            return token;
        } catch (e:Exception) {
            return null;
        }
    }
*/

    /**
     * Retrieve token from file. Token must be saved into file with saveTokenToFile method
     *
     * @param filePath path to file with saved token
     * @return Previously saved token or null
     */
/*    public static function tokenFromFile(filePath:String):VKAccessToken {
        try {
            var data:String= VKUtil.fileToString(filePath);
            return tokenFromUrlString(data);
        } catch (e:Exception) {
            return null;
        }
    }
*/
    /**
     * Checks expiration time of token and returns result.
     *
     * @return true if token has expired, false otherwise.
     */
    public function isExpired():Boolean {
        return false;// expiresIn > 0 && expiresIn * 1000 + created < System.currentTimeMillis();
    }
}
}