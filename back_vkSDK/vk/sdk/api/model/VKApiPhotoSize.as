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

/**
 * PhotoSize.java
 * VK Dev
 *
 * Created by Babichev Vitaly on 03.10.13.
 * Copyright (c) 2013 VK. All rights reserved.
 */
package com.vk.sdk.api.model {
import android.os.Parcel;
import android.os.Parcelable;
import android.text.TextUtils;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * Describes an photo info in <a href="http://vk.com/dev/photo_sizes">special format<a/>.
 *
 * Some methods returns information about copies of the original image in different sizes,
 * Represented as an array of sizes, containing a description of the objects of this class.
 *
 * <b>Sizes value example:</b>
 *
 * Original photo — https://pp.vk.me/c323930/v323930021/53fb/1VrEC2eSkZQ.jpg,1280x856px,
 * "width/height" ratio is 1.495327102803738
 *
 * <code>
 sizes: [{
    src: http://cs323930.vk.me/v323930021/53f7/OwV0l2YFJ7s.jpg
    width: 75,
    height: 50,
    type: 's'
    }, {
    src: http://cs323930.vk.me/v323930021/53f8/qX8MRNyUPqg.jpg,
    width: 130,
    height: 87,
    type: 'm'
    }, {
    src: http://cs323930.vk.me/v323930021/53f9/7fBJyr9OHMA.jpg,
    width: 604,
    height: 404,
    type: 'x'
    }, {
    src: http://cs323930.vk.me/v323930021/53fa/bskHpsuH6sM.jpg,
    width: 807,
    height: 540,
    type: 'y'
    }, {
    src: http://cs323930.vk.me/v323930021/53fb/1VrEC2eSkZQ.jpg,
    width: 1280,
    height: 856,
    type: 'z'
    }, {
    src: http://cs323930.vk.me/v323930021/53fc/iAl-TIHfRDY.jpg,
    width: 130,
    height: 87,
    type: 'o'
    }, {
    src: http://cs323930.vk.me/v323930021/53fd/qjD0fbHkgmI.jpg,
    width: 200,
    height: 134,
    type: 'p'
    }, {
    src: http://cs323930.vk.me/v323930021/53fe/3d2nCvvKQfw.jpg,
    width: 320,
    height: 214,
    type: 'q'
    }, {
    src: http://cs323930.vk.me/v323930021/53ff/uK_Nj34SIY8.jpg,
    width: 510,
    height: 341,
    type: 'r'
    }]
 * </code>
 *
 */
public class VKApiPhotoSize extends VKApiModel implements Comparable<VKApiPhotoSize>, Parcelable, Identifiable {

    /**
     * Proportional copy with 75px max width
     */
    public static var S:String= 's';

    /**
     *  Proportional copy with 130px max width
     */
    public static var M:String= 'm';

    /**
     * Proportional copy with 604px max width
     */
    public static var X:String= 'x';

    /**
     * Proportional copy with 807px max width
     */
    public static var Y:String= 'y';

    /**
     * If original image's "width/height" ratio is less or equal to 3:2, then proportional
     * copy with 130px max width. If original image's "width/height" ratio is more than 3:2,
     * then copy of cropped by left side image with 130px max width and 3:2 sides ratio.
     */
    public static var O:String= 'o';

    /**
     * If original image's "width/height" ratio is less or equal to 3:2, then proportional
     * copy with 200px max width. If original image's "width/height" ratio is more than 3:2,
     * then copy of cropped by left side image with 200px max width and 3:2 sides ratio.
     */
    public static var P:String= 'p';

    /**
     * If original image's "width/height" ratio is less or equal to 3:2, then proportional
     * copy with 320px max width. If original image's "width/height" ratio is more than 3:2,
     * then copy of cropped by left side image with 320px max width and 3:2 sides ratio.
     */
    public static var Q:String= 'q';

    /**
     * Proportional copy with 1280x1024px max size
     */
    public static var Z:String= 'z';

    /**
     * Proportional copy with 2560x2048px max size
     */
    public static var W:String= 'w';

    /**
     * Url of image
     */
    public var src:String;

    /**
     * Width of image in pixels
     */
    public var width:int;

    /**
     * Height of image in pixels
     */
    public var height:int;

    /**
     * Designation of size and proportions copy, @see {{@link #S}, {@link #M}, {@link #X}, {@link #O}, {@link #P}, {@link #Q}, {@link #Y}, {@link #Z}, {@link #W}}
     */
    public var type:String;

    private function VKApiPhotoSize() {

    }

    private function VKApiPhotoSize(in:Parcel) {
        this.src = in.readString();
        this.width = in.readInt();
        this.height = in.readInt();
        this.type = char(in.readInt());
    }

    
override public function compareTo(another:VKApiPhotoSize):int {
        // Так как основной превалирующий элемент в фотографиях именно ширина и все фотографии пропорциональны,
        // то сравниваем именно по ней
        return this.width < another.width ? -1: (this.width == another.width ? 0: 1);
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        dest.writeString(this.src);
        dest.writeInt(this.width);
        dest.writeInt(this.height);
        dest.writeInt(int(this.type));
    }

    
override public function getId():int {
        return 0;
    }

    public static Creator<VKApiPhotoSize> CREATOR = new Creator<VKApiPhotoSize>() {
        public function createFromParcel(source:Parcel):VKApiPhotoSize {
            return new VKApiPhotoSize(source);
        }

        public VKApiPhotoSize[] newArray(var size:int) {
            return new VKApiPhotoSize[size];
        }
    };

	public function VKApiPhotoSize(from:JSONObject) {
		parse(from, 0, 0);
	}
    /**
     * Creates dimension from {@code source}. Used in parsing.
     * If size is not specified copies calculates them based on internal algorithms.
     * @param source object in format, returned VK API, which is generated from the dimension
     * @param originalWidth original image width in pixels
     * @param originalHeight original image height in pixels
     */
    public static function parse(source:JSONObject, originalWidth:int, originalHeight:int):VKApiPhotoSize {
        var result:VKApiPhotoSize= new VKApiPhotoSize();
        result.src = source.optString("src");
        result.width = source.optInt("width");
        result.height = source.optInt("height");
        var type:String= source.optString("type");
        if(!TextUtils.isEmpty(type)) {
            result.type = type.charAt(0);
        }
        // Казалось бы, теперь можно с чистой советью закончить метод.
        // Но нет, оказывается, width и height не просчитывается на некоторых серверах ВК.
        // Приходится гадать на кофейной гуще.
        if(result.width == 0|| result.height == 0) {
            fillDimensions(result, originalWidth, originalHeight);
        }
        return result;
    }

    /*
     * Устанавливает размерность исходя из размеров оригинала и типа изображения.
     */
    private static function fillDimensions(result:VKApiPhotoSize, originalWidth:int, originalHeight:int):void {
        var ratio:Number= float(originalWidth )/ originalHeight;
        switch (result.type) {
            case S: {
                fillDimensionSMXY(result, ratio, Math.min(originalWidth, 75));
            } break;
            case M: {
                fillDimensionSMXY(result, ratio, Math.min(originalWidth, 130));
            } break;
            case X: {
                fillDimensionSMXY(result, ratio, Math.min(originalWidth, 604));
            } break;
            case Y: {
                fillDimensionSMXY(result, ratio, Math.min(originalWidth, 807));
            } break;
            case O: {
                fillDimensionOPQ(result, ratio, Math.min(originalWidth, 130));
            } break;
            case P: {
                fillDimensionOPQ(result, ratio, Math.min(originalWidth, 200));
            } break;
            case Q: {
                fillDimensionOPQ(result, ratio, Math.min(originalWidth, 320));
            } break;
            case Z: {
                fillDimensionZW(result, ratio, Math.min(originalWidth, 1280), Math.min(originalHeight, 1024));
            } break;
            case W: {
                fillDimensionZW(result, ratio, Math.min(originalWidth, 2560), Math.min(originalHeight, 2048));
            } break;
        }
    }

    /*
     * Про S, M, X, Y известно, про копия обязательно пропорциональна, а ширина не должна превышать заданную.
     * Это значит, что для всех случаев(кроме тех, когда ширина картинки меньше указанной) соотношения
     * сторон картинка впишется пропорционально по ширине.
     */
    private static function fillDimensionSMXY(result:VKApiPhotoSize, ratio:Number, width:int):void {
        result.width = width;
        result.height = int(Math.ceil(result.width / ratio));
    }

    /*
     * Пропорциональная ширина. В принципе, все, что было сказано к предыдущему, верно и здесь,
     * за исключением того, что высота здесь не может превышать ширину * 1,5f
     */
    private static function fillDimensionOPQ(result:VKApiPhotoSize, ratio:Number, width:int):void {
        fillDimensionSMXY(result, Math.min(1.5, ratio), width);
    }

    /*
     * А здесь просто берем одну сторону за фактическую и исходя из нее вычисляем другую.
     */
    private static function fillDimensionZW(result:VKApiPhotoSize, ratio:Number, allowedWidth:int, allowedHeight:int):void {
        if(ratio > 1) { // ширина больше высоты
            result.width = allowedWidth;
            result.height = int((result.width / ratio));
        } else {
            result.height = allowedHeight;
            result.width = int((result.height * ratio));
        }
    }

    /**
     * Creates a dimension with explicit dimensions.
     * Can be helpful if the dimensions are exactly known.
     */
    public static function create(url:String, width:int, height:int):VKApiPhotoSize {
        var result:VKApiPhotoSize= new VKApiPhotoSize();
        result.src = url;
        result.width = width;
        result.height = height;
        var ratio:Number= width / float(height );
        if(width <= 75) {
            result.type = S;
        } else if(width <= 130) {
            result.type = ratio <= 1.5? O : M;
        } else if(width <= 200&& ratio <= 1.5) {
            result.type = P;
        } else if(width <= 320&& ratio <= 1.5) {
            result.type = Q;
        } else if(width <= 604) {
            result.type = X;
        } else if(width <= 807) {
            result.type = Y;
        } else if(width <= 1280&& height <= 1024) {
            result.type = Z;
        } else if(width <= 2560&& height <= 2048) {
            result.type = W;
        }
        return result;
    }

    /**
     * Creates a dimension type and size of the original.
     */
    public static function create(url:String, type:String, originalWidth:int, originalHeight:int):VKApiPhotoSize {
        var result:VKApiPhotoSize= new VKApiPhotoSize();
        result.src = url;
        result.type = type;
        fillDimensions(result, originalWidth, originalHeight);
        return result;
    }

    /**
     * Creates a square dimension type and size of the original.
     */
    public static function create(url:String, dimension:int):VKApiPhotoSize {
        return create(url, dimension, dimension);
    }
}
}