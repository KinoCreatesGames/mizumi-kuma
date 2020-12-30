package states;

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
}