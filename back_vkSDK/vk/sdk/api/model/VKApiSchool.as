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

import org.json.JSONException;
import org.json.JSONObject;

import static android.text.TextUtils.isEmpty;

/**
 * A school object describes a school.
 */
public class VKApiSchool extends VKApiModel implements Parcelable, Identifiable {

    /**
     * School ID, positive number
     */
    public var id:int;

    /**
     * ID of the country the school is located in, positive number
     */
    public var country_id:int;

    /**
     * ID of the city the school is located in, positive number
     */
    public var city_id:int;

    /**
     * School name
     */
    public var name:String;

    /**
     * Year the user started to study
     */
    public var year_from:int;

    /**
     * Year the user finished to study
     */
    public var year_to:int;

    /**
     * Graduation year
     */
    public var year_graduated:int;

    /**
     * School class letter
     */
    public var clazz:String;

    /**
     * Speciality
     */
    public var speciality:String;

	public function VKApiSchool(from:JSONObject) {
		parse(from);
	}
    /**
     * Fills a School instance from JSONObject.
     */
    public function parse(from:JSONObject):VKApiSchool {
        id = from.optInt("id");
        country_id = from.optInt("country_id");
        city_id = from.optInt("city_id");
        name = from.optString("name");
        year_from = from.optInt("year_from");
        year_to = from.optInt("year_to");
        year_graduated = from.optInt("year_graduated");
        clazz = from.optString("class");
        speciality = from.optString("speciality");
        return this;
    }

    /**
     * Creates a School instance from Parcel.
     */
    public function VKApiSchool(in:Parcel) {
        this.id = in.readInt();
        this.country_id = in.readInt();
        this.city_id = in.readInt();
        this.name = in.readString();
        this.year_from = in.readInt();
        this.year_to = in.readInt();
        this.year_graduated = in.readInt();
        this.clazz = in.readString();
        this.speciality = in.readString();
    }

    /**
     * Creates empty School instance.
     */
    public function VKApiSchool() {

    }

    
override public function getId():int {
        return id;
    }

    private var fullName:String;

    
override public function toString():String {
        if(fullName == null) {
            var builder:StringBuilder= new StringBuilder(name);
            if(year_graduated != 0) {
                builder.append(" \'");
                builder.append(String.format("%02d", year_graduated % 100));
            }
            if(year_from != 0&& year_to != 0) {
                builder.append(", ");
                builder.append(year_from);
                builder.append('-');
                builder.append(year_to);
            }
            if(!isEmpty(clazz)) {
                builder.append('(');
                builder.append(clazz);
                builder.append(')');
            }
            if(!isEmpty(speciality)) {
                builder.append(", ");
                builder.append(speciality);
            }
            fullName = builder.toString();
        }
        return fullName;
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        dest.writeInt(this.id);
        dest.writeInt(this.country_id);
        dest.writeInt(this.city_id);
        dest.writeString(this.name);
        dest.writeInt(this.year_from);
        dest.writeInt(this.year_to);
        dest.writeInt(this.year_graduated);
        dest.writeString(this.clazz);
        dest.writeString(this.speciality);
    }

    public static Creator<VKApiSchool> CREATOR = new Creator<VKApiSchool>() {
        public function createFromParcel(source:Parcel):VKApiSchool {
            return new VKApiSchool(source);
        }

        public VKApiSchool[] newArray(var size:int) {
            return new VKApiSchool[size];
        }
    };

}
}