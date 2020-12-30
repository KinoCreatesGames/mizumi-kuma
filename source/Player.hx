import flixel.math.FlxVector;

class Player extends Entity {
	public static inline var SPEED:Float = 640;
	public static inline var JUMP_SPEED:Float = 600;
	public static inline var JUMP_CD:Float = 0.10;

	private var internalJumpCd:Float = 0.10;

	public var isJumping:Bool;

	public function new(x:Float, y:Float) {
		super(x, y);
		drag.x = drag.y = 640;
		acceleration.y = 600;
		isJumping = false;
		setSize(8, 8);
		// offset.set(4, );
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateMovement(elapsed);
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
		trace(y, acceleration.y, velocity.y);
		acceleration.x = 0;
		// Handle Actual Movement
		if (up || down || left || right) {
			var newAngle:Float = 0;
			if (up && velocity.y <= 10 && !isJumping) {
				trace('Jumped');
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

			this.bound();
		}
	}
}