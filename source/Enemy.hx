import flixel.math.FlxVelocity;
import flixel.math.FlxVector;
import Types.Monster;

class Enemy extends Entity {
	public static inline var WAIT_TIME:Float = 2.0;
	public static inline var SPEED:Float = 25;

	public var count = 0;

	var ai:State;
	var monsterData:Monster;
	var waitTime:Float;

	public function new(x:Float, y:Float, data:Monster) {
		super(x, y);
		monsterData = data;
		waitTime = WAIT_TIME;
		ai = new State(idle);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		ai.update(elapsed);
	}

	public function updateMovement() {}

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
			FlxVelocity.moveTowardsPoint(this, nextPatrolPoint, SPEED);
			count += 1;
		} else {
			waitTime -= elapsed;
		}
	}
}