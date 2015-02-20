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

package com.vk.sdk.api.photo {
import com.vk.sdk.api.VKApi;
import com.vk.sdk.api.VKApiConst;
import com.vk.sdk.api.VKParameters;
import com.vk.sdk.api.VKRequest;
import com.vk.sdk.util.VKJsonHelper;
import com.vk.sdk.util.VKUtil;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;

/**
 * Special request for upload single photo to user wall
 */
public class VKUploadWallPhotoRequest extends VKUploadPhotoBase {
	private static const serialVersionUID:Number= 4732771149932923938L;

	public function VKUploadWallPhotoRequest(image:File, userId:Number, groupId:int) {
        super();
        mUserId = userId;
        mGroupId = groupId;
        mImages = new File[]{image};
    }

    public function VKUploadWallPhotoRequest(image:VKUploadImage, userId:Number, groupId:int) {
        super();
        mUserId = userId;
        mGroupId = groupId;
        mImages = new File[]{image.getTmpFile()};
    }
    public function VKUploadWallPhotoRequest(images:Array, userId:Number, groupId:int) {
        super();
        mUserId = userId;
        mGroupId = groupId;
        mImages = new File[images.length];
        for (var i:int= 0; i < images.length; i++) {
            mImages[i] = images[i].getTmpFile();
        }
    }

    
override protected function getServerRequest():VKRequest {
        if (mGroupId != 0)
            return VKApi.photos().getWallUploadServer(mGroupId);
        else
            return VKApi.photos().getWallUploadServer();
    }

    
override protected function getSaveRequest(response:JSONObject):VKRequest {
        var saveRequest:VKRequest;
        try {
            saveRequest = VKApi.photos().saveWallPhoto(new VKParameters(VKJsonHelper.toMap(response)));
        } catch (e:JSONException) {
            return null;
        }
        if (mUserId != 0)
            saveRequest.addExtraParameters(VKUtil.paramsFrom(VKApiConst.USER_ID, mUserId));
        if (mGroupId != 0)
            saveRequest.addExtraParameters(VKUtil.paramsFrom(VKApiConst.GROUP_ID, mGroupId));
        return saveRequest;
    }
}
}