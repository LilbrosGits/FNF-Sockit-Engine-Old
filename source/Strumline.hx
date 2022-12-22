package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import PlayState;

using StringTools;

class Strumline extends FlxSprite
{
	public static var babyArrow:FlxSprite;
	var daData:Int;
	var players:Int;

	public function new(x:Float, y:Float, noteData:Int, player:Int)
	{
		super(x, y);

		daData = noteData;
		players = player;

		switch (PlayState.curNoteType)
		{
			case 'pixel':
			loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels'), true, 17, 17);
			animation.add('green', [6]);
			animation.add('red', [7]);
			animation.add('blue', [5]);
			animation.add('purplel', [4]);

			setGraphicSize(Std.int(width * PlayState.daPixelZoom));
			updateHitbox();
			antialiasing = false;

			switch (Math.abs(noteData))
			{
				case 0:
					x += Note.swagWidth * 0;
					animation.add('static', [0]);
					animation.add('pressed', [4, 8], 12, false);
					animation.add('confirm', [12, 16], 24, false);
				case 1:
					x += Note.swagWidth * 1;
					animation.add('static', [1]);
					animation.add('pressed', [5, 9], 12, false);
					animation.add('confirm', [13, 17], 24, false);
				case 2:
					x += Note.swagWidth * 2;
					animation.add('static', [2]);
					animation.add('pressed', [6, 10], 12, false);
					animation.add('confirm', [14, 18], 12, false);
				case 3:
					x += Note.swagWidth * 3;
					animation.add('static', [3]);
					animation.add('pressed', [7, 11], 12, false);
					animation.add('confirm', [15, 19], 24, false);
			}

			default:
			frames = Paths.getSparrowAtlas('NOTE_assets');
			animation.addByPrefix('green', 'arrowUP');
			animation.addByPrefix('blue', 'arrowDOWN');
			animation.addByPrefix('purple', 'arrowLEFT');
			animation.addByPrefix('red', 'arrowRIGHT');

			antialiasing = OptionHandler.aliasing;
			setGraphicSize(Std.int(width * 0.7));

			switch (Math.abs(noteData))
			{
				case 0:
					x += Note.swagWidth * 0;
					animation.addByPrefix('static', 'arrowLEFT');
					animation.addByPrefix('pressed', 'left press', 24, false);
					animation.addByPrefix('confirm', 'left confirm', 24, false);
				case 1:
					x += Note.swagWidth * 1;
					animation.addByPrefix('static', 'arrowDOWN');
					animation.addByPrefix('pressed', 'down press', 24, false);
					animation.addByPrefix('confirm', 'down confirm', 24, false);
				case 2:
					x += Note.swagWidth * 2;
					animation.addByPrefix('static', 'arrowUP');
					animation.addByPrefix('pressed', 'up press', 24, false);
					animation.addByPrefix('confirm', 'up confirm', 24, false);
				case 3:
					x += Note.swagWidth * 3;
					animation.addByPrefix('static', 'arrowRIGHT');
					animation.addByPrefix('pressed', 'right press', 24, false);
					animation.addByPrefix('confirm', 'right confirm', 24, false);
			}
		}

		updateHitbox();
		scrollFactor.set();
	}

	public function postAddedToGroup() {
		animation.play('static');
		x += Note.swagWidth * daData;
		x += 50;
		x += ((FlxG.width / 2) * players);
		ID = daData;
	}

	override public function update(elapsed:Float)
	{
		if (animation.curAnim.name == 'confirm')
			alpha = 1;
		else
			alpha = OptionHandler.strumAlpha;

		if (animation.finished)
		{
			animation.play('static');
			centerOffsets();
			offset.x -= 13;
			offset.y -= 13;
		}
		super.update(elapsed);
	}
}
