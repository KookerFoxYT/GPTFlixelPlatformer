import flixel.FlxG;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxState;
import flixel.util.FlxSave;

using StringTools;

class TitleState extends FlxState {
	private var titleText:FlxText;
	private var startButton:FlxButton;
	private var optionsButton:FlxButton;
	private var save:FlxSave;

	public function new() {
		super();
	}

	override public function create():Void {
		super.create();

		// Set the background color to black
		FlxG.bgColor = 0xff000000;

		// Add the title text
		titleText = new FlxText(0, 40, FlxG.width, "Kooker's Platformer Example");
		titleText.setFormat(null, 24, 0xffffff, "center");
		add(titleText);

		// Add the start button
		startButton = new FlxButton(FlxG.width / 2 - 40, 100, "Start", onStartClick);
		add(startButton);

		// Add the options button
		optionsButton = new FlxButton(FlxG.width / 2 - 40, 140, "Options", onOptionsClick);
		add(optionsButton);

		// Initialize the save file
		save = new FlxSave();
		if (!save.bind("platexample")) {
			trace("Could not bind save file!");
		}
	}

	private function onStartClick():Void {
		// Go to the game state
		FlxG.switchState(new LevelState());
	}

	private function onOptionsClick():Void {
		// Go to the options state
		FlxG.switchState(new OptionsState());
	}
}
