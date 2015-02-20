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
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffXfermode;
import android.graphics.Rect;
import android.graphics.RectF;

/**
 * Class for VK authorization and dialogs helping
 */
public class VKUIHelper {
	private static var sTopActivity:Activity;
	private static var sApplicationContext:Context;

	public static function getTopActivity():Activity {
		return sTopActivity;
	}
	public static function getApplicationContext():Context { return sApplicationContext; }
	/**
	 * Call it in onCreate for of activities where you using VK SDK
	 * @param activity Your activity
	 */
	public static function onCreate(activity:Activity):void {
		if (sTopActivity != activity)
			sTopActivity = activity;
		if (sApplicationContext == null && activity != null) {
			sApplicationContext = activity.getApplicationContext();
		}
	}

	/**
	 * Call it in onResume for of activities where you using VK SDK
	 * @param activity Your activity
	 */
	public static function onResume(activity:Activity):void {
		if (sTopActivity != activity)
			sTopActivity = activity;
		if (sApplicationContext == null && activity != null) {
			sApplicationContext = activity.getApplicationContext();
		}
	}

	/**
	 * Call it in onDestroy for of activities where you using VK SDK
	 * @param activity Your activity
	 */
	public static function onDestroy(activity:Activity):void {
		if (sTopActivity == activity)
			sTopActivity = null;
	}

	/**
	 * Call it in onActivityResult of all activities where you using VK SDK
	 * @param requestCode Request code for startActivityForResult
	 * @param resultCode Result code of finished activity
	 * @param data Result data
	 * @deprecated Use onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) instead
	 */
	public static function onActivityResult(requestCode:int, resultCode:int, data:Intent):void {
		onActivityResult(sTopActivity, requestCode, resultCode, data);
    }

    /**
     * Call it in onActivityResult of all activities where you using VK SDK
     * @param requestCode Request code for startActivityForResult
     * @param resultCode Result code of finished activity
     * @param data Result data
     */
    public static function onActivityResult(activity:Activity, requestCode:int, resultCode:int, data:Intent):void {
        sTopActivity = activity;
        if (requestCode == VKSdk.VK_SDK_REQUEST_CODE) {
            VKSdk.processActivityResult(requestCode, resultCode, data);
        }
    }
    public static function getRoundedCornerBitmap(bitmap:Bitmap, maxHeight:int,  pixels:int):Bitmap {
        maxHeight = int((getApplicationContext().getResources().getDisplayMetrics().density * maxHeight));
        var scale:Number= bitmap.getHeight() * 1.0/ maxHeight;
        var newWidth:int= int((bitmap.getWidth() / scale));

        var output:Bitmap= Bitmap.createBitmap(newWidth, maxHeight, Bitmap.Config.ARGB_8888);
        var canvas:Canvas= new Canvas(output);

        var color:int= 0x;
        var paint:Paint= new Paint();
        var rect:Rect= new Rect(0, 0, bitmap.getWidth(), bitmap.getHeight());
        var dstRect:Rect= new Rect(0, 0, newWidth, maxHeight);
        var rectF:RectF= new RectF(dstRect);

        paint.setAntiAlias(true);
        canvas.drawARGB(0, 0, 0, 0);
        paint.setColor(color);
        canvas.drawRoundRect(rectF, float(pixels), float(pixels), paint);

        paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.SRC_IN));
        canvas.drawBitmap(bitmap, rect, dstRect, paint);

        return output;
    }
}
}