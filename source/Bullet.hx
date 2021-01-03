import flixel.math.FlxVector;

class Bullet extends FlxSprite {
	public var speed:Float;

	public function new() {
		super(0, 0);

		this.speed = 400;
		this.makeBulletGraphic();
	}

	public function makeBulletGraphic() {
		// switch (this.bulletType) {
		// 	case PLAYERBULLET:
		this.makeGraphic(8, 8, FlxColor.WHITE);
		// case ENEMYBULLET:
		// 	this.makeGraphic(8, 8, FlxColor.RED);
		// }
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateAvailable();
	}

	// Updates availability to allow for getting first available bullet for player
	public function updateAvailable() {
		if (!this.isOnScreen()) {
			this.kill();
		}
	}

	public function fire(dir:FlxVector) {
		velocity.set(dir.x * this.speed, dir.y * this.speed);
	}
}