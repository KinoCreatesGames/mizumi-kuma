package states;

class WinSubState extends FlxSubState {
	public var nextLevel:FlxState;

	public function new(?bgColor:FlxColor, nextLevel) {
		super(bgColor);
		FlxG.mouse.visible = true;
		this.nextLevel = nextLevel;
	}

	override public function create() {
		createTitle();
		createButtons();
		super.create();
	}

	public function createTitle() {
		var titleText = new FlxText(0, 0, -1, Globals.TEXT_LEVEL_WIN, 32);
		titleText.screenCenter();
		titleText.scrollFactor.set(0, 0);
		add(titleText);
	}

	public function createButtons() {
		var y = 40;
		var nextButton = new FlxButton(0, 0, Globals.TEXT_LEVEL_NEXT,
			toNextLevel);
		nextButton.screenCenter();
		nextButton.y += y;
		add(nextButton);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	public function toNextLevel() {
		FlxG.switchState(nextLevel);
	}
}