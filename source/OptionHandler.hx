package;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

class OptionHandler {
	public static var aliasing:Bool = true;
	public static var safeFrames:Float = 10;
	public static var gameFps:Int = 60;
	public static var ghost:Bool = true;
	public static var downScroll:Bool = false;
	public static var autoplay:Bool = false;
	public static var splashes:Bool = true;
	public static var strumAlpha:Float = 1;

	public static function saveSettings()  {
		FlxG.save.data.aliasing = aliasing;
		FlxG.save.data.frames = safeFrames;
		FlxG.save.data.fps = gameFps;
		FlxG.save.data.ghost = ghost;
		FlxG.save.data.downScroll = downScroll;
		FlxG.save.data.autoplay = autoplay;
		FlxG.save.data.noteSplashes = splashes;
		FlxG.save.data.strumAlpha = strumAlpha;
		
		FlxG.save.flush();
	}

	public static function loadPrefs() {
		if(FlxG.save.data.downScroll != null) {
			downScroll = FlxG.save.data.downScroll;
		}
		if(FlxG.save.data.autoplay != null) {
			autoplay = FlxG.save.data.autoplay;
		}
		if(FlxG.save.data.aliasing != null) {
			aliasing = FlxG.save.data.aliasing;
		}
		if(FlxG.save.data.frames != null) {
			safeFrames = FlxG.save.data.frames;
		}
		if(FlxG.save.data.fps != null) {
			gameFps = FlxG.save.data.fps;
			if(gameFps > FlxG.drawFramerate) {
				FlxG.updateFramerate = gameFps;
				FlxG.drawFramerate = gameFps;
			} else {
				FlxG.drawFramerate = gameFps;
				FlxG.updateFramerate = gameFps;
			}
		}
		if(FlxG.save.data.ghost != null) {
			ghost = FlxG.save.data.ghost;
		}
		if(FlxG.save.data.noteSplashes != null) {
			splashes = FlxG.save.data.noteSplashes;
		}
		if(FlxG.save.data.strumAlpha != null) {
			strumAlpha = FlxG.save.data.strumAlpha;
		}
	}
}
