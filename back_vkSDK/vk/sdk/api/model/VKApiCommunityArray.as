package com.vk.sdk.api.model {
import org.json.JSONException;
import org.json.JSONObject;

/**
 * Array of VKGroup
 * Created by alex_xpert on 28.01.14.
 */
public class VKApiCommunityArray extends VKList<VKApiCommunityFull> {
    
override public function parse(response:JSONObject):VKApiModel {
        fill(response, VKApiCommunityFull.class);
        return this;
    }
}
}