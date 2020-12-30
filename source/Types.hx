typedef Char = {
	public var health:Int;
}

typedef Monster = {
	> Char,
	public var patrol:Array<FlxPoint>;
}