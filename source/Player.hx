package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

using StringTools;

class Player extends FlxSprite {
	var moveSpeed:Float = 120;
	var jumpSpeed:Float = 200;
	var wallJumpSpeed:Float = 150;
	var wallSlideSpeed:Float = 60;
	var wallJumpDelay:Float = 0.15;

	var jumpTimer:FlxTimer;
	var wallJumpTimer:FlxTimer;
	var wallJumping:Bool = false;
	var wallJumpDirection:Int = 0;

	public function new(x:Float, y:Float) {
		super(x, y);
		makeGraphic(16, 16, 0xffffffff);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

		// Handle player movement and controls

		// Horizontal movement
		velocity.x = 0;
		if (FlxG.keys.LEFT) {
			velocity.x = -moveSpeed;
			facing = FlxSprite.LEFT;
		} else if (FlxG.keys.RIGHT) {
			velocity.x = moveSpeed;
			facing = FlxSprite.RIGHT;
		}

		// Jumping
		if (jumpTimer != null && jumpTimer.finished) {
			jumpTimer = null;
		}
		if (FlxG.keys.justPressed.SPACE && (isTouching(FLOOR) || isTouching(WALL)) && jumpTimer == null) {
			velocity.y = -jumpSpeed;
			jumpTimer = new FlxTimer();
			jumpTimer.start(0.2, 1, stopJump);
		}

		// Wall sliding
		if (isTouching(WALL) && !isTouching(FLOOR)) {
			velocity.y = wallSlideSpeed;
		}

		// Wall jumping
		if (FlxG.keys.justPressed.SPACE && isTouching(WALL) && !isTouching(FLOOR) && wallJumpTimer == null) {
			wallJumping = true;
			wallJumpDirection = (isTouching(WALL_LEFT)) ? 1 : -1;
			velocity.y = -jumpSpeed;
			velocity.x = wallJumpDirection * wallJumpSpeed;
			wallJumpTimer = new FlxTimer();
			wallJumpTimer.start(wallJumpDelay, 1, stopWallJump);
		}
		if (wallJumpTimer != null && wallJumpTimer.finished) {
			wallJumpTimer = null;
		}
	}

	public function stopJump(timer:FlxTimer):Void {
		velocity.y = 0;
	}

	public function stopWallJump(timer:FlxTimer):Void {
		wallJumping = false;
	}
}
