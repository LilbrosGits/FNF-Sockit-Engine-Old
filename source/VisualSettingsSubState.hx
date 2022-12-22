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
		//I'd suggest using "Downscroll" as an example for making your own option since it is the simplest here
		var option:Option = new Option('Anti-Aliasing', //Name
		'Way better preformance with less good visuals.', //Description
		'aliasing', //Save data variable name
		'bool', //Variable type
		false); //Default value
		addOption(option);

		//I'd suggest using "Downscroll" as an example for making your own option since it is the simplest here
		var option:Option = new Option('Note Splashes', //Name
		'Makes the notes splash whenever you get a SICK rating.', //Description
		'splashes', //Save data variable name
		'bool', //Variable type
		true); //Default value
		addOption(option);

		//I'd suggest using "Downscroll" as an example for making your own option since it is the simplest here
		var option:Option = new Option('Strumline Alpha', //Name
		'Changes the opacity of the Strumline', //Description
		'strumAlpha', //Save data variable name
		'float', //Variable type
		100); //Default value
		option.minValue = 0.1;
		option.maxValue = 1;
		option.changeValue = 0.1;
		addOption(option);

		/*var option:Option = new Option('Shaders', //Name
		'Use Shaders to Increase the Cool Looks! at the cost of fps tho.', //Description
		'shaders', //Save data variable name
		'bool', //Variable type
		false); //Default value
		addOption(option);*/

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