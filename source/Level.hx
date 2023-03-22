import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import flixel.util.FlxPoint;

class Level {
	private var tileSize:Int = 16;
	private var width:Int;
	private var height:Int;
	private var tiles:Array<Array<Int>>;

	public function new(width:Int, height:Int) {
		this.width = width;
		this.height = height;
		this.tiles = new Array<Array<Int>>(width);
		for (x in 0...width) {
			this.tiles[x] = new Array<Int>(height);
			for (y in 0...height) {
				this.tiles[x][y] = 0;
			}
		}
	}

	public function generate(seed:Int):Void {
		var noise:openfl.display.BitmapData = new openfl.display.BitmapData(width, height, false);
		noise.perlinNoise(width / 4, height / 4, 4, seed, true, true, 7, true);

		for (x in 0...width) {
			for (y in 0...height) {
				var value:Int = noise.getPixel(x, y) & 0xFF;
				if (value > 128) {
					tiles[x][y] = 1;
				}
			}
		}
	}

	public function getTile(x:Int, y:Int):Int {
		if (x < 0 || y < 0 || x >= width || y >= height) {
			return 0;
		}
		return tiles[x][y];
	}

	public function setTile(x:Int, y:Int, tile:Int):Void {
		if (x < 0 || y < 0 || x >= width || y >= height) {
			return;
		}
		tiles[x][y] = tile;
	}

	public function getTileSize():FlxPoint {
		return new FlxPoint(tileSize, tileSize);
	}

	public function getSize():FlxPoint {
		return new FlxPoint(width * tileSize, height * tileSize);
	}
}
