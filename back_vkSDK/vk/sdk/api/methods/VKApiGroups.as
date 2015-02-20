package com.vk.sdk.api.methods {
import com.vk.sdk.api.VKApiConst;
import com.vk.sdk.api.VKParameters;
import com.vk.sdk.api.VKRequest;
import com.vk.sdk.api.model.VKApiCommunityArray;
import com.vk.sdk.api.model.VKUsersArray;

/**
 * Section groups
 * Created by alex_xpert on 29.01.14.
 */
public class VKApiGroups extends VKApiBase {

    public function isMember(params:VKParameters):VKRequest {
        return prepareRequest("isMember", params);
    }

    public function getById(params:VKParameters):VKRequest {
        return prepareRequest("getById", params, VKRequest.HttpMethod.GET, VKApiCommunityArray.class);
    }

    public function get(params:VKParameters):VKRequest {
        if ((Integer(params.get("extended"))) == 1) {
            return prepareRequest("get", params, VKRequest.HttpMethod.GET, VKApiCommunityArray.class);
        } else {
            return prepareRequest("get", params);
        }
    }

    public function getMembers(params:VKParameters):VKRequest {
        return prepareRequest("getMembers", params);
    }

    public function join(params:VKParameters):VKRequest {
        return prepareRequest("join", params);
    }

    public function leave(params:VKParameters):VKRequest {
        return prepareRequest("leave", params);
    }

    public function leave(group_id:int):VKRequest {
        return prepareRequest("leave", new VKParameters() {
            {
                put(VKApiConst.GROUP_ID, String.valueOf(group_id));
            }
        });
    }

    public function search(params:VKParameters):VKRequest {
        return prepareRequest("search", params, VKRequest.HttpMethod.GET, VKApiCommunityArray.class);
    }

    public function getInvites(params:VKParameters):VKRequest {
        return prepareRequest("getInvites", params, VKRequest.HttpMethod.GET, VKApiCommunityArray.class);
    }

    public function banUser(params:VKParameters):VKRequest {
        return prepareRequest("banUser", params);
    }

    public function unbanUser(params:VKParameters):VKRequest {
        return prepareRequest("unbanUser", params);
    }

    public function getBanned(params:VKParameters):VKRequest {
        return prepareRequest("getBanned", params, VKRequest.HttpMethod.GET, VKUsersArray.class);
    }
}
}