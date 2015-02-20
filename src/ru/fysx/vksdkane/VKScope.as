package ru.fysx.vksdkane 
{
	/**
	 * ...
	 * @author fysx
	 */
	public class VKScope 
	{
		public static const NOTIFY:String = "notify";
		public static const FRIENDS:String = "friends";
		public static const PHOTOS:String = "photos";
		public static const AUDIO:String = "audio";
		public static const VIDEO:String = "video";
		public static const DOCS:String = "docs";
		public static const NOTES:String = "notes";
		public static const PAGES:String = "pages";
		public static const STATUS:String = "status";
		public static const WALL:String = "wall";
		public static const GROUPS:String = "groups";
		public static const MESSAGES:String = "messages";
		public static const NOTIFICATIONS:String = "notifications";
		public static const STATS:String = "stats";
		public static const ADS:String = "ads";
		public static const OFFLINE:String = "offline";
		public static const NOHTTPS:String = "nohttps";
		public static const DIRECT:String = "direct";

		/**
		 * Converts integer value of permissions into arraylist of constants
		 * @param permissionsValue integer permissions value
		 * @return Vector contains string constants of permissions (scope)
		 */
		public static function parseVkPermissionsFromInteger(permissionsValue:int):Vector.<String> {
			var res:Vector.<String> = new Vector.<String>();
			if ((permissionsValue & 1) > 0) res.push(NOTIFY);
			if ((permissionsValue & 2) > 0) res.push(FRIENDS);
			if ((permissionsValue & 4) > 0) res.push(PHOTOS);
			if ((permissionsValue & 8) > 0) res.push(AUDIO);
			if ((permissionsValue & 16) > 0) res.push(VIDEO);
			if ((permissionsValue & 128) > 0) res.push(PAGES);
			if ((permissionsValue & 1024) > 0) res.push(STATUS);
			if ((permissionsValue & 2048) > 0) res.push(NOTES);
			if ((permissionsValue & 4096) > 0) res.push(MESSAGES);
			if ((permissionsValue & 8192) > 0) res.push(WALL);
			if ((permissionsValue & 32768) > 0) res.push(ADS);
			if ((permissionsValue & 65536) > 0) res.push(OFFLINE);
			if ((permissionsValue & 131072) > 0) res.push(DOCS);
			if ((permissionsValue & 262144) > 0) res.push(GROUPS);
			if ((permissionsValue & 524288) > 0) res.push(NOTIFICATIONS);
			if ((permissionsValue & 1048576) > 0) res.push(STATS);
			return res;
		}
	}

}