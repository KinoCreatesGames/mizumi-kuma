import Types.AnimTypes;
import flixel.math.FlxVelocity;
import flixel.math.FlxVector;
import Types.Monster;

class Charger extends Enemy {
	public static inline var SPEED:Float = 125;

	public var seesPlayer:Bool;
	public var playerPosition:FlxPoint;

	public function new(x:Float, y:Float, data:Monster) {
		super(x, y, data);
		ai = new State(idle);
		seesPlayer = false;
		playerPosition = FlxPoint.get();
		acceleration.y = 600;
		drag.x = drag.y = 640;
	}

	override public function addAnimations() {
		super.addAnimations();
		loadGraphic(AssetPaths.charger__png, true, 16, 16);
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
		animation.add(IDLE, [0, 5], 6);
		animation.add(MOVE, [1, 2, 3], 6);
		animation.add(DEATH, [0, 5, 6], 2);
	}

	override public function update(elapsed) {
		super.update(elapsed);
	}

	override public function updateAnim() {
		if (!alive) {
			animation.play(DEATH);
		} else if (ai.currentState == charge) {
			animation.play(MOVE);
		} else if (ai.currentState == idle) {
			animation.play(IDLE);
		}
	}

	public function idle(elapsed:Float) {
		if (seesPlayer) {
			ai.currentState = charge;
		} else {}
	}

	public function charge(elapsed:Float) {
		if (!seesPlayer) {
			ai.currentState = idle;
		} else {
			var vec:FlxVector = getMidpoint().copyTo(new FlxVector(0, 0));
			var playerVec:FlxVector = playerPosition.copyTo(new FlxVector(0,
				0));
			var result = playerVec.subtractPoint(vec);
			var direction = result.normalize();
			// trace(direction.x);
			acceleration.x += SPEED * direction.x;
		}
	}
}