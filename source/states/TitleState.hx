package states;

class TitleState extends FlxState {
	override public function create() {
		FlxG.mouse.visible = true;
		// Create Title Text
		var text = new FlxText(0, 0, 300, Globals.GAME_TITLE, 32);
		add(text);
		text.screenCenter();
		// Create Buttons
		var playButton = new FlxButton(0, 300, "Start", clickStart);
		playButton.screenCenter();
		playButton.y += 40;
		add(playButton);

		createControls();
		createCredits();
		super.create();
	}

	public function clickStart() {
		FlxG.switchState(new PlayState());
	}

	public function clickOptions() {
		// openSubState(new OptionSubState());
	}

	public function createControls() {
		var textWidth = 200;
		var textSize = 12;
		var controlsText = new FlxText(20, FlxG.height - 100, textWidth,
			'How To Move:
UP: W/UP
Left/Right: A/Left, S/Right
Shoot: Z', textSize);
		add(controlsText);
	}

	public function createCredits() {
		var textWidth = 200;
		var textSize = 12;
		var creditsText = new FlxText(FlxG.width - textWidth,
			FlxG.height - 100, textWidth, 'Created by KinoCreates', textSize);
		add(creditsText);
	}
}