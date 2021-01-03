package ui;

class PlayerHUD extends FlxTypedGroup<FlxSprite> {
	public var position:FlxPoint;
	public var player:Player;
	public var currentHealth:Float;
	public var healthVisual:Array<FlxSprite>;

	public function new(x:Float, y:Float, player:Player) {
		super();
		position = new FlxPoint(x, y);
		this.player = player;
		currentHealth = player.health;
		healthVisual = [];
		// add(healthGrp);
		create();
	}

	/**
	 * Creates the health points for the player.
	 		* Also shows the border below for the player health.
	 */
	public function create() {
		createHealthPoints(position);
		createBorder(position);
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
		trace('Created Player HUD', healthVisual);
	}

	public function createBorder(position:FlxPoint) {}

	override public function update(elapsed:Float) {
		super.update(elapsed);
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

	public function showHealth(health:FlxSprite) {
		health.visible = true;
	}

	public function hideHealth(health:FlxSprite) {
		health.visible = false;
	}
}