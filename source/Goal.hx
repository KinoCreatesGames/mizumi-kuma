class Goal extends FlxSprite {
	public function new(x:Float, y:Float) {
		super(x, y);
		create();
	}

	public function create() {
		loadGraphic(AssetPaths.door__png, false, 16, 16);
	}
}