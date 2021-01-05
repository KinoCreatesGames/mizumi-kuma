package states;

class GameOverSubState extends FlxSubState {
	override public function create() {
		FlxG.mouse.visible = true;
		var gameOverText = new FlxText(0, 0, -1, Globals.TEXT_GAME_OVER, 32);
		gameOverText.screenCenter();
		gameOverText.scrollFactor.set(0, 0);
		add(gameOverText);

		// Buttons
		createButtons();
	}

	public function createButtons() {
		var y = 40;
		var retryButton = new FlxButton(0, 0, Globals.TEXT_RETRY, clickRetry);
		retryButton.screenCenter();
		retryButton.y += y;
		y += 40;
		var toTitleButton = new FlxButton(0, 0, Globals.TEXT_TO_TITLE,
			clickToTitle);
		toTitleButton.screenCenter();
		toTitleButton.y += y;

		add(retryButton);
		add(toTitleButton);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	public function clickRetry() {
		FlxG.resetState();
		close();
	}

	public function clickToTitle() {
		FlxG.switchState(new TitleState());
	}
}