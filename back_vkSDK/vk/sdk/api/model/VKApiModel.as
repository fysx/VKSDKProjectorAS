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
 * BaseModel.java
 * vk-android-sdk
 *
 * Created by Babichev Vitaly on 06.01.14.
 * Copyright (c) 2014 VK. All rights reserved.
 */
package com.vk.sdk.api.model {
import android.os.Parcelable;
import android.util.SparseArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * Root class for all VK models.
 * Any VK model supports Parcelable interface so you can pass it as extra.
 *
 * VK model is also allows you to store some object inside as a tag.
 * These objects are retained by hard links,
 * and never will be saved during parcelization.
 */
public abstract 
internal class VKApiModel implements Parcelable {

    public var fields:JSONObject;
    /**
     * The model's tag.
     */
    private var mTag:Object;

    /**
     * Map used to store model's tags.
     */
    private SparseArray<Object> mKeyedTags;

	/**
	 * Creates empty model
	 */
	public function VKApiModel() {

	}
    /**
     * Returns this model's tag.
     *
     * @return the Object stored in this model as a tag
     *
     * @see #setTag(Object)
     * @see #getTag(int)
     */
    public function getTag():Object {
        return mTag;
    }

    /**
     * Sets the tag associated with this model. A tag can be used to store
     * data within a model without resorting to another data structure.
     *
     * @param tag an Object to tag the model with
     *
     * @see #getTag()
     * @see #setTag(int, Object)
     */
    public function setTag(tag:Object):void {
        mTag = tag;
    }

    /**
     * Returns the tag associated with this model and the specified key.
     *
     * @param key The key identifying the tag
     *
     * @return the Object stored in this model as a tag
     *
     * @see #setTag(int, Object)
     * @see #getTag()
     */
    public function getTag(key:int):Object {
        if (mKeyedTags != null) return mKeyedTags.get(key);
        return null;
    }

    /**
     * Sets a tag associated with this model and a key. A tag can be used
     * to store data within a model without resorting to another
     * data structure.
     *
     * @see #setTag(Object)
     * @see #getTag(int)
     */
    public function setTag(key:int, tag:Object):void {
        if (mKeyedTags == null) {
            mKeyedTags = new SparseArray<Object>(2);
        }
        mKeyedTags.put(key, tag);
    }

	public function VKApiModel(from:JSONObject) {
		parse(from);
	}
    /**
     * Parses object from source.
     * @param response server API object.
     * @return this object.
     * @throws JSONException if any critical error occurred while parsing.
     */
    public function parse(response:JSONObject):VKApiModel {
        return ParseUtils.parseViaReflection(this, response);
    }
}
}