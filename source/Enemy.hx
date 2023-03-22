package;

import flixel.FlxSprite;
import flixel.util.FlxTimer;

class Enemy extends FlxSprite {
	var moveTimer:FlxTimer;
	var moveDirection:Int = 1;
	var moveSpeed:Float = 60;

	public function new(x:Float, y:Float) {
		super(x, y);
		makeGraphic(16, 16, 0xff0000ff);
		immovable = true;

		// Create a timer to control enemy movement
		moveTimer = new FlxTimer();
		moveTimer.start(2, 0, move);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}

	public function move(timer:FlxTimer):Void {
		// Flip the enemy's horizontal velocity to change direction
		velocity.x = moveDirection * moveSpeed;
		moveDirection *= -1;
	}
}
