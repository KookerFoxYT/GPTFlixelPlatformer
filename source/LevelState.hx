package;

import flash.system.System;
import flixel.FlxG;
import flixel.FlxGroup;
import flixel.FlxState;
import flixel.addons.perlin.NoiseGenerator;
import flixel.addons.tile.FlxTilemapPlus;
import flixel.plugin.photonstorm.FlxWeapon;
import flixel.util.FlxPoint;

class LevelState extends FlxState {
	private var player:Player;
	private var enemies:FlxGroup;
	private var powerups:FlxGroup;
	private var level:FlxTilemapPlus;

	override public function create():Void {
		// Generate level using Perlin noise
		var noise:NoiseGenerator = new NoiseGenerator(FlxG.width, FlxG.height, 0.5, 1, 2, true);
		level = new FlxTilemapPlus();
		level.loadMapFromCSV(noise.generateCSV(16, 16, "012345", "0"), "tiles.png", 16, 16, FlxTilemapPlus.AUTO);
		add(level);

		// Create player
		player = new Player(16, 16);
		add(player);

		// Create enemies
		enemies = new FlxGroup();
		for (i in 0...5) {
			var enemy:Enemy = new Enemy(FlxG.random() * FlxG.width, FlxG.random() * FlxG.height);
			enemies.add(enemy);
		}
		add(enemies);

		// Create powerups
		powerups = new FlxGroup();
		for (i in 0...3) {
			var powerupType:PowerUp.PowerUpType = [PowerUp.PowerUpType.JUMP, PowerUp.PowerUpType.SPEED][i % 2];
			var powerup:Powerup = new Powerup(FlxG.random() * FlxG.width, FlxG.random() * FlxG.height, powerupType);
			powerups.add(powerup);
		}
		add(powerups);

		// Set camera to follow player
		FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
	}

	override public function update(elapsed:Float):Void {
		// Collisions
		FlxG.collide(player, level);
		FlxG.overlap(player, enemies, onPlayerEnemyOverlap);
		FlxG.overlap(player, powerups, onPlayerPowerupOverlap);

		// Update entities
		super.update(elapsed);
	}

	private function onPlayerEnemyOverlap(player:Player, enemy:Enemy):Void {
		// Handle player-enemy collision
		System.exit(0);
	}

	private function onPlayerPowerupOverlap(player:Player, powerup:Powerup):Void {
		// Handle player-powerup collision
		trace('powerup');
	}
}
