package states;

class PauseSubState extends FlxSubState {
	override public function create() {
		FlxG.mouse.visible = true;
		var pauseText = new FlxText(0, 0, -1, 'Pause', 32);
		pauseText.screenCenter();
		add(pauseText);
		var resumeButton = new FlxButton(0, 0, 'Resume', resumeGame);
		resumeButton.screenCenter();
		resumeButton.y += 40;
		var returnToTitleButton = new FlxButton(0, 0, 'To Title', toTitle);
		returnToTitleButton.screenCenter();
		returnToTitleButton.y += 80;
		add(resumeButton);
		add(returnToTitleButton);
		super.create();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	public function resumeGame() {
		close();
	}

	public function toTitle() {
		FlxG.switchState(new TitleState());
	}
}