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
import org.json.JSONObject;

/**
 * A city object describes a city.
 */
public class VKApiCity extends VKApiModel implements Parcelable, Identifiable {

    /**
     * City ID.
     */
    public var id:int;

    /**
     * City name
     */
    public var title:String;

	public function VKApiCity(from:JSONObject) {
		parse(from);
	}
    /**
     * Fills a City instance from JSONObject.
     */
    public function parse(from:JSONObject):VKApiCity {
        id = from.optInt("id");
        title = from.optString("title");
        return this;
    }

    /**
     * Creates a City instance from Parcel.
     */
    public function VKApiCity(in:Parcel) {
        this.id = in.readInt();
        this.title = in.readString();
    }

    /**
     * Creates empty City instance.
     */
    public function VKApiCity() {

    }

    
override public function getId():int {
        return id;
    }

    
override public function toString():String {
        return title;
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        dest.writeInt(this.id);
        dest.writeString(this.title);
    }

    public static Creator<VKApiCity> CREATOR = new Creator<VKApiCity>() {
        public function createFromParcel(source:Parcel):VKApiCity {
            return new VKApiCity(source);
        }

        public VKApiCity[] newArray(var size:int) {
            return new VKApiCity[size];
        }
    };

}
}