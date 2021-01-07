import Types.AnimTypes;
import flixel.math.FlxVelocity;
import flixel.math.FlxVector;
import Types.Monster;

class Patroller extends Enemy {
	public static inline var WAIT_TIME:Float = 5.0;
	public static inline var SPEED:Float = 75;

	var waitTime:Float;

	public function new(x:Float, y:Float, data:Monster) {
		super(x, y, data);
		waitTime = WAIT_TIME;
		ai = new State(idle);
		addAnimations();
	}

	public override function addAnimations() {
		super.addAnimations();
		loadGraphic(AssetPaths.enemy__png, true, 16, 16);
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
		animation.add(IDLE, [0, 5], 6);
		animation.add(MOVE, [1, 2, 3], 6);
		animation.add(DEATH, [0, 5, 6], 2);
	}

	override public function updateAnim() {
		if (!alive) {
			animation.play(DEATH);
		} else if (ai.currentState == patrol) {
			animation.play(MOVE);
		} else if (ai.currentState == idle) {
			animation.play(IDLE);
		}
	}

	public function idle(elapsed:Float) {
		if (waitTime <= 0) {
			ai.currentState = patrol;
		} else {
			waitTime -= elapsed;
		}
	}

	public function patrol(elapsed:Float) {
		if (waitTime <= 0) {
			waitTime = WAIT_TIME;
			var nextPatrolPoint = monsterData.patrol[count % 2];
			destination = nextPatrolPoint;
			FlxVelocity.moveTowardsPoint(this, nextPatrolPoint, SPEED);
			var patrolVec:FlxVector = velocity.copyTo(new FlxVector(0, 0));
			facing = patrolVec.normalize()
				.x > 0 ? FlxObject.RIGHT : FlxObject.LEFT;

			count += 1;
		} else {
			waitTime -= elapsed;
			var position = this.getPosition();
			// trace(position.distanceTo(destination));
			if (position.distanceTo(destination) < 20) {
				velocity.set(0, 0);
				ai.currentState = idle;
			}
		}
	}
}