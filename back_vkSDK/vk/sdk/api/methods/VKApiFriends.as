package com.vk.sdk.api.methods {
import com.vk.sdk.api.VKParameters;
import com.vk.sdk.api.VKRequest;
import com.vk.sdk.api.model.VKUsersArray;

/**
 * Section friends
 * Created by alex_xpert on 29.01.14.
 */
public class VKApiFriends extends VKApiBase {

    public function get(params:VKParameters):VKRequest {
        if (params.get("fields") != null) {
            return prepareRequest("get", params, VKRequest.HttpMethod.GET, VKUsersArray.class);
        } else {
            return prepareRequest("get", params);
        }
    }

    public function getOnline(params:VKParameters):VKRequest {
        return prepareRequest("getOnline", params);
    }

    public function getMutual(params:VKParameters):VKRequest {
        return prepareRequest("getMutual", params);
    }

    public function getRecent(params:VKParameters):VKRequest {
        return prepareRequest("getRecent", params);
    }

    public function getRequests(params:VKParameters):VKRequest {
        return prepareRequest("getRequests", params);
    }

    public function add(params:VKParameters):VKRequest {
        return prepareRequest("add", params);
    }

    public function edit(params:VKParameters):VKRequest {
        return prepareRequest("edit", params);
    }

    public function delete(params:VKParameters):VKRequest {
        return prepareRequest("delete", params);
    }

    public function getLists(params:VKParameters):VKRequest {
        return prepareRequest("getLists", params);
    }

    public function addList(params:VKParameters):VKRequest {
        return prepareRequest("addList", params);
    }

    public function editList(params:VKParameters):VKRequest {
        return prepareRequest("editList", params);
    }

    public function deleteList(params:VKParameters):VKRequest {
        return prepareRequest("deleteList", params);
    }

    public function getAppUsers(params:VKParameters):VKRequest {
        return prepareRequest("getAppUsers", params);
    }

    public function getByPhones(params:VKParameters):VKRequest {
        return prepareRequest("getByPhones", params, VKRequest.HttpMethod.GET, VKUsersArray.class);
    }

    public function deleteAllRequests(params:VKParameters):VKRequest {
        return prepareRequest("deleteAllRequests", params);
    }

    public function getSuggestions(params:VKParameters):VKRequest {
        return prepareRequest("getSuggestions", params);
    }

    public function areFriends(params:VKParameters):VKRequest {
        return prepareRequest("areFriends", params);
    }

}
}