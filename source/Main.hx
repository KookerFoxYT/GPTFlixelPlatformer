import openfl.display.FPS;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.util.FlxSave;

class Main {
	static function main() {
		// Initialize the game window and set the resolution to 320x240 pixels
		FlxG.init(320, 240, 2);

		// Create the FlxGame object and add it to the game window
		var game = new FlxGame(320, 240, new TitleState(), 2, 60, 60, false, false);
		FlxG.stage.addChild(game);

		// Create an FPS counter and add it to the game window
		var fps = new FPS();
		FlxG.stage.addChild(fps);
	}
}
