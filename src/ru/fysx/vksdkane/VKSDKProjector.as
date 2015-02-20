package ru.fysx.vksdkane {

	import com.vk.sdk.VKAccessToken;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.utils.Dictionary;

	public class VKSDKProjector extends EventDispatcher {

		private static var _instance	:VKSDKProjector;		
		private static var _extContext	:ExtensionContext;
		private static var _callbacks	:Dictionary = new Dictionary;

		public static function get instance():VKSDKProjector {
			if (!_instance) {
				_instance = new VKSDKProjector();
				_extContext = ExtensionContext.createExtensionContext("ru.fysx.vksdkane.VKSDKProjector", "net");
				_extContext.addEventListener(StatusEvent.STATUS, onStatus);
			}
			return _instance;
		}
		public function registerCallback(name:String, callback:Function):void {
			_callbacks[name] = callback;
		}
		public function initSDK(appId:String, accessToken:VKAccessToken):void {
			var params:Array = ["initSDK", appId, accessToken.accessToken?accessToken.accessToken:"", accessToken.userId?accessToken.userId:"", accessToken.secret?accessToken.secret:"", accessToken.expiresIn?accessToken.expiresIn:0];
			_extContext.call.apply(this, params);
		}
		public function authorize(scope:Array, revoke:Boolean, forceOAuth:Boolean):void {
			scope.splice(0, 0, "authorize", revoke, forceOAuth);
			_extContext.call.apply(this, scope);
		}
		public function getAccessToken():VKAccessToken {
			return VKAccessToken(_extContext.call("getAccessToken"));
		}

		private static function onStatus( e:StatusEvent ):void {
			if ( e.level == "status" ) {
				if (_callbacks[e.code] is Function) {
					_callbacks[e.code]();
				}
			}
		}
	}
}