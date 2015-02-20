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

package com.vk.sdk.api.methods {
import com.vk.sdk.api.VKParameters;
import com.vk.sdk.api.VKRequest;
import com.vk.sdk.api.model.VKCommentArray;
import com.vk.sdk.api.model.VKPostArray;
import com.vk.sdk.api.model.VKWallPostResult;

/**
 * Builds requests for API.wall part
 */
public class VKApiWall extends VKApiBase {

    public function get(params:VKParameters):VKRequest {
        if ((Integer(params.get("extended"))) == 1) {
            return prepareRequest("get", params, VKRequest.HttpMethod.GET, VKPostArray.class);
        } else {
            return prepareRequest("get", params);
        }
    }

    public function getById(params:VKParameters):VKRequest {
        if ((Integer(params.get("extended"))) == 1) {
            return prepareRequest("get", params, VKRequest.HttpMethod.GET, VKPostArray.class);
        } else {
            return prepareRequest("get", params);
        }
    }

    public function savePost(params:VKParameters):VKRequest {
        return prepareRequest("savePost", params);
    }


    public function post(parameters:VKParameters):VKRequest {
        return prepareRequest("post", parameters, VKRequest.HttpMethod.POST, VKWallPostResult.class);
    }

    public function repost(params:VKParameters):VKRequest {
        return prepareRequest("repost", params);
    }

    public function getReposts(params:VKParameters):VKRequest {
        return prepareRequest("getReposts", params);
    }

    public function edit(params:VKParameters):VKRequest {
        return prepareRequest("edit", params);
    }

    public function delete(params:VKParameters):VKRequest {
        return prepareRequest("delete", params);
    }

    public function restore(params:VKParameters):VKRequest {
        return prepareRequest("restore", params);
    }

    public function getComments(params:VKParameters):VKRequest {
        return prepareRequest("getComments", params, VKRequest.HttpMethod.GET, VKCommentArray.class);
    }

    public function addComment(params:VKParameters):VKRequest {
        return prepareRequest("addComment", params);
    }

    public function editComment(params:VKParameters):VKRequest {
        return prepareRequest("editComment", params);
    }

    public function deleteComment(params:VKParameters):VKRequest {
        return prepareRequest("deleteComment", params);
    }

    public function restoreComment(params:VKParameters):VKRequest {
        return prepareRequest("restoreComment", params);
    }

    public function reportPost(params:VKParameters):VKRequest {
        return prepareRequest("reportPost", params);
    }

    public function reportComment(params:VKParameters):VKRequest {
        return prepareRequest("reportComment", params);
    }
}
}