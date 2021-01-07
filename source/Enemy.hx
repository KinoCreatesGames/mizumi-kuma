import Types.AnimTypes;
import flixel.math.FlxVelocity;
import flixel.math.FlxVector;
import Types.Monster;

class Enemy extends Entity {
	public static inline var WAIT_TIME:Float = 5.0;
	public static inline var SPEED:Float = 75;

	public var count = 0;
	public var destination:FlxPoint;

	var ai:State;
	var monsterData:Monster;

	public function new(x:Float, y:Float, data:Monster) {
		super(x, y);
		monsterData = data;
		addAnimations();
	}

	public function addAnimations() {}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		ai.update(elapsed);
		updateAnim();
	}

	public function updateAnim() {}

	public function updateMovement() {}
}