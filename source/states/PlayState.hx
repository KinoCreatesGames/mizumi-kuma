package states;

import states.WinSubState;
import flixel.text.FlxText;
import flixel.FlxState;

class PlayState extends LevelState {
	override public function create() {
		super.create();
		createLevel('assets/maps/mizumi-map_tiled/Level.tmx');
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	override public function playerTouchGoal(player:Player, goal:FlxSprite) {
		// Open Next Level
		openSubState(new WinSubState(new PlayState()));
	}
}