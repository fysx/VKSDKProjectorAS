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
import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;

import java.util.Locale;

/**
 * Activity for request OAuth authorization in case of missing VK app.
 */
public class VKOpenAuthActivity extends Activity {
    public static const VK_EXTRA_CLIENT_ID:String= "client_id";
    public static const VK_EXTRA_SCOPE:String= "scope";
    public static const VK_EXTRA_API_VERSION:String= "version";
    public static const VK_EXTRA_REVOKE:String= "revoke";

    public static const VK_RESULT_INTENT_NAME:String= "com.vk.auth-token";
    public static const VK_EXTRA_TOKEN_DATA:String= "extra-token-data";
	public static const VK_EXTRA_VALIDATION_URL:String= "extra-validation-url";
    public static const VK_EXTRA_VALIDATION_REQUEST:String= "extra-validation-reques";

    private static const REDIRECT_URL:String= "https://oauth.vk.com/blank.html";

    protected var mWebView:WebView;

    
override protected function onCreate(savedInstanceState:Bundle):void {
        super.onCreate(savedInstanceState);
        setContentView(new VKOpenAuthView(this));

        hideActionBar();
        findViewById(android.R.id.content).setBackgroundColor(Color.rgb(240, 242, 245));
        loadPage();
    }

    private function loadPage():void {
        try {
	        var urlToLoad:String;
	        urlToLoad = getIntent().getStringExtra(VK_EXTRA_VALIDATION_URL);
	        if (urlToLoad == null)
	        {
	            var appId:int= getIntent().getIntExtra(VK_EXTRA_CLIENT_ID, 0);
	            var scope:String= getIntent().getStringExtra(VK_EXTRA_SCOPE),
	                    apiV = getIntent().getStringExtra(VK_EXTRA_API_VERSION);
	            var revoke:Boolean= getIntent().getBooleanExtra(VK_EXTRA_REVOKE, false);
	            urlToLoad = String.format(Locale.US,
	                    "https://oauth.vk.com/authorize?client_id=%s" +
	                            "&scope=%s" +
	                            "&redirect_uri=%s" +
	                            "&display=mobile" +
	                            "&v=%s" +
	                            "&response_type=token&revoke=%d",
	                    appId, scope, REDIRECT_URL, apiV, revoke ? 1: 0);
	        }
            mWebView = WebView(findViewById(android.R.id.copyUrl));
            mWebView.setWebViewClient(new OAuthWebViewClient());
            var webSettings:WebSettings= mWebView.getSettings();
            webSettings.setJavaScriptEnabled(true);
            mWebView.loadUrl(urlToLoad);
            mWebView.setVisibility(View.INVISIBLE);

        } catch (e:Exception) {
            setResult(RESULT_CANCELED);
            finish();
        }
    }

    private function hideActionBar():void {
        try {
            if (Build.VERSION.SDK_INT >= 11&& getActionBar() != null) {
                getActionBar().hide();
            }
        } catch (ignored:Exception) {
        }
    }
}

import android.view.View;
import android.webkit.WebView;
import android.os.Build;
import android.content.DialogInterface;
import android.app.Activity;
import android.webkit.WebViewClient;
import android.app.AlertDialog;
import android.graphics.Bitmap;
import android.content.Intent;

    private 
internal class OAuthWebViewClient extends WebViewClient {
        public var canShowPage:Boolean= true;
        private function processUrl(url:String):Boolean {
            if (url.startsWith(REDIRECT_URL)) {
                var data:Intent= new Intent(VK_RESULT_INTENT_NAME);
                data.putExtra(VK_EXTRA_TOKEN_DATA, url.substring(url.indexOf('#') + 1));
                if (getIntent().hasExtra(VK_EXTRA_VALIDATION_URL))
                    data.putExtra(VK_EXTRA_VALIDATION_URL, true);
                if (getIntent().hasExtra(VK_EXTRA_VALIDATION_REQUEST))
                    data.putExtra(VK_EXTRA_VALIDATION_REQUEST, getIntent().getLongExtra(VK_EXTRA_VALIDATION_REQUEST,0));
                setResult(RESULT_OK, data);
                finish();
                return true;
            }
            return false;
        }
        
override public function shouldOverrideUrlLoading(view:WebView, url:String):Boolean {
            if (processUrl(url))
                return true;
            canShowPage = true;
            return false;
        }

        
override public function onPageStarted(view:WebView, url:String, favicon:Bitmap):void {
            super.onPageStarted(view, url, favicon);
            processUrl(url);
        }

        
override public function onPageFinished(view:WebView, url:String):void {
            super.onPageFinished(view, url);
            if (canShowPage)
                view.setVisibility(View.VISIBLE);
        }

        
override public function onReceivedError(view:WebView, errorCode:int, description:String, failingUrl:String):void {
            super.onReceivedError(view, errorCode, description, failingUrl);
            canShowPage = false;
            var builder:AlertDialog.Builder= new AlertDialog.Builder(VKOpenAuthActivity.this)
                    .setMessage(description)
                    .setPositiveButton(R.string.vk_retry, new DialogInterface.OnClickListener() {
                        
override public function onClick(dialogInterface:DialogInterface, i:int):void {
                            loadPage();
                        }
                    })
                    .setNegativeButton(android.R.string.cancel, new DialogInterface.OnClickListener() {
                        
override public function onClick(dialogInterface:DialogInterface, i:int):void {
                            finish();
                        }
                    });
            try {
                builder.show();
            } catch (e:Exception) {
                if (VKSdk.DEBUG)
                	e.printStackTrace();
            }
        }
    }

    
override public function onBackPressed():void {
        var data:Intent= new Intent(VK_RESULT_INTENT_NAME);
        setResult(RESULT_CANCELED, data);
        super.onBackPressed();
    }

import android.view.View;
import android.webkit.WebView;
import android.content.Context;
import android.widget.RelativeLayout;
import android.widget.ProgressBar;

    private static 
internal class VKOpenAuthView extends RelativeLayout {
        public function VKOpenAuthView(context:Context) {
            super(context);
            var progress:ProgressBar= new ProgressBar(context);
            var lp:LayoutParams= new LayoutParams(LayoutParams.WRAP_CONTENT,
                    LayoutParams.WRAP_CONTENT);
            lp.addRule(RelativeLayout.CENTER_IN_PARENT, 1);
            progress.setLayoutParams(lp);
            addView(progress);

            var webView:WebView= new WebView(context);
            lp = new LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT);
            webView.setLayoutParams(lp);
            addView(webView);
            webView.setId(android.R.id.copyUrl);
            webView.setVisibility(View.INVISIBLE);
        }
    }
}