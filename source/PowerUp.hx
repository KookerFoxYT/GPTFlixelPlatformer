package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.addons.effects.FlxTrail;

using StringTools;

enum PowerUpType {
	JUMP;
	SPEED;
}

class PowerUp extends FlxSprite {
	// The type of power-up
	public var type:PowerUpType;

	// Whether the power-up has been collected or not
	public var collected:Bool = false;

	// The trail effect when the power-up is collected
	private var _trail:FlxTrail;

	public function new(x:Float, y:Float, type:PowerUpType) {
		super(x, y);

		// Set the graphic for the power-up based on its type
		this.type = type;
		switch (type) {
			case PowerUpType.JUMP:
				makeGraphic(16, 16, 0xffa8f8a5);
				break;
			case PowerUpType.SPEED:
				makeGraphic(16, 16, 0xffff88c9);
				break;
		}

		// Set the hitbox and offset
		width = 16;
		height = 16;
		offset.x = 8;
		offset.y = 8;

		// Create the trail effect
		_trail = new FlxTrail(this, 0.2, 5, 0.2, 0xffcfffff, 1);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		// If the power-up has been collected, update the trail effect
		if (collected) {
			_trail.update();
			if (_trail.dead) {
				// Destroy the power-up if the trail effect is finished
				kill();
			}
		}
	}

	public function collect():Void {
		// Set the power-up as collected and start the trail effect
		collected = true;
		_trail.start();
	}
}
