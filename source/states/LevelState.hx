package states;

import Types.Monster;
import flixel.FlxObject;
import flixel.util.FlxCollision;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import openfl.utils.AssetCache;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledTile;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledMap;

class LevelState extends FlxState {
	public var map:TiledMap;
	public var enemyGrp:FlxTypedGroup<FlxSprite>;
	public var playerGrp:FlxTypedGroup<FlxSprite>;
	public var tileGrp:FlxTypedGroup<FlxSprite>;
	public var decorationGrp:FlxTypedGroup<FlxTilemap>;
	// We need to create this because a TiledMap is just there to hold data
	public var level:FlxTilemap;

	public var player:Player;

	override public function create() {
		super.create();
		FlxG.mouse.visible = false;
	}

	public function createLevel(?levelName:String) {
		final map = new TiledMap(levelName);
		this.map = map;
		final playerLayer:TiledObjectLayer = cast(map.getLayer("Player"));
		final enemiesLayer:TiledObjectLayer = cast(map.getLayer('Enemies'));
		final tileLayer:TiledTileLayer = cast(map.getLayer('Floor'));
		level = new FlxTilemap();
		decorationGrp = new FlxTypedGroup<FlxTilemap>();
		tileGrp = new FlxTypedGroup<FlxSprite>();
		enemyGrp = new FlxTypedGroup<FlxSprite>();
		playerGrp = new FlxTypedGroup<FlxSprite>();

		add(decorationGrp);
		add(enemyGrp);
		add(playerGrp);
		add(tileGrp);

		// trace(tileLayer, tileLayer.tileArray, tileLayer.csvData, 'trace');
		// js.Browser.console.log(tileLayer, 'js clg');
		createLevelMap(tileLayer);
		playerLayer.objects.iter(placePlayer);
		enemiesLayer.objects.iter(placeEnemies);
	}

	// Gets the Tiled Image Data from the level layer and creates a level
	// This uses the Ldtk tileD export
	public function createLevelMap(tileLayer:TiledTileLayer) {
		// This one did not work because the tiled asset data is not cached by Flixel
		var tileset:TiledTileSet = map.getTileSet('Dungeon_tiles');
		// This works because it has an ID given by Flixel
		var tilesetPath = AssetPaths.monochrome_kenney__png;
		final tileLayer:TiledTileLayer = cast(map.getLayer('Floor'));
		level.loadMapFromArray(tileLayer.tileArray, map.width, map.height,
			tilesetPath, map.tileWidth, map.tileHeight,
			FlxTilemapAutoTiling.OFF, tileset.firstGID, 1);

		// for (tile in tileLayer.tileArray) {
		// 	level.setTileProperties(tile, FlxObject.FLOOR);
		// }
		add(level);
		createDecorationLayers();
	}

	public function createDecorationLayers() {
		var tileset:TiledTileSet = map.getTileSet('Dungeon_tiles');
		// This works because it has an ID given by Flixel
		var tilesetPath = AssetPaths.monochrome_kenney__png;
		var decorLayerPrefix = 'Decor_';
		trace(map.layers.length);
		for (i in 0...map.layers.length) {
			var tileLayer:TiledTileLayer = cast(map.getLayer(decorLayerPrefix
				+ i));

			if (tileLayer != null) {
				final levelDecoration = new FlxTilemap();
				levelDecoration.loadMapFromArray(tileLayer.tileArray,
					map.width, map.height, tilesetPath, map.tileWidth,
					map.tileHeight, FlxTilemapAutoTiling.OFF,
					tileset.firstGID, 1, FlxObject.NONE);
				decorationGrp.add(levelDecoration);
			}
		};
	}

	public function placePlayer(tObj:TiledObject) {
		var player = new Player(tObj.x, tObj.y);
		player.makeGraphic(tObj.width, tObj.height, FlxColor.BLUE);

		// adjust player hitbox so he doesn't collide with tiles as easily
		this.player = player;
		playerGrp.add(player);
	}

	public function placeEnemies(tObj:TiledObject) {
		var health:Int = cast tObj.properties.get('health');
		var patrolOne = tObj.properties.get('patrol_0')
			.split(",")
			.map(Std.parseFloat)
			.map(f -> (f + 1) * map.tileWidth);
		var patrolTwo = tObj.properties.get('patrol_1')
			.split(",")
			.map(Std.parseFloat)
			.map(f -> (f + 1) * map.tileWidth);
		var monsterData:Monster = {
			health: health,
			patrol: [
				new FlxPoint(patrolOne[0], patrolOne[1]),
				new FlxPoint(patrolTwo[0], patrolTwo[1])
			]
		};
		var enemy = new Enemy(tObj.x, tObj.y, monsterData);
		enemy.makeGraphic(tObj.width, tObj.height, FlxColor.RED);
		enemyGrp.add(enemy);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateCollisions(elapsed);
	}

	public function updateCollisions(elapsed:Float) {
		playerCollisions();
		enemyCollisions();
	}

	public function playerCollisions() {
		if (FlxG.collide(player, level)) {
			player.isJumping = false;
		};

		FlxG.overlap(player, enemyGrp, playerTouchEnemy);
	}

	public function playerTouchEnemy(player:Player, enemy:Enemy) {
		FlxG.camera.shake(0.01, 0.1);
		if (player.health > 0) {
			player.kill();
		} else {
			player.health -= 1;
		}
	}

	public function enemyCollisions() {
		FlxG.collide(enemyGrp, level);
		FlxG.overlap(enemyGrp, player, enemyTouchPlayer);
	}

	public function enemyTouchPlayer(enemy:Enemy, player:Player) {
		if (enemy.health > 0) {
			enemy.kill();
		} else {
			enemy.health -= 1;
		}
	}
}