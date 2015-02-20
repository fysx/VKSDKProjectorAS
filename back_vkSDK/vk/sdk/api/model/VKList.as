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

import com.vk.sdk.VKSdk;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.lang.reflect.Constructor;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.ListIterator;
import java.util.regex.Pattern;

/**
 * Universal data list for VK API.
 * This class is not thread-safe.
 * @param <T> type of stored values.
 * @see <a href="http://vk.com/dev/list">http://vk.com/dev/list</a>
 */
public class VKList<T extends VKApiModel & Parcelable & Identifiable> extends VKApiModel implements java.util.List<T>,Parcelable {

    /**
     * The server did not return the count field.
     */
    private static var NO_COUNT:int= -1;

    /**
     * Decorated list
     */
    private ArrayList<T> items = new ArrayList<T>();

    /**
     * Field {@code count} which returned by server.
     */
    private var count:int= NO_COUNT;

    /**
     * Creates empty list.
     */
    public function VKList() {

    }

    /**
     * Creates list and fills it according with given data.
     */
    public function VKList(java.util.List<? extends T> data) {
        assert data != null;
        items = new ArrayList<T>data();
    }

    /**
     * Creates list and fills it according with data in {@code from}.
     * @param from an object that represents a list adopted in accordance with VK API format. You can use null.
     * @param clazz class represents a model that has a public constructor with {@link org.json.JSONObject} argument.
     */
    public function VKList(from:JSONObject, Class<? extends T> clazz) {
        fill(from, clazz);
    }

    /**
     * Creates list and fills it according with data in {@code from}.
     * @param from an array of items in the list. You can use null.
     * @param clazz class represents a model that has a public constructor with {@link org.json.JSONObject} argument.
     */
    public function VKList(from:JSONArray, Class<? extends T> clazz) {
        fill(from, clazz);
    }

    /**
     * Creates list and fills it according with data in {@code from}.
     * @param from an object that represents a list adopted in accordance with VK API format. You can use null.
     * @param creator interface implementation to parse objects.
     */
    public function VKList(from:JSONObject, Parser<T> creator) {

        fill(from, creator);
    }

    /**
     * Creates list and fills it according with data in {@code from}.
     * @param from an array of items in the list. You can use null.
     * @param creator interface implementation to parse objects.
     */
    public function VKList(from:JSONArray, Parser<T> creator) {

        fill(from, creator);
    }

    /**
     * Fills list according with data in {@code from}.
     * @param from an object that represents a list adopted in accordance with VK API format. You can use null.
     * @param clazz class represents a model that has a public constructor with {@link org.json.JSONObject} argument.
     */
    public function fill(from:JSONObject, Class<? extends T> clazz):void {
        if (from.has("response")) {
            var array:JSONArray= from.optJSONArray("response");
            if (array != null) {
                fill(array, clazz);
            }
            else {
                fill(from.optJSONObject("response"), clazz);
            }
        } else {
            fill(from, new ReflectParser<T>clazz());
        }
    }

    /**
     * Creates list and fills it according with data in {@code from}.
     * @param from an array of items in the list. You can use null.
     * @param clazz class represents a model that has a public constructor with {@link org.json.JSONObject} argument.
     */
    public function fill(from:JSONArray, Class<? extends T> clazz):void {
        fill(from, new ReflectParser<T>clazz());
    }

    /**
     * Fills list according with data in {@code from}.
     * @param from an object that represents a list adopted in accordance with VK API format. You can use null.
     * @param creator interface implementation to parse objects.
     */
    public function fill(from:JSONObject, Parser<? extends T> creator):void {
        if(from != null) {
            fill(from.optJSONArray("items"), creator);
            count = from.optInt("count", count);
        }
    }

    /**
     * Fills list according with data in {@code from}.
     * @param from an array of items in the list. You can use null.
     * @param creator interface implementation to parse objects.
     */
    public function fill(from:JSONArray, Parser<? extends T> creator):void {
        if(from != null) {
            for(var i:int= 0; i < from.length(); i++) {
                try {
                    var object:T= creator.parseObject(from.getJSONObject(i));
                    if(object != null) {
                        items.add(object);
                    }
                } catch (e:Exception) {
                    if (VKSdk.DEBUG)
                        e.printStackTrace();
                }
            }
        }
    }

    /**
     * Adds the element before the element with the specified id.
     * If an element with the specified id is not found, adds an element to the end of the list.
     * @param id element identifier to add element before it.
     * @param data element to add
     */
    public function addBefore(id:int, data:T):void {
        var size:int= size();
        for(var i:int= 0; i < size; i++)  {
            if(get(i).getId() > id || i == size - 1) {
                add(i, data);
                break;
            }
        }
    }

    /**
     * Adds the element after the element with the specified id.
     * If an element with the specified id is not found, adds an element to the end of the list.
     * @param id element identifier to add element after it.
     * @param data element to add
     */
    public function addAfter(id:int, data:T):void {
        var size:int= size();
        for(var i:int= 0; i < size; i++)  {
            if(get(i).getId() > id || i == size - 1) {
                add(i + 1, data);
                break;
            }
        }
    }

    /**
     * Returns element according with id.
     * If nothing found, returns null.
     */
    public function getById(id:int):T {
        for(T item: this) {
            if(item.getId() == id) {
                return item;
            }
        }
        return null;
    }

    /**
     * Searches through the list of available items. <br />
     * <br />
     * The search will be carried out not by the content of characters per line, and the content of them in separate words. <br />
     * <br />
     * Search is not case sensitive.  <br />
     * <br />
     * To support search class {@code T} must have overridden method {@link #toString()},
     * search will be carried out exactly according to the result of calling this method. <br />
     * <br />
     * <br />
     * Suppose there are elements in the list of contents:
     * <code><pre>
     * - Hello world
     * - Hello test
     * </pre></code>
     * In this case, the matches will be on search phrases {@code 'Hel'}, {@code 'Hello'}, {@code 'test'}, but not on {@code 'llo'}, {@code 'llo world'}
     *
     * @param query search query can not be equal to {@code null}, but can be an empty string.
     * @return created based on the search results new list. If no matches are found, the list will be empty.
     */
    public VKList<T> search(var query:String) {
        VKList<T> result = new VKList<T>();
        var pattern:Pattern= Pattern.compile("(?i).*\\b" + query + ".*");
        for (T item : this) {
            if (pattern.matcher(item.toString()).find()) {
                result.add(item);
            }
        }
        return result;
    }

    /**
     * Returns the return value of the field VK API {@code count}, if it has been returned, and the size of the list, if not.
     */
    public function getCount():int {
        return count != NO_COUNT ? count : size();
    }

    
override public function add(location:int, object:T):void {
        items.add(location, object);
    }

    
override public function add(object:T):Boolean {
        return items.add(object);
    }

    
override public function addAll(location:int, Collection<? extends T> collection):Boolean {
        return items.addAll(location, collection);
    }

    
override public function addAll(Collection<? extends T> collection):Boolean {
        return items.addAll(collection);
    }

    
override public function clear():void {
        items.clear();
    }

    
override public function contains(object:Object):Boolean {
        return items.contains(object);
    }

    
override public function containsAll(Collection<?> collection):Boolean {
        assert collection != null;
        return items.containsAll(collection);
    }

    
override public function equal == (object:Object):Boolean {
        return (Object(this)).getClass() == (object.getClass()) && items == (object);
    }

    
override public function get(location:int):T {
        return items.get(location);
    }

    
override public function indexOf(object:Object):int {
        return items.indexOf(object);
    }

    
override public function isEmpty():Boolean {
        return items.isEmpty();
    }

    
override public Iterator<T> iterator() {
        return items.iterator();
    }

    
override public function lastIndexOf(object:Object):int {
        return items.lastIndexOf(object);
    }

    
override public ListIterator<T> listIterator() {
        return items.listIterator();
    }

    
override public ListIterator<T> listIterator(var location:int) {
        return items.listIterator(location);
    }

    
override public function remove(location:int):T {
        return items.remove(location);
    }

    
override public function remove(object:Object):Boolean {
        return items.remove(object);
    }

    
override public function removeAll(Collection<?> collection):Boolean {
        assert collection != null;
        return items.removeAll(collection);
    }

    
override public function retainAll(Collection<?> collection):Boolean {
        return items.retainAll(collection);
    }

    
override public function set(location:int, object:T):T {
        return items.set(location, object);
    }

    
override public function size():int {
        return items.size();
    }

    
override public java.util.List<T> subList(var start:int, var end:int) {
        return items.subList(start, end);
    }

    
override public Object[] toArray() {
        return items.toArray();
    }

    
override public <T1> T1[] toArray(var array:Array) {
        assert array != null;
        return items.toArray(array);
    }

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        dest.writeInt(items.size());
        for(T item: this) {
            dest.writeParcelable(item, flags);
        }
        dest.writeInt(this.count);
    }

    /**
     * Creates list from Parcel
     */
    public function VKList(in:Parcel) {
        var size:int= in.readInt();
        for(var i:int= 0; i < size; i++) {
            items.add( (T(in.readParcelable(((Object) this).getClass().getClassLoader()))));
        }
        this.count = in.readInt();
    }

    public static Creator<VKList> CREATOR = new Creator<VKList>() {
        public function createFromParcel(source:Parcel):VKList {
            return new VKList(source);
        }

        public VKList[] newArray(var size:int) {
            return new VKList[size];
        }
    };

    /**
     * Used when parsing the list objects as interator created from {@link org.json.JSONArray}
}

import org.json.JSONObject;
import org.json.JSONArray;
 a instances of items of the list.
     * @param <D> list item type.
     */
    public static 
internal interface Parser<D> {

        /**
         * Creates a list item of its representation return VK API from {@link org.json.JSONArray}
         * @param source representation of the object in the format returned by VK API.
         * @return created element to add to the list.
         * @throws Exception if the exception is thrown, the element iterated this method will not be added to the list.
         */
        function parseObject(source:JSONObject):D ;
    }

    /**
     * Parser list items using reflection mechanism.
     * To use an object class must have a public constructor that accepts {@link org.json.JSONObject}

import org.json.JSONObject;
import java.lang.reflect.Constructor;
import org.json.JSONException;
.
     * If, during the creation of the object constructor will throw any exception, the element will not be added to the list.
     * @param <D> list item type.
     */
    public static 
internal class ReflectParser<D extends VKApiModel> implements Parser<D> {

        private Class<? extends D> clazz;

        public function ReflectParser(Class<? extends D> clazz) {
            this.clazz = clazz;
        }

        
override public function parseObject(source:JSONObject):D {
	        try
	        {
		        Constructor<? extends D> jsonConstructor = clazz.getConstructor(JSONObject.class);
		        if (jsonConstructor != null) {
			        return jsonConstructor.newInstance(source);
		        }
	        } catch (ignored:Exception) {
		        //Ignored. Try default constructor
	        }

	        return D(clazz.newInstance().parse(source));
        }
    }

    
override public function parse(response:JSONObject):VKApiModel {
        throw new JSONException("Operation is not supported while class is generic");
    }
}