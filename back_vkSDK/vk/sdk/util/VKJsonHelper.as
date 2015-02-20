//  Based on https://gist.github.com/codebutler/2339666
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

package com.vk.sdk.util {
import com.vk.sdk.VKSdk;
import com.vk.sdk.api.model.VKApiModel;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * Provide common functions for json processing
 */
public class VKJsonHelper {
    /**
     * Converts object to JSON object, if possible
     *
     * @param object object to serialize to json
     * @return Completed json object
     * @throws JSONException
     */

    public static function toJSON(object:Object):Object {
        if (object is Map) {
            var json:JSONObject= new JSONObject();
            var map:Map= Map(object);
            for (Object key : map.keySet()) {
                json.put(key.toString(), toJSON(map.get(key)));
            }
            return json;
        } else if (object is Iterable) {
            var json:JSONArray= new JSONArray();
            for (Object value : (Iterable(object))) {
                json.put(value);
            }
            return json;
        } else {
            return object;
        }
    }

    /**
     * Check if json object is empty
     *
     * @param object object to check
     * @return true if object is empty
     */
    public static function isEmptyObject(object:JSONObject):Boolean {
        return object.names() == null;
    }

    /**
     * Converts field in key to map
     *
     * @param object target object
     * @param key    target key
     * @return Map of field by passed key
     * @throws JSONException
     */
    public static Map<String, Object> getMap(var object:JSONObject, var key:String) {
        return toMap(object.getJSONObject(key));
    }

    /**
     * Converts selected json-object to map
     *
     * @param object object to convert
     * @return Filled map
     * @throws JSONException
     */
    public static Map<String, Object> toMap(var object:JSONObject) {
        Map<String, Object> map = new HashMap<String, Object>();
        var keys:Iterator= object.keys();
        while (keys.hasNext()) {
            var key:String= String(keys.next());
            map.put(key, fromJson(object.get(key)));
        }
        return map;
    }

    /**
     * Converts json-array to list
     *
     * @param array json-array to convert
     * @return converted array
     * @throws JSONException
     */
    public static function toList(array:JSONArray):List {
        var list:List= new ArrayList();
        for (var i:int= 0; i < array.length(); i++) {
            list.add(fromJson(array.get(i)));
        }
        return list;
    }

    public static function toArray(array:JSONArray, arrayClass:Class):Object {
        var ret:Object= Array.newInstance(arrayClass.getComponentType(), array.length());
        Class<?> subType = arrayClass.getComponentType();

        for (var i:int= 0; i < array.length(); i++)
        {
            try
            {
                var jsonItem:Object= array.get(i);
                var objItem:Object= subType.newInstance();
                if (jsonItem is JSONObject)
                {
                    var jsonItem2:JSONObject= JSONObject(jsonItem);
                    if (objItem is VKApiModel)
                    {
                        var objItem2:VKApiModel= VKApiModel(objItem);
                        (VKApiModel(objItem)).parse(jsonItem2);
                        Array.set(ret, i, objItem2);
                    }
                }
            }
            catch (e:JSONException)
            {
                if (VKSdk.DEBUG)
                    e.printStackTrace();
            }
            catch (e:InstantiationException)
            {
                if (VKSdk.DEBUG)
                    e.printStackTrace();
            }
            catch (e:IllegalAccessException)
            {
                if (VKSdk.DEBUG)
                    e.printStackTrace();
            }
        }
        return ret;
    }

    /**
     * Converts object from json to java object
     *
     * @param json object from jsonobject or jsonarray
     * @return converted object
     * @throws JSONException
     */
    private static function fromJson(json:Object):Object {
        if (json == JSONObject.NULL) {
            return null;
        } else if (json is JSONObject) {
            return toMap(JSONObject(json));
        } else if (json is JSONArray) {
            return toList(JSONArray(json));
        } else {
            return json;
        }
    }
}
}