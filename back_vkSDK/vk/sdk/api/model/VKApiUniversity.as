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
 * An university object describes an university.
 */
public class VKApiUniversity extends VKApiModel implements Parcelable, Identifiable {

    /**
     * University ID, positive number
     */
    public var id:int;

    /**
     * ID of the country the university is located in, positive number
     */
    public var country_id:int;

    /**
     * ID of the city the university is located in, positive number
     */
    public var city_id:int;

    /**
     * University name
     */
    public var name:String;

    /**
     * Faculty ID
     */
    public var faculty:String;

    /**
     * Faculty name
     */
    public var faculty_name:String;

    /**
     * University chair ID;
     */
    public var chair:int;

    /**
     * Chair name
     */
    public var chair_name:String;

    /**
     * Graduation year
     */
    public var graduation:int;

    /**
     * Form of education
     */
    public var education_form:String;

    /**
     * Status of education
     */
    public var education_status:String;

	public function VKApiUniversity(from:JSONObject) {
		parse(from);
	}
    /**
     * Fills a University instance from JSONObject.
     */
    public function parse(from:JSONObject):VKApiUniversity {
        id = from.optInt("id");
        country_id = from.optInt("country_id");
        city_id = from.optInt("city_id");
        name = from.optString("name");
        faculty = from.optString("faculty");
        faculty_name = from.optString("faculty_name");
        chair = from.optInt("chair");
        chair_name = from.optString("chair_name");
        graduation = from.optInt("graduation");
        education_form = from.optString("education_form");
        education_status = from.optString("education_status");
        return this;
    }

    /**
     * Creates a University instance from Parcel.
     */
    public function VKApiUniversity(in:Parcel) {
        this.id = in.readInt();
        this.country_id = in.readInt();
        this.city_id = in.readInt();
        this.name = in.readString();
        this.faculty = in.readString();
        this.faculty_name = in.readString();
        this.chair = in.readInt();
        this.chair_name = in.readString();
        this.graduation = in.readInt();
        this.education_form = in.readString();
        this.education_status = in.readString();
    }

    /**
     * Creates empty University instance.
     */
    public function VKApiUniversity() {

    }

    private var fullName:String;

    
override public function toString():String {
        if(fullName == null) {
            var result:StringBuilder= new StringBuilder(name);
            result.append(" \'");
            result.append(String.format("%02d", graduation % 100));
            if(!isEmpty(faculty_name)) {
                result.append(", ");
                result.append(faculty_name);
            }
            if(!isEmpty(chair_name)) {
                result.append(", ");
                result.append(chair_name);
            }
            fullName = result.toString();
        }
        return fullName;
    }

    
override public function getId():int {
        return id;
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        dest.writeInt(this.id);
        dest.writeInt(this.country_id);
        dest.writeInt(this.city_id);
        dest.writeString(this.name);
        dest.writeString(this.faculty);
        dest.writeString(this.faculty_name);
        dest.writeInt(this.chair);
        dest.writeString(this.chair_name);
        dest.writeInt(this.graduation);
        dest.writeString(this.education_form);
        dest.writeString(this.education_status);
    }

    public static Creator<VKApiUniversity> CREATOR = new Creator<VKApiUniversity>() {
        public function createFromParcel(source:Parcel):VKApiUniversity {
            return new VKApiUniversity(source);
        }

        public VKApiUniversity[] newArray(var size:int) {
            return new VKApiUniversity[size];
        }
    };

}
}