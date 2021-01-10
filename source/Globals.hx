class Globals {
	public static inline var GAME_TITLE = 'Mizumi Kuma';
	public static inline var TEXT_GAME_OVER = 'Game Over';
	public static inline var TEXT_RETRY = 'Retry';
	public static inline var TEXT_TO_TITLE = 'To Title';
	public static inline var TEXT_LEVEL_NEXT = 'Next';
	public static inline var TEXT_LEVEL_WIN = 'Congratulations!!';
	public static inline var TIME_BONUS:Int = 100;
	public static inline var CMD_TIME_SCALE = 0.015;
	public static inline var PLAYER_HEALTH_CAP = 3;
	public static inline var PLAYER_BULLET_CD:Float = 0.15;
	public static var HIGH_SCORE:Int = 0;

	public static function updateHighScore(value:Int) {
		HIGH_SCORE += value;
	}

	public static function setHighScore(value:Int) {
		HIGH_SCORE = value;
	}
}