package ui;

import flixel.util.FlxAxes;

class PlayerHUD extends FlxTypedGroup<FlxSprite> {
	public var position:FlxPoint;
	public var player:Player;
	public var currentHealth:Float;
	public var healthVisual:Array<FlxSprite>;
	public var levelTimer:FlxText;
	public var levelScore:FlxText;
	public var levelState:LevelState;

	public function new(x:Float, y:Float, player:Player,
			levelState:LevelState) {
		super();
		position = new FlxPoint(x, y);
		this.player = player;
		currentHealth = player.health;
		healthVisual = [];
		this.levelState = levelState;

		// add(healthGrp);
		create();
		members.iter((member) -> {
			member.scrollFactor.set(0, 0);
		});
	}

	/**
	 * Creates the health points for the player.
	 		* Also shows the border below for the player health.
	 */
	public function create() {
		createHealthPoints(position);
		createLevelTimer(position);
		createBorder(position);
	}

	/**
	 * Shows the game time
	 * @param position
	 */
	public function createLevelTimer(position:FlxPoint) {
		var x = position.x;
		var y = position.y;
		var textWidth = 100;
		levelTimer = new FlxText(x, y, textWidth, '0:00', 32);
		levelTimer.screenCenter(FlxAxes.X);
		add(levelTimer);
	}

	public function createLevelScore(position:FlxPoint) {
		var textWidth = 200;
		var x = FlxG.width - textWidth;
		var y = position.y;

		levelScore = new FlxText(x, y, textWidth, '0', 32);
		add(levelScore);
	}

	public function createHealthPoints(position:FlxPoint) {
		var x = position.x;
		var y = position.y;
		var spacing = 8;
		for (i in 0...cast player.health) {
			var healthSprite = new FlxSprite(x, y);
			healthSprite.loadGraphic(AssetPaths.heart__png, false, 16, 16);
			healthVisual.push(healthSprite);
			add(healthSprite);
			x += 16 + spacing;
		}
	}

	public function createBorder(position:FlxPoint) {}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateLevelTimer();
		updateHealthPoints();
	}

	public function updateHealthPoints() {
		var val:Int = cast(healthVisual.length - player.health).clampf(0, 3);
		if (currentHealth < player.health) {
			if (!healthVisual[0].visible) healthVisual.reverse();
			healthVisual.slice(0, cast player.health).iter(showHealth);
		} else if (currentHealth > player.health) {
			if (healthVisual[0].visible) healthVisual.reverse();
			healthVisual.slice(0, val).iter(hideHealth);
		}
		currentHealth = player.health;
	}

	public function updateLevelTimer() {
		var levelTime:Int = Math.ceil(levelState.levelTime);
		var timeText = '${levelTime}';
		levelTimer.text = timeText;
	}

	public function updateLevelScore() {
		levelScore.text = '';
	}

	public function showHealth(health:FlxSprite) {
		health.visible = true;
	}

	public function hideHealth(health:FlxSprite) {
		health.visible = false;
	}
}