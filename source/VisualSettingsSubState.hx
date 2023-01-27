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

class VisualSettingsSubState extends OptionsState
{
	public function new()
	{
		var option:Option = new Option('Anti-Aliasing',
		'Way better preformance with less good visuals.',
		'aliasing',
		'bool',
		false);
		addOption(option);

		var option:Option = new Option('Note Splashes',
		'Makes the notes splash whenever you get a SICK rating.',
		'splashes',
		'bool',
		true);
		addOption(option);

		var option:Option = new Option('Strumline Alpha',
		'Changes the opacity of the Strumline',
		'strumAlpha',
		'float',
		100);
		option.minValue = 0.1;
		option.maxValue = 1;
		option.changeValue = 0.1;
		addOption(option);

		var option:Option = new Option('Optimizational Features', //Name
		'Makes The Game Run Better By Removing Certain Features', //Description
		'optimized',
		'bool',
		true);
		addOption(option);

		var option:Option = new Option('Strumline Lane Alpha',
		'If the alpha is greater than 0 you \nwill have a strumline lane',
		'strumLaneAlpha',
		'float',
		100);
		option.minValue = 0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		addOption(option);

		/*var option:Option = new Option('Score Bar Layout',
		"How will the score bar look?",
		'pauseMusic',
		'string',
		'Tea Time',
		['None', 'Breakfast', 'Tea Time']);
		addOption(option);*/

		super();
	}
}