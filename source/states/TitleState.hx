package states;

class TitleState extends FlxState {
	override public function create() {
		FlxG.mouse.visible = true;
		var text = new FlxText(0, 0, 300, Globals.GAME_TITLE, 32);
		add(text);
		text.screenCenter();
		var playButton = new FlxButton(0, 300, "Start", clickStart);
		playButton.screenCenter();
		playButton.y += 40;
		add(playButton);
		var optionButton = new FlxButton(0, 300, "Options", clickOptions);
		optionButton.screenCenter();
		optionButton.y += 80;
		add(optionButton);
		super.create();
	}

	public function clickStart() {
		FlxG.switchState(new PlayState());
	}

	public function clickOptions() {
		// openSubState(new OptionSubState());
	}
}