package states;

class LevelFinalState extends LevelState {
	override public function create() {
		super.create();
		createLevel('');
	}

	override public function setLevelTime() {
		levelTime = 120.0;
	}

	override public function playerTouchGoal(player:Player, goal:FlxSprite) {
		// Open Next Level
		super.playerTouchGoal(player, goal);
		// trace(FlxG.camera.width, FlxG.camera.height);
		openSubState(new WinSubState(null, new LevelTwoState()));
	}
}