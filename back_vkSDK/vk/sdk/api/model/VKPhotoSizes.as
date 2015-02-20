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
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.Collections;

/**
 * Model to parse a list of photo with <a href="http://vk.com/dev/photo_sizes">photo sizes<a/> format.
 *
 * When {@code photo_sizes=1} parameter is used in methods,
 * response contains an info about original photo
 * copies with different sizes in sizes array with objects,
 * each of them contains following fields: <br />
 * <ul>
 *  <li>src — url of image copy;</li>
 *  <li> width — copy width, px;</li>
 *  <li> height — copy height, px;</li>
 *  <li>type — notation for copy size and ratio.</li>
 * </ul>
 */
public class VKPhotoSizes extends VKList<VKApiPhotoSize> implements Parcelable {

    private static var sQuality:Number= 1.0;

    /**
     * Sets the quality modifier for sampling algorithm of image resolution.
     * @param quality positive number between 0.0f and 1.0f.
     */
    public static function setQuality(quality:Number):void {
        sQuality = quality;
    }

    /**
     * Original width of photo in pixels.
     */
    private var mOriginalWidth:int= 1;

    /**
     * Original height of photo in pixels.
     */
    private var mOriginalHeight:int= 1;

    /**
     * URL of last image thumb for width sampling algorithm.
     */
    private var mWidthThumb:String;
    /**
     * URL of last image thumb for height sampling algorithm.
     */
    private var mHeightThumb:String;

    /**
     * Width of last image thumb for width sampling algorithm.
     */
    private var mLastWidth:int;

    /**
     * Height of last image thumb for width sampling algorithm.
     */
    private var mLastHeight:int;

    /**
     * Parser that's used for parsing photo sizes.
     */
    private Parser<VKApiPhotoSize> parser = new Parser<VKApiPhotoSize>() {
        
override public function parseObject(source:JSONObject):VKApiPhotoSize {
            return VKApiPhotoSize.parse(source, mOriginalWidth, mOriginalHeight);
        }
    };

    /**
     * Creates empty list of photo sizes.
     */
    public function VKPhotoSizes() {
        super();
    }

    /**
     * Creates and fills list of photo sizes.
     */
    public function VKPhotoSizes(from:JSONArray) {
        super();
        fill(from);
    }

    /**
     * Creates list of photo sizes which fill with according data.
     * @param from array of photo sizes returned by VK.
     * @param width original photo width in pixels.
     * @param height original photo height in pixels.
     */
    public function fill(from:JSONArray, width:int, height:int):void {
        setOriginalDimension(width, height);
        fill(from);
    }

    /**
     * Fill list according with given data.
     * @param from array of photo sizes returned by VK.
     */
    public function fill(from:JSONArray):void {
        fill(from, parser);
        sort();
    }

    /**
     * Return image according with given type of thumb.
     * @return  URL of image thumb, or null if image with this thumb is not found in the list.
     */
    public function getByType(type:String):String {
        for(VKApiPhotoSize size: this) {
            if(size.type == type) {
                return size.src;
            }
        }
        return null;
    }

    /**
     * Sets original image dimensions.
     * @param width original photo width in pixels.
     * @param height original photo height in pixels.
     */
    public function setOriginalDimension(width:int, height:int):void {
        if(width != 0) {
            this.mOriginalWidth = width;
        }
        if(height != 0) {
            this.mOriginalHeight = height;
        }
    }

    /**
     * Sorts thumbs according to their width.
     */
    public function sort():void {
        Collections.sort(this);
    }

    /**
     * Finds an image that fits perfectly into the specified dimensions.
     * Method is uses a cache of last thumbs for better performance.
     * @param width required minimum width of image in pixels.
     * @param height required minimum height of image in pixels.
     * @return URL of selected thumb or null if image with what parameters is not found.
     */
    public function getImageForDimension(width:int, height:int):String {
        return width >= height ? getImageForWidth(width) : getImageForHeight(height);
    }

    private function getImageForWidth(width:int):String {
        if((mWidthThumb != null && mLastWidth != width) || isEmpty()) {
            return mWidthThumb;
        }
        mLastWidth = width;
        mWidthThumb = null;
        width = int((width * sQuality));

        for(VKApiPhotoSize size : this) {
            if(size.width >= width) {
                mWidthThumb = size.src;
                break;
            }
        }
        return mWidthThumb;
    }

    private function getImageForHeight(height:int):String {
        if((mHeightThumb != null && mLastHeight != height) || isEmpty()) {
            return mHeightThumb;
        }
        mLastHeight = height;
        mHeightThumb = null;
        height = int((height * sQuality));

        for(VKApiPhotoSize size : this) {
            if(size.height >= height) {
                mHeightThumb = size.src;
                break;
            }
        }
        return mHeightThumb;
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        super.writeToParcel(dest, flags);
        dest.writeInt(this.mOriginalWidth);
        dest.writeInt(this.mOriginalHeight);
        dest.writeString(this.mWidthThumb);
        dest.writeInt(this.mLastWidth);
    }

    private function VKPhotoSizes(in:Parcel) {
        super(in);
        this.mOriginalWidth = in.readInt();
        this.mOriginalHeight = in.readInt();
        this.mWidthThumb = in.readString();
        this.mLastWidth = in.readInt();
    }

    public static Creator<VKPhotoSizes> CREATOR = new Creator<VKPhotoSizes>() {
        public function createFromParcel(source:Parcel):VKPhotoSizes {
            return new VKPhotoSizes(source);
        }

        public VKPhotoSizes[] newArray(var size:int) {
            return new VKPhotoSizes[size];
        }
    };
}
}