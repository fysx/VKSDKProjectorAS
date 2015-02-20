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
 * VKAttachments.java
 * vk-android-sdk
 *
 * Created by Babichev Vitaly on 01.02.14.
 * Copyright (c) 2014 VK. All rights reserved.
 */
package com.vk.sdk.api.model {
import android.os.Parcel;

import com.vk.sdk.util.VKStringJoiner;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * A list of attachments in {@link VKApiComment}, {@link VKApiPost}, {@link VKApiMessage}
 */
public class VKAttachments extends VKList<VKAttachments.VKApiAttachment> implements android.os.Parcelable {

    /**
     * Attachment is a photo.
     * @see {@link VKApiPhoto}
     */
    public static const TYPE_PHOTO:String= "photo";

    /**
     * Attachment is a video.
     * @see {@link VKApiVideo}
     */
    public static const TYPE_VIDEO:String= "video";

    /**
     * Attachment is an audio.
     * @see {@link VKApiAudio}
     */
    public static const TYPE_AUDIO:String= "audio";

    /**
     * Attachment is a document.
     * @see {@link VKApiDocument}
     */
    public static const TYPE_DOC:String= "doc";

    /**
     * Attachment is a wall post.
     * @see {@link VKApiPost}
     */
    public static const TYPE_POST:String= "wall";

    /**
     * Attachment is a posted photo.
     * @see {@link VKApiPostedPhoto}
     */
    public static const TYPE_POSTED_PHOTO:String= "posted_photo";

    /**
     * Attachment is a link
     * @see {@link VKApiLink}
     */
    public static const TYPE_LINK:String= "link";

    /**
     * Attachment is a note
     * @see {@link VKApiNote}
     */
    public static const TYPE_NOTE:String= "note";

    /**
     * Attachment is an application content
     * @see {@link VKApiApplicationContent}
     */
    public static const TYPE_APP:String= "app";

    /**
     * Attachment is a poll
     * @see {@link VKApiPoll}
     */
    public static const TYPE_POLL:String= "poll";

    /**
     * Attachment is a WikiPage
     * @see {@link VKApiWikiPage}
     */
    public static const TYPE_WIKI_PAGE:String= "page";

    /**
     * Attachment is a PhotoAlbum
     * @see {@link VKApiPhotoAlbum}
     */
    public static const TYPE_ALBUM:String= "album";

    public function VKAttachments() {
        super();
    }

    public function VKAttachments( ... data) {
        super(Arrays.asList(data));
    }

    public function VKAttachments(List<? extends VKApiAttachment> data) {
        super(data);
    }

    public function VKAttachments(from:JSONObject) {
        super();
        fill(from);
    }

    public function VKAttachments(from:JSONArray) {
        super();
        fill(from);
    }

    public function fill(from:JSONObject):void {
        super.fill(from, parser);
    }

    public function fill(from:JSONArray):void {
        super.fill(from, parser);
    }

    public function toAttachmentsString():String {
        ArrayList<CharSequence> attachments = new ArrayList<CharSequence>();
        for (VKApiAttachment attach : this) {
            attachments.add(attach.toAttachmentString());
        }
        return VKStringJoiner.join(attachments, ",");
    }
    /**
     * Parser that's used for parsing photo sizes.
     */
    private Parser<VKApiAttachment> parser = new Parser<VKApiAttachment>() {
        
override public function parseObject(attachment:JSONObject):VKApiAttachment {
            var type:String= attachment.optString("type");
            if(TYPE_PHOTO == (type)) {
                return new VKApiPhoto().parse(attachment.getJSONObject(TYPE_PHOTO));
            } else if(TYPE_VIDEO == (type)) {
                return new VKApiVideo().parse(attachment.getJSONObject(TYPE_VIDEO));
            } else if(TYPE_AUDIO == (type)) {
                return new VKApiAudio().parse(attachment.getJSONObject(TYPE_AUDIO));
            } else if(TYPE_DOC == (type)) {
                return new VKApiDocument().parse(attachment.getJSONObject(TYPE_DOC));
            } else if(TYPE_POST == (type)) {
                return new VKApiPost().parse(attachment.getJSONObject(TYPE_POST));
            } else if(TYPE_POSTED_PHOTO == (type)) {
                return new VKApiPostedPhoto().parse(attachment.getJSONObject(TYPE_POSTED_PHOTO));
            } else if(TYPE_LINK == (type)) {
                return new VKApiLink().parse(attachment.getJSONObject(TYPE_LINK));
            } else if(TYPE_NOTE == (type)) {
                return new VKApiNote().parse(attachment.getJSONObject(TYPE_NOTE));
            } else if(TYPE_APP == (type)) {
                return new VKApiApplicationContent().parse(attachment.getJSONObject(TYPE_APP));
            } else if(TYPE_POLL == (type)) {
                return new VKApiPoll().parse(attachment.getJSONObject(TYPE_POLL));
            } else if(TYPE_WIKI_PAGE == (type)) {
                return new VKApiWikiPage().parse(attachment.getJSONObject(TYPE_WIKI_PAGE));
            } else if(TYPE_ALBUM == (type)) {
                return new VKApiPhotoAlbum().parse(attachment.getJSONObject(TYPE_ALBUM));
            }
            return null;
        }
    };

    
override public function describeContents():int {
        return 0;
    }

    
override public function writeToParcel(dest:Parcel, flags:int):void {
        dest.writeInt(size());
        for(VKApiAttachment attachment: this) {
            dest.writeString(attachment.getType());
            dest.writeParcelable(attachment, 0);
        }
    }

    public function VKAttachments(parcel:Parcel) {
        var size:int= parcel.readInt();
        for(var i:int= 0; i < size; i++) {
            var type:String= parcel.readString();
            if(TYPE_PHOTO == (type)) {
                add(VKApiAttachment(parcel.readParcelable(VKApiPhoto.class.getClassLoader())));
            } else if(TYPE_VIDEO == (type)) {
                add(VKApiAttachment(parcel.readParcelable(VKApiVideo.class.getClassLoader())));
            } else if(TYPE_AUDIO == (type)) {
                add(VKApiAttachment(parcel.readParcelable(VKApiAudio.class.getClassLoader())));
            } else if(TYPE_DOC == (type)) {
                add(VKApiAttachment(parcel.readParcelable(VKApiDocument.class.getClassLoader())));
            } else if(TYPE_POST == (type)) {
                add(VKApiAttachment(parcel.readParcelable(VKApiPost.class.getClassLoader())));
            } else if(TYPE_POSTED_PHOTO == (type)) {
                add(VKApiAttachment(parcel.readParcelable(VKApiPostedPhoto.class.getClassLoader())));
            } else if(TYPE_LINK == (type)) {
                add(VKApiAttachment(parcel.readParcelable(VKApiLink.class.getClassLoader())));
            } else if(TYPE_NOTE == (type)) {
                add(VKApiAttachment(parcel.readParcelable(VKApiNote.class.getClassLoader())));
            } else if(TYPE_APP == (type)) {
                add(VKApiAttachment(parcel.readParcelable(VKApiApplicationContent.class.getClassLoader())));
            } else if(TYPE_POLL == (type)) {
                add(VKApiAttachment(parcel.readParcelable(VKApiPoll.class.getClassLoader())));
            } else if(TYPE_WIKI_PAGE == (type)) {
                add(VKApiAttachment(parcel.readParcelable(VKApiWikiPage.class.getClassLoader())));
            } else if(TYPE_ALBUM == (type)) {
                add(VKApiAttachment(parcel.readParcelable(VKApiPhotoAlbum.class.getClassLoader())));
            }
        }
    }

    public static Creator<VKAttachments> CREATOR = new Creator<VKAttachments>() {
        public function createFromParcel(source:Parcel):VKAttachments {
            return new VKAttachments(source);
        }

        public VKAttachments[] newArray(var size:int) {
            return new VKAttachments[size];
        }
    }
}

;

    /**
     * An abstract class for all attachments
     */
    public abstract static 
internal class VKApiAttachment extends VKApiModel implements Identifiable {

        /**
         * Convert attachment to special string to attach it to the post, message or comment.
         */
        public abstract function toAttachmentString():CharSequence ;

        /**
         * @return type of this attachment
         */
        public abstract function getType():String ;
    }
}