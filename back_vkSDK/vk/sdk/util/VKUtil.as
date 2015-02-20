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

package com.vk.sdk.util {
//import android.content.Context;
//import android.content.Intent;
//import android.content.pm.ApplicationInfo;
//import android.content.pm.PackageInfo;
//import android.content.pm.PackageManager;
//import android.content.pm.ResolveInfo;
//import android.content.pm.Signature;
//import android.util.Log;
//
//import com.vk.sdk.VKSdk;
//import com.vk.sdk.api.VKParameters;
//
//import java.io.BufferedReader;
//import java.io.BufferedWriter;
//import java.io.FileReader;
//import java.io.FileWriter;
//import java.io.IOException;
//import java.math.BigInteger;
//import java.security.MessageDigest;
//import java.security.NoSuchAlgorithmException;
//import java.security.spec.InvalidParameterSpecException;
//import java.util.HashMap;
//import java.util.LinkedHashMap;
//import java.util.List;
//import java.util.Map;
//
///**
 //* Various useful functions
 //*/
//public class VKUtil {/*
    ///**
     //* Breaks key=value&key=value string to map
     //*
     //* @param queryString string to explode
     //* @return Key-value map of passed string
     //*/
    //public static Map<String, String> explodeQueryString(var queryString:String) {
        //var keyValuePairs:Array= queryString.split("&");
        //HashMap<String, String> parameters = new HashMap<String, String>keyValuePairs.length();
//
        //for (String keyValueString : keyValuePairs) {
            //var keyValueArray:Array= keyValueString.split("=");
            //parameters.put(keyValueArray[0], keyValueArray[1]);
        //}
        //return parameters;
    //}
//
    ///**
     //* Reads content of file, and returns result as string
     //*
     //* @param filename path to file
     //* @return Contents of file
     //* @throws IOException
     //*/
    //public static function fileToString(filename:String):String {
        //var reader:BufferedReader= new BufferedReader(new FileReader(filename));
        //var builder:StringBuilder= new StringBuilder();
        //var line:String;
//
        //// For every line in the file, append it to the string builder
        //while ((line = reader.readLine()) != null) {
            //builder.append(line);
        //}
        //reader.close();
//
        //return builder.toString();
    //}
//
    ///**
     //* Saves passed string to file
     //*
     //* @param filename      path to file
     //* @param stringToWrite string to save
     //*/
    //public static function stringToFile(filename:String, stringToWrite:String):void {
        //try {
            //var writer:BufferedWriter= new BufferedWriter(new FileWriter(filename));
            //writer.write(stringToWrite);
            //writer.flush();
            //writer.close();
        //} catch (ignored:Exception) {
        //}
    //}
//
    ///**
     //* Returns md5 hash of string
     //*
     //* @param s string to hash
     //* @return md5 hash
     //*/
    //public static function md5(s:String):String {
        //try {
            //// Create MD5 Hash
            //var digest:MessageDigest= MessageDigest.getInstance("MD5");
            //digest.update(s.getBytes());
            //byte messageDigest[] = digest.digest();
//
            //// Create Hex String
            //var hexString:StringBuilder= new StringBuilder();
            //for (byte aMessageDigest : messageDigest) {
                //var h:String= Integer.toHexString(0xFF& aMessageDigest);
                //while (h.length() < 2)
                    //h = "0" + h;
                //hexString.append(h);
            //}
            //return hexString.toString();
//
        //} catch (e:NoSuchAlgorithmException) {
            //if (VKSdk.DEBUG)
                //e.printStackTrace();
        //}
        //return "";
    //}
//
    ///**
     //* Get current certificate fingerprint
     //*
     //* @param ctx         context of application
     //* @param packageName your package name
     //* @return Base64 packed SHA fingerprint of your packet certificate
     //*/
    //public static String[] getCertificateFingerprint(var ctx:Context, var packageName:String) {
        //try {
	        //if (ctx == null || ctx.getPackageManager() == null)
		        //return null;
            //var info:PackageInfo= ctx.getPackageManager().getPackageInfo(
                    //packageName,
                    //PackageManager.GET_SIGNATURES);
	        //assert info.signatures != null;
	        //var result:Array= new String[info.signatures.length];
            //var i:int= 0;
            //for (Signature signature : info.signatures) {
                //var md:MessageDigest= MessageDigest.getInstance("SHA");
                //md.update(signature.toByteArray());
////                result[i++] = Base64.encodeToString(md.digest(), Base64.DEFAULT);
                //result[i++] = toHex(md.digest());
            //}
            //return result;
        //} catch (e:Exception) {
            //return null;
        //}
    //}
//
    //private static function toHex(bytes:Array):String {
        //var bi:BigInteger= new BigInteger(1, bytes);
        //return String.format("%0" + (bytes.length << 1) + "X", bi);
    //}
//
    ///**
     //* Builds map from list of strings
     //*
     //* @param args key-value pairs for build a map. Must be a multiple of 2
     //* @return Result map. If args not multiple of 2, last argument will be ignored
     //*/
    //public static Map<String, Object> mapFrom( ... args) {
        //if (args.length % 2!= 0) {
            //if (VKSdk.DEBUG)
                //Log.w("VKUtil", "Params must be paired. Last one is ignored");
        //}
        //LinkedHashMap<String, Object> result = new LinkedHashMap<String, Object>(args.length / 2);
        //for (var i:int= 0; i + 1< args.length; i += 2) {
            //if (args[i] == null || args[i + 1] == null || !(args[i] is String)) {
                //if (VKSdk.DEBUG)
                    //Log.e("VK SDK", "Error while using mapFrom", new InvalidParameterSpecException("Key and value must be specified. Key must be string"));
                //continue;
            //}
            //result.put(String(args[i]), args[i + 1]);
        //}
        //return result;
    //}
//
    //public static function paramsFrom( ... args):VKParameters {
        //return new VKParameters(mapFrom(args));
    //}
//
    ///**
     //* Check if package installed
     //*
     //* @param context Context of current app
     //* @param uri Package of application to check
     //* @return true if passed package installed
     //*/
    //public static function isAppInstalled(context:Context, uri:String):Boolean {
        //var pm:PackageManager= context.getPackageManager();
        //var appInstalled:Boolean;
        //try {
            //assert pm != null;
            //pm.getPackageInfo(uri, PackageManager.GET_ACTIVITIES);
            //appInstalled = true;
        //} catch (e:PackageManager.NameNotFoundException) {
            //appInstalled = false;
        //}
        //return appInstalled;
    //}
    ///**
     //* Check if action available installed
     //*
     //* @param context Context of current app
     //* @param action Package of application to check
     //* @return true if passed package installed
     //*/
    //public static function isIntentAvailable(context:Context, action:String):Boolean {
        //var packageManager:PackageManager= context.getPackageManager();
        //var intent:Intent= new Intent(action);
        //assert packageManager != null;
        //List<ResolveInfo> list =
                //packageManager.queryIntentActivities(intent,
                        //PackageManager.MATCH_DEFAULT_ONLY);
        //return list.size() > 0;
    //}
//
    ///**
     //* Finds current application name
     //* @param ctx context of application
     //* @return Name of current application
     //*/
    //public static function getApplicationName(ctx:Context):String {
        //var ai:ApplicationInfo;
        //try {
            //var appContext:Context= ctx.getApplicationContext();
            //assert appContext != null;
            //var pm:PackageManager= appContext.getPackageManager();
            //assert pm != null;
            //ai = pm.getApplicationInfo(ctx.getPackageName(), 0);
            //return String((ai != null ? pm.getApplicationLabel(ai) : "(unknown)"));
        //} catch (ignored:Exception) {
        //}
        //return null;
    //}
//
    ///**
     //* Will take a url such as http://www.stackoverflow.com and return www.stackoverflow.com
     //* Author: aioobe http://stackoverflow.com/a/4826122/1271424
     //*
     //* @param url url need to find host
     //* @return host name of given url
     //*/
    //public static function getHost(url:String):String {
        //if(url == null || url.length() == 0)
            //return "";
//
        //var doubleslash:int= url.indexOf("//");
        //if(doubleslash == -1)
            //doubleslash = 0;
        //else
            //doubleslash += 2;
//
        //var end:int= url.indexOf('/', doubleslash);
        //end = end >= 0? end : url.length();
//
        //var port:int= url.indexOf(':', doubleslash);
        //end = (port > 0&& port < end) ? port : end;
//
        //return url.substring(doubleslash, end);
    //}
//}
}