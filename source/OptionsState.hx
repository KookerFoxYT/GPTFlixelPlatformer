import flixel.FlxG;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxState;
import flixel.util.FlxSave;

using StringTools;

class OptionsState extends FlxState {
  private var optionsText:FlxText;
  private var backButton:FlxButton;
  private var musicCheckbox:FlxButton;
  private var soundCheckbox:FlxButton;
  private var save:FlxSave;

  public function new() {
    super();
  }

  override public function create():Void {
    super.create();

    // Set the background color to black
    FlxG.bgColor = 0xff000000;

    // Add the options text
    optionsText = new FlxText(0, 40, FlxG.width, "Options");
    optionsText.setFormat(null, 24, 0xffffff, "center");
    add(optionsText);

    // Add the back button
    backButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height - 40, "Back", onBackClick);
    add(backButton);

    // Add the music checkbox
    musicCheckbox = new FlxButton(FlxG.width / 2 - 40, 100, "Music: On", onMusicClick);
    add(musicCheckbox);

    // Add the sound checkbox
    soundCheckbox = new FlxButton(FlxG.width / 2 - 40, 140, "Sound: On", onSoundClick);
    add(soundCheckbox);

    // Initialize the save file
    save = new FlxSave();
    if (!save.bind("my_platformer_game")) {
      trace("Could not bind save file!");
    }

    // Load the options from the save file
    if (save.data.musicEnabled != null) {
      FlxG.music.setVolume(save.data.musicEnabled ? 1.0 : 0.0);
      musicCheckbox.label.text = save.data.musicEnabled ? "Music: On" : "Music: Off";
    }
    if (save.data.soundEnabled != null) {
      FlxG.sound.setVolume(save.data.soundEnabled ? 1.0 : 0.0);
      soundCheckbox.label.text = save.data.soundEnabled ? "Sound: On" : "Sound: Off";
    }
  }

  private function onBackClick():Void {
    // Go back to the title state
    FlxG.switchState(new TitleState());
  }

  private function onMusicClick():Void {
    // Toggle the music state
    var musicEnabled:Bool = !FlxG.music.volume.equals(0.0);
    FlxG.music.setVolume(musicEnabled ? 0.0 : 1.0);
    musicCheckbox.label.text = musicEnabled ? "Music: Off" : "Music: On";

    // Save the music state to the save file
    save.data.musicEnabled = !musicEnabled;
    save.flush();
  }

  private function onSoundClick():Void {
    // Toggle the sound state
    var soundEnabled:Bool = !FlxG.sound.volume.equals(0.0);
    FlxG.sound.setVolume(soundEnabled ? 0.0 : 1.0);
    soundCheckbox.label.text = soundEnabled ? "Sound: Off" : "Sound: On";

    // Save the sound state to the save file
    save.data.soundEnabled = !soundEnabled;
    save.flush();
  }
}
