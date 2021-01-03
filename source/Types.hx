typedef Char = {
	public var health:Int;
}

typedef Monster = {
	> Char,
	public var patrol:Array<FlxPoint>;
}

enum abstract AnimTypes(String) from String to String {
	public var IDLE:String = 'idle';
	public var MOVE:String = 'move';
	public var DEATH:String = 'death';
}