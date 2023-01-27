package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class GameplaySettingsSubState extends OptionsState
{
	public function new()
	{
		var option:Option = new Option('Downscroll',
		'If checked, notes go Down instead of Up, simple enough.',
		'downScroll',
		'bool',
		false);
		
		addOption(option);
		var option:Option = new Option('Ghost Tapping',
		'the ability to only miss notes that can\'t be hit',
		'ghost',
		'bool',
		true);
		addOption(option);

		var option:Option = new Option('Botplay',
		'CHEATER',
		'autoplay',
		'bool',
		false);
		addOption(option);

		var option:Option = new Option('Instant Respawns',
		'Instantly respawning after death',
		'instRespawn',
		'bool',
		true);
		addOption(option);

		var option:Option = new Option('Safe Frames',
		'Changes how many frames you have for\nhitting a note earlier or late.',
		'safeFrames',
		'float',
		10);
		option.scrollSpeed = 5;
		option.minValue = 1;
		option.maxValue = 20;
		option.changeValue = 0.1;
		addOption(option);

		var option:Option = new Option('FPS',
		'Changes how many fps you run at.',
		'gameFps',
		'int',
		120);
		option.minValue = 60;
		option.maxValue = 240;
		option.displayFormat = '%v FPS';
		option.onChange = onChangeFramerate;
		addOption(option);

		super();
	}

	function onChangeFramerate()
	{
		if(OptionHandler.gameFps > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = OptionHandler.gameFps;
			FlxG.drawFramerate = OptionHandler.gameFps;
		}
		else
		{
			FlxG.drawFramerate = OptionHandler.gameFps;
			FlxG.updateFramerate = OptionHandler.gameFps;
		}
	}
}