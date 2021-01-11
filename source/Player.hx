import flixel.math.FlxVector;

class Player extends Entity {
	public static inline var SPEED:Float = 640;
	public static inline var JUMP_SPEED:Float = 600;
	public static inline var JUMP_CD:Float = 0.10;
	public static inline var BULLET_CD:Float = 0.15;
	public static inline var INVINCIBLE_CD:Float = 2.0;

	public var firePoint:FlxPoint;

	private var internalJumpCd:Float = 0.10;

	public var fireCD:Float;
	public var isJumping:Bool;
	public var invincibleCD:Float;
	public var isInvincble:Bool;
	public var invincibleCount:Int;

	public var bulletGrp:FlxTypedGroup<Bullet>;

	public function new(x:Float, y:Float, bulletGrp:FlxTypedGroup<Bullet>) {
		super(x, y);
		health = Globals.PLAYER_HEALTH_CAP;
		drag.x = drag.y = 640;
		acceleration.y = 600;
		isJumping = false;
		isInvincble = false;
		invincibleCD = INVINCIBLE_CD;
		this.bulletGrp = bulletGrp;
		fireCD = BULLET_CD;
		setSize(8, 8);
		// offset.set(4, );
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		updateCollision(elapsed);
		updateFire(elapsed);
		updateMovement(elapsed);
	}

	public function updateCollision(elapsed:Float) {
		if (isInvincble && invincibleCD > 0) {
			// trace('took damage updating visibility', visible);
			invincibleCD -= elapsed;
			invincibleCount += 1;
			if (invincibleCount % 10 == 0) {
				visible = !visible;
			}
		}

		if (invincibleCD <= 0) {
			invincibleCD = INVINCIBLE_CD;
			invincibleCount = 0;
			isInvincble = false;
			visible = true;
		}
	}

	public function updateFire(elapsed:Float) {
		var firing = false;
		firing = FlxG.keys.anyPressed([Z]);

		if (firing && fireCD <= 0) {
			fireCD = BULLET_CD;

			var xOffset = 4;
			this.firePoint = new FlxPoint(8 + x, y);
			var bullet = null;

			var fireVec = new FlxVector(1, 0);
			if (bulletGrp.length < 50) {
				bullet = new Bullet();
				bulletGrp.add(bullet);
			} else {
				bullet = bulletGrp.getFirstDead();
				bullet.revive();
			}
			bullet.setPosition(this.firePoint.x + xOffset, this.firePoint.y);
			bullet.fire(fireVec);
		}
		fireCD -= elapsed;
	}

	public function updateMovement(elapsed:Float) {
		var up = false;
		var down = false;
		var left = false;
		var right = false;

		maxVelocity.set(120, 200);

		up = FlxG.keys.anyJustPressed([UP, W]);
		// down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);

		if (up && down) up = down = false;
		if (left && right) left = right = false;

		if (isJumping && internalJumpCd > 0) {
			internalJumpCd -= elapsed;
		} else {
			// Add a line here to increase max velocity if time spent in
			// the air is longer than say 2 seconds
			allowCollisions = FlxObject.ANY;
		}

		// Because we're using acceleration above to handle gravity insteada of velocity
		// We need to then use acceleration in the x  axis to account for change in speed
		// overtime for jumps and for y we use velocity because a jump is a burst of speed
		// trace(y, acceleration.y, velocity.y);
		acceleration.x = 0;
		// Handle Actual Movement
		if (up || down || left || right) {
			var newAngle:Float = 0;
			if (up && velocity.y <= 10 && !isJumping) {
				allowCollisions = FlxObject.NONE;

				isJumping = true;
				internalJumpCd = JUMP_CD;
				velocity.y = -JUMP_SPEED;
			}
			if (left) {
				flipX = true;
				acceleration.x -= SPEED;
			}
			if (right) {
				flipX = false;
				acceleration.x += SPEED;
			}

			// this.bound();
		}
	}
}