package states;

class LevelTwoState extends LevelState {
	override public function create() {
		super.create();
		createLevel('assets/maps/mizumi-map_tiled/2_Level2.tmx');
	}

	override public function setLevelTime() {
		levelTime = 180.0;
	}

	override public function playerTouchGoal(player:Player, goal:FlxSprite) {
		// Open Next Level
		super.playerTouchGoal(player, goal);
		// trace(FlxG.camera.width, FlxG.camera.height);
		openSubState(new WinSubState(null, new LevelThreeState()));
	}
}