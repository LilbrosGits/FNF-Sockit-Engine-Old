package flixel.system.ui;

#if FLX_SOUND_SYSTEM
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flixel.FlxG;
import flixel.system.FlxAssets;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
#if flash
import flash.text.AntiAliasType;
import flash.text.GridFitType;
#end

/**
 * The flixel sound tray, the little volume meter that pops down sometimes.
 */
class FlxSoundTray extends Sprite
{
	/**
	 * Because reading any data from DisplayObject is insanely expensive in hxcpp, keep track of whether we need to update it or not.
	 */
	public var active:Bool;

	/**
	 * How wide the sound tray background is.
	 */
	var _width:Int = 80;

	var _defaultScale:Float = 2.0;

	/**
	 * Sets up the "sound tray", the little volume meter that pops down sometimes.
	 */
	@:keep
	public function new()
	{
		super();
	}

	/**
	 * This function just updates the soundtray object.
	 */
	public function update(MS:Float):Void
	{
		// Save sound preferences
		FlxG.save.data.mute = FlxG.sound.muted;
		FlxG.save.data.volume = FlxG.sound.volume;
		FlxG.save.flush();
	}

	/**
	 * Makes the little volume tray slide out.
	 *
	 * @param	Silent	Whether or not it should beep.
	 */
	public function show(Silent:Bool = false):Void
	{
		if (!Silent)
		{
			var sound = Paths.sound("scrollMenu");
			if (sound != null)
				FlxG.sound.load(sound).play();
		}
		var globalVolume:Int = Math.round(FlxG.sound.volume * 10);

		if (FlxG.sound.muted)
		{
			globalVolume = 0;
		}
	}

    public function screenCenter():Void //FUCK FLXGAME
    {
        scaleX = _defaultScale;
        scaleY = _defaultScale;

        x = (0.5 * (Lib.current.stage.stageWidth - _width * _defaultScale) - FlxG.game.x);
    }
}
#end