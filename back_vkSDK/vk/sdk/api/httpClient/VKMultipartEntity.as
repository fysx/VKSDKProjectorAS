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

package com.vk.sdk.api.httpClient {
import android.webkit.MimeTypeMap;

import org.apache.http.Header;
import org.apache.http.entity.AbstractHttpEntity;
import org.apache.http.message.BasicHeader;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Locale;
import java.util.Random;

/**
 * Class used for build upload multipart data for VK servers
 */
public class VKMultipartEntity extends AbstractHttpEntity {

    private static const VK_BOUNDARY:String= "Boundary(======VK_SDK_%d======)";

    private var mBoundary:String;
    private var mFiles:Array;

    public function VKMultipartEntity(files:Array) {
        mBoundary = String.format(Locale.US, VK_BOUNDARY, new Random().nextInt());
        mFiles = files;
    }

    
override public function isRepeatable():Boolean {
        return true;
    }

    
override public function getContentLength():Number {
        var length:Number= 0;
        for (var i:int= 0; i < mFiles.length; i++) {
            var f:File= mFiles[i];
            length += f.length();
            length += getFileDescription(f, i).length();
        }
        length += getBoundaryEnd().length();

        return length;
    }

    
override public function getContentType():Header {
        return new BasicHeader("Content-Type", String.format("multipart/form-data; boundary=%s", mBoundary));
    }

    
override public function getContent():InputStream , IllegalStateException {
        throw new UnsupportedOperationException("Multipart form entity does not implement #getContent()");
    }

    private function getFileDescription(uploadFile:File, i:int):String {
        var fileName:String= String.format(Locale.US, "file%d", i + 1);
        var extension:String= MimeTypeMap.getFileExtensionFromUrl(uploadFile.getAbsolutePath());
        return String.format("\r\n--%s\r\n", mBoundary) +
                String.format("Content-Disposition: form-data; name=\"%s\"; filename=\"%s.%s\"\r\n", fileName, fileName, extension) +
                String.format("Content-Type: %s\r\n\r\n", getMimeType(uploadFile.getAbsolutePath()));
    }

    private function getBoundaryEnd():String {
        return String.format("\r\n--%s--\r\n", mBoundary);
    }

    
override public function writeTo(outputStream:OutputStream):void {
        for (var i:int= 0; i < mFiles.length; i++) {
            var uploadFile:File= mFiles[i];
            outputStream.write(getFileDescription(uploadFile, i).getBytes("UTF-8"));
            var reader:FileInputStream= new FileInputStream(uploadFile);
            var fileBuffer:Array= new byte[2048];
            var bytesRead:int;
            while ((bytesRead = reader.read(fileBuffer)) != -1) {
                outputStream.write(fileBuffer, 0, bytesRead);
            }
            reader.close();
        }
        outputStream.write(getBoundaryEnd().getBytes("UTF-8"));
    }

    
override public function isStreaming():Boolean {
        return true;
    }

    protected static function getMimeType(url:String):String {
        var type:String= null;
        var extension:String= MimeTypeMap.getFileExtensionFromUrl(url);
        if (extension != null) {
            var mime:MimeTypeMap= MimeTypeMap.getSingleton();
            type = mime.getMimeTypeFromExtension(extension);
        }
        return type;
    }
}
}