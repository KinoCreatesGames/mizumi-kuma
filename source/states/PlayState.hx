package states;

import states.WinSubState;
import flixel.text.FlxText;
import flixel.FlxState;

class PlayState extends LevelState {
	override public function create() {
		super.create();
		createLevel('assets/maps/mizumi-map_tiled/1_Level.tmx');
	}

	override public function setLevelTime() {
		levelTime = 60.0;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	override public function playerTouchGoal(player:Player, goal:FlxSprite) {
		// Open Next Level
		super.playerTouchGoal(player, goal);
		// trace(FlxG.camera.width, FlxG.camera.height);
		openSubState(new WinSubState(null, new LevelTwoState()));
	}
}