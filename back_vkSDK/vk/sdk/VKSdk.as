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

import com.vk.sdk.api.VKError;
import com.vk.sdk.api.VKRequest;
import com.vk.sdk.util.VKStringJoiner;
import com.vk.sdk.util.VKUtil;

/**
 * Entry point of SDK. See example for using properly
 */
public class VKSdk {

    public static const DEBUG:Boolean= false;
	public static const DEBUG_API_ERRORS:Boolean= false;
	public static const SDK_TAG:String= "VK SDK";
    /**
     * Start SDK activity for result with that request code
     */
    public static const VK_SDK_REQUEST_CODE:int= 0x228;

    /**
     * Instance of SDK
     */
    private static volatile var sInstance:VKSdk;

    private static const VK_SDK_ACCESS_TOKEN_PREF_KEY:String= "VK_SDK_ACCESS_TOKEN_PLEASE_DONT_TOUCH";

    /**
     * Responder for global SDK events
     */
    private var mListener:VKSdkListener;

    /**
     * Access token for API-requests
     */
    private var mAccessToken:VKAccessToken;

    /**
     * App id for current application
     */
    private var mCurrentAppId:String;


    private function VKSdk() {

    }


    function getContext():Context {
        return VKUIHelper.getApplicationContext();
    }

    private static function checkConditions():void {
        if (sInstance == null) {
            throw new BindException("VK Sdk not yet initialized");
        }

        if (sInstance.getContext() == null) {
            throw new BindException("Context must not be null");
        }
    }

    /**
     * Returns instance of VK sdk. You should never use that directly
     */
    public static function instance():VKSdk {
        return sInstance;
    }

    /**
     * Initialize SDK with responder for global SDK events
     *
     * @param listener responder for global SDK events
     * @param appId    your application id (if you haven't, you can create standalone application here https://vk.com/editapp?act=create )
     */
    public static function initialize(listener:VKSdkListener, appId:String):void {
        if (listener == null) {
            throw new NullPointerException("VK SDK listener cannot be null");
        }

        if (appId == null) {
            throw new NullPointerException("Application ID cannot be null");
        }

        // Double checked locking singleton, for thread safety VKSdk.initialize() calls
        if (sInstance == null) {
            synchronized (VKSdk.class) {
                if (sInstance == null) {
                    sInstance = new VKSdk();
                }
            }
        }

        sInstance.mListener = listener;
        sInstance.mCurrentAppId = appId;
    }

    /**
     * Initialize SDK with responder for global SDK events and custom token key
     * (e.g., saved from other source or for some test reasons)
     *
     * @param listener responder for global SDK events
     * @param appId    your application id (if you haven't, you can create standalone application here https://vk.com/editapp?act=create )
     * @param token    custom-created access token
     */
    public static function initialize(listener:VKSdkListener, appId:String, token:VKAccessToken):void {
        initialize(listener, appId);
        sInstance.mAccessToken = token;
        sInstance.performTokenCheck(token, true);
    }

    /**
     * Starts authorization process. If VKapp is available in system, it will opens and requests access from user.
     * Otherwise UIWebView with standard UINavigationBar will be opened for access request.
     *
     * @param scope array of permissions for your applications. All permissions you can
     */
    public static function authorize( ... scope):void {
        authorize(scope, false, false);
    }

    /**
     * Defines true VK application fingerprint
     */
    private static const VK_APP_FINGERPRINT:String= "48761EEF50EE53AFC4CC9C5F10E6BDE7F8F5B82F";
    private static const VK_APP_PACKAGE_ID:String= "com.vkontakte.android";
    private static const VK_APP_AUTH_ACTION:String= "com.vkontakte.android.action.SDK_AUTH";

    /**
     * Starts authorization process. If VKapp is available in system, it will opens and requests access from user.
     * Otherwise UIWebView with standard UINavigationBar will be opened for access request.
     *
     * @param scope      array of permissions for your applications. All permissions you can
     * @param revoke     if true, user will allow logout (to change user)
     * @param forceOAuth sdk will use only oauth authorization, through uiwebview
     */
    public static function authorize(scope:Array, revoke:Boolean, forceOAuth:Boolean):void {
        try {
            checkConditions();
        } catch (e:Exception) {
            if (VKSdk.DEBUG)
                e.printStackTrace();
            return;
        }

        if (scope == null) {
            scope = new String[]{};
        }
        ArrayList<String> scopeList = new ArrayList<String>(Arrays.asList(scope));
        if (!scopeList.contains(VKScope.OFFLINE)) {
            scopeList.add(VKScope.OFFLINE);
        }

        var intent:Intent;

        if (!forceOAuth
                && VKUtil.isAppInstalled(sInstance.getContext(), VK_APP_PACKAGE_ID)
                && VKUtil.isIntentAvailable(sInstance.getContext(), VK_APP_AUTH_ACTION)) {
            intent = new Intent(VK_APP_AUTH_ACTION, null);
        } else {
            intent = new Intent(sInstance.getContext(), VKOpenAuthActivity.class);
        }

        intent.putExtra(VKOpenAuthActivity.VK_EXTRA_API_VERSION, VKSdkVersion.API_VERSION);
        intent.putExtra(VKOpenAuthActivity.VK_EXTRA_CLIENT_ID, Integer.parseInt(sInstance.mCurrentAppId));

        if (revoke) {
            intent.putExtra(VKOpenAuthActivity.VK_EXTRA_REVOKE, true);
        }

        intent.putExtra(VKOpenAuthActivity.VK_EXTRA_SCOPE, VKStringJoiner.join(scopeList, ","));

        if (VKUIHelper.getTopActivity() != null) {
            VKUIHelper.getTopActivity().startActivityForResult(intent, VK_SDK_REQUEST_CODE);
        }
    }

    /**
     * Returns current VK SDK listener
     *
     * @return Current sdk listener
     */
    public function sdkListener():VKSdkListener {
        return sInstance.mListener;
    }

    /**
     * Sets current VK SDK listener
     *
     * @param newListener listener for SDK
     */
    public function setSdkListener(newListener:VKSdkListener):void {
        sInstance.mListener = newListener;
    }

    /**
     * Pass data of onActivityResult() function here
     *
     * @param resultCode result code of activity result
     * @param result     intent passed by activity
     * @return If SDK parsed activity result properly, returns true. You can return from onActivityResult(). Otherwise, returns false.
     * @deprecated Use processActivityResult(int requestCode, int resultCode, Intent result) instead
     */
    public static function processActivityResult(resultCode:int, result:Intent):Boolean {
        return processActivityResult(VK_SDK_REQUEST_CODE, resultCode, result);
    }

    /**
     * Pass data of onActivityResult() function here
     *
     * @param requestCode request code of activity
     * @param resultCode result code of activity result
     * @param result     intent passed by activity
     * @return If SDK parsed activity result properly, returns true. You can return from onActivityResult(). Otherwise, returns false.
     */
    public static function processActivityResult(requestCode:int, resultCode:int, result:Intent):Boolean {
        if (requestCode != VK_SDK_REQUEST_CODE) return false;
        if (result != null) {
            if (resultCode == Activity.RESULT_CANCELED) {
                //Пользователь отменил (нажал назад)
                setAccessTokenError(new VKError(VKError.VK_CANCELED));
                return true;
            }
            if (resultCode == Activity.RESULT_OK) {
                //Получен токен
                if (result.hasExtra(VKOpenAuthActivity.VK_EXTRA_TOKEN_DATA)) {
                    var tokenInfo:String= result.getStringExtra(VKOpenAuthActivity.VK_EXTRA_TOKEN_DATA);
                    Map<String, String> tokenParams = VKUtil.explodeQueryString(tokenInfo);
                    var renew:Boolean= result.getBooleanExtra(VKOpenAuthActivity.VK_EXTRA_VALIDATION_URL, false);
                    if (checkAndSetToken(tokenParams, renew) == CheckTokenResult.Success) {
                        var validationRequest:VKRequest= VKRequest.getRegisteredRequest(result.getLongExtra(VKOpenAuthActivity.VK_EXTRA_VALIDATION_REQUEST, 0));
                        if (validationRequest != null) {
                            validationRequest.repeat();
                        }
                    }
                } else if (result.getExtras() != null) {
                    //Что-то пришло от Гриши
                    Map<String, String> tokenParams = new HashMap<String, String>();
                    for (String key : result.getExtras().keySet()) {
                        tokenParams.put(key, String.valueOf(result.getExtras().get(key)));
                    }
                    return checkAndSetToken(tokenParams, false) != CheckTokenResult.None;
                }
                return true;
            }
            return false;
        }
        setAccessTokenError(new VKError(VKError.VK_CANCELED));
        return true;
    }

    enum CheckTokenResult {
        None,
        Success,
        Error
    }

    /**
     * Check new access token and sets it as working token
     *
     * @param tokenParams params of token
     * @param renew       flag indicates token renewal
     * @return true if access token was set, or error was provided
     */
    private static function checkAndSetToken(Map<String, String> tokenParams, renew:Boolean):CheckTokenResult {

        var token:VKAccessToken= VKAccessToken.tokenFromParameters(tokenParams);
        if (token == null || token.accessToken == null) {
            if (tokenParams.containsKey(VKAccessToken.SUCCESS)) {
                return CheckTokenResult.Success;
            }

            var error:VKError= new VKError(tokenParams);
            if (error.errorMessage != null || error.errorReason != null) {
                setAccessTokenError(error);
                return CheckTokenResult.Error;
            }
        } else {
            setAccessToken(token, renew);
            return CheckTokenResult.Success;
        }
        return CheckTokenResult.None;
    }

    /**
     * Set API token to passed
     *
     * @param token token must be used for API requests
     * @param renew flag indicates token renewal
     */
    public static function setAccessToken(token:VKAccessToken, renew:Boolean):void {
        sInstance.mAccessToken = token;

        if (sInstance.mListener != null) {
            if (!renew) {
                sInstance.mListener.onReceiveNewToken(token);
            } else {
                sInstance.mListener.onRenewAccessToken(token);
            }
        }
        sInstance.mAccessToken.saveTokenToSharedPreferences(VKUIHelper.getApplicationContext(), VK_SDK_ACCESS_TOKEN_PREF_KEY);
    }

    /**
     * Returns token for API requests
     *
     * @return Received access token or null, if user not yet authorized
     */
    public static function getAccessToken():VKAccessToken {
        if (sInstance.mAccessToken != null) {
            if (sInstance.mAccessToken.isExpired() && sInstance.mListener != null) {
                sInstance.mListener.onTokenExpired(sInstance.mAccessToken);
            }
            return sInstance.mAccessToken;
        }

        return null;
    }

    /**
     * Notify SDK that user denied login
     *
     * @param error description of error while authorizing user
     */
    public static function setAccessTokenError(error:VKError):void {
        if (sInstance.mListener != null) {
            sInstance.mListener.onAccessDenied(error);
        }
    }

    private function performTokenCheck(token:VKAccessToken, isUserToken:Boolean):Boolean {
        if (token != null) {
            if (token.isExpired()) {
                mListener.onTokenExpired(token);
            } else if (token.accessToken != null) {
                if (isUserToken) mListener.onAcceptUserToken(token);
                return true;
            } else {
                var error:VKError= new VKError(VKError.VK_CANCELED);
                error.errorMessage = "User token is invalid";
                mListener.onAccessDenied(error);
            }
        }
        return false;
    }

    public static function wakeUpSession():Boolean {
        var token:VKAccessToken= VKAccessToken.tokenFromSharedPreferences(VKUIHelper.getTopActivity(),
                VK_SDK_ACCESS_TOKEN_PREF_KEY);

        if (sInstance.performTokenCheck(token, false)) {
            sInstance.mAccessToken = token;
            return true;
        }
        return false;
    }

    public static function logout():void {
        CookieSyncManager.createInstance(VKUIHelper.getApplicationContext());
        var cookieManager:CookieManager= CookieManager.getInstance();
        cookieManager.removeAllCookie();

        sInstance.mAccessToken = null;
        VKAccessToken.removeTokenAtKey(VKUIHelper.getApplicationContext(), VK_SDK_ACCESS_TOKEN_PREF_KEY);
    }

    public static function isLoggedIn():Boolean {
        return sInstance.mAccessToken != null && !sInstance.mAccessToken.isExpired();
    }
}
}