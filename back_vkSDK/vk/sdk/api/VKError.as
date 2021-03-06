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
import android.net.Uri;

import com.vk.sdk.VKObject;
import com.vk.sdk.util.VKJsonHelper;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Map;

/**
 * Class for presenting VK SDK and VK API errors
 */
public class VKError extends VKObject {
	public static const VK_API_ERROR:int= -101;
    /**
     * @deprecated Use VK_CANCELED instead
     */
    public static const VK_API_CANCELED:int= -102;
    public static const VK_CANCELED:int= -102;

    /**
     * @deprecated Use VK_REQUEST_NOT_PREPARED instead
     */
    public static const VK_API_REQUEST_NOT_PREPARED:int= -103;
    public static const VK_REQUEST_NOT_PREPARED:int= -103;

    /**
     * @deprecated Use VK_JSON_FAILED instead
     */
    public static const VK_API_JSON_FAILED:int= -104;
    public static const VK_JSON_FAILED:int= -104;

    /**
     * @deprecated Use VK_REQUEST_HTTP_FAILED instead
     */
    public static const VK_API_REQUEST_HTTP_FAILED:int= -105;
    public static const VK_REQUEST_HTTP_FAILED:int= -105;

    /**
     * Contains system HTTP error
     */
    public var httpError:Exception;
    /**
     * Describes API error
     */
    public var apiError:VKError;
    /**
     * Request which caused error
     */
    public var request:VKRequest;
    /**
     * May contains such errors:<br/>
     * <b>HTTP status code</b> if HTTP error occured;<br/>
     * <b>VK_API_ERROR</b> if API error occured;<br/>
     * <b>VK_API_CANCELED</b> if request was canceled;<br/>
     * <b>VK_API_REQUEST_NOT_PREPARED</b> if error occured while preparing request;
     */
    public var errorCode:int;
    /**
     * API error message
     */
    public var errorMessage:String;
    /**
     * Reason for authorization fail
     */
    public var errorReason:String;
    /**
     * API parameters passed to request
     */
    public ArrayList<Map<String, String>> requestParams;
    /**
     * Captcha identifier for captcha-check
     */
    public var captchaSid:String;
    /**
     * Image for captcha-check
     */
    public var captchaImg:String;
    /**
     * Redirection address if validation check required
     */
    public var redirectUri:String;

    /**
     * Generate new error with code
     *
     * @param errorCode positive if it's an HTTP error. Negative if it's API or SDK error
     */
    public function VKError(errorCode:int) {
        this.errorCode = errorCode;
    }

    /**
     * Generate API error from JSON
     *
     * @param json Json description of VK API error
     */
    public function VKError(json:JSONObject) {
        var internalError:VKError= new VKError(json.getInt(VKApiConst.ERROR_CODE));
        internalError.errorMessage = json.getString(VKApiConst.ERROR_MSG);
        internalError.requestParams = (ArrayList<Map<String, String>>) VKJsonHelper.toList(
                json.getJSONArray(VKApiConst.REQUEST_PARAMS));
        if (internalError.errorCode == 14) {
            internalError.captchaImg = json.getString(VKApiConst.CAPTCHA_IMG);
            internalError.captchaSid = json.getString(VKApiConst.CAPTCHA_SID);
        }
        if (internalError.errorCode == 17) {
            internalError.redirectUri = json.getString(VKApiConst.REDIRECT_URI);
        }

        this.errorCode = VK_API_ERROR;
        this.apiError = internalError;
    }

    private static const FAIL:String= "fail";
    private static const ERROR_REASON:String= "error_reason";
    private static const ERROR_DESCRIPTION:String= "error_description";

    /**
     * Generate API error from HTTP-query
     *
     * @param queryParams key-value parameters
     */
    public function VKError(Map<String, String> queryParams) {
        this.errorCode = VK_API_ERROR;
        this.errorReason = queryParams.get(ERROR_REASON);
        this.errorMessage = Uri.decode(queryParams.get(ERROR_DESCRIPTION));
        if (queryParams.containsKey(FAIL)) {
            this.errorReason = "Action failed";
        }
        if (queryParams.containsKey("cancel")) {
            this.errorCode   = VK_CANCELED;
            this.errorReason = "User canceled request";
        }
    }

    /**
     * Repeats failed captcha request with user entered answer to captcha
     *
     * @param userEnteredCode answer for captcha
     */
    public function answerCaptcha(userEnteredCode:String):void {
        var params:VKParameters= new VKParameters();
        params.put(VKApiConst.CAPTCHA_SID, captchaSid);
        params.put(VKApiConst.CAPTCHA_KEY, userEnteredCode);
        request.addExtraParameters(params);
        request.repeat();
    }
    public static function getRegisteredError(requestId:Number):VKError {
        return VKError(getRegisteredObject(requestId));
    }

    private function appendFields(builder:StringBuilder):void {
        if (errorReason != null)
            builder.append(String.format("; %s", errorReason));
        if (errorMessage != null)
            builder.append(String.format("; %s", errorMessage));
    }

	
override public function toString():String {
		var errorString:StringBuilder= new StringBuilder("VKError (");
		switch (this.errorCode) {
			case VK_API_ERROR:
				errorString.append("API error");
                if (apiError != null) {
                    errorString.append(apiError.toString());
                }
				break;
			case VK_CANCELED:
				errorString.append("Canceled");
				break;
			case VK_REQUEST_NOT_PREPARED:
				errorString.append("Request wasn't prepared");
				break;
			case VK_JSON_FAILED:
				errorString.append("JSON failed");

				break;
			case VK_REQUEST_HTTP_FAILED:
				errorString.append("HTTP failed");
				break;

			default:
				errorString.append(String.format("code: %d; ", errorCode));
				break;
		}
        appendFields(errorString);
		errorString.append(")");
		return errorString.toString();
	}
}
}