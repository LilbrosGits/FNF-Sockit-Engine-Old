package;

import haxe.CallStack;
import Conductor.BPMChangeEvent;
import ChartParser.SwagSection;
import Song.SwagSong;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import openfl.Lib;
import openfl.events.UncaughtErrorEvent;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUITooltip.FlxUITooltipStyle;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import haxe.Json;
import openfl.utils.Assets as OpenFlAssets;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.media.Sound;
import openfl.net.FileReference;
import openfl.utils.ByteArray;
import sys.io.File;
import sys.FileSystem;

using StringTools;

class AnimDebugger extends MusicBeatState
{
	var characterBoxShit:FlxUITabMenu;
	var character:Character;
	var curCharacter:String;

	override public function create()
	{
		if (FlxG.sound.music != null)
		{
			FlxG.sound.music.stop();
		}

		FlxG.mouse.visible = true;

		var categories = [
			{name: "Character", label: 'Character'},
			{name: "Other", label: 'Other'}
		];

		characterBoxShit = new FlxUITabMenu(null, categories, true);

		characterBoxShit.resize(300, 300);
		characterBoxShit.x = 50;
		characterBoxShit.y = 20;
		add(characterBoxShit);

		reloadCharacter('bf');

		addCharacterUI();

		super.create();
	}

	function reloadCharacter(newCharacter:String)
	{
		remove(character);
		character = new Character(0, 0, newCharacter);
		character.screenCenter();
		add(character);
	}

	function addCharacterUI():Void
	{
		var characters:Array<String> = CoolUtil.coolTextFile(Paths.txt('characterList'));

		var characterDropDown = new FlxUIDropDownMenu(10, 100, FlxUIDropDownMenu.makeStrIdLabelArray(characters, true), function(character:String)
		{
			reloadCharacter(characters[Std.parseInt(character)]);
		});

		var flipXCheck = new FlxUICheckBox(10, characterDropDown.y + 50, null, null, "Flip Horizontally", 100);
		flipXCheck.checked = character.flipX;
		flipXCheck.callback = function()
		{
			character.flipX = flipXCheck.checked;
		};

		var flipYCheck = new FlxUICheckBox(10, flipXCheck.y + 30, null, null, "Flip Vertically", 100);
		flipYCheck.checked = character.flipY;
		flipYCheck.callback = function()
		{
			character.flipY = flipXCheck.checked;
		};

		var angleStepper:FlxUINumericStepper = new FlxUINumericStepper(10, flipYCheck.y + 20, 10, 1, 0, 360, 0);
		angleStepper.value = character.angle;
		angleStepper.name = 'angle';

		var scaleStepper:FlxUINumericStepper = new FlxUINumericStepper(10, angleStepper.y + 20, 0.1, 1, 0, 360, 1);
		scaleStepper.value = 1;
		scaleStepper.name = 'scale';

		var tab_group_character = new FlxUI(null, characterBoxShit);
		tab_group_character.name = "Character";

		tab_group_character.add(characterDropDown);
		tab_group_character.add(flipXCheck);
		tab_group_character.add(flipYCheck);
		tab_group_character.add(angleStepper);
		tab_group_character.add(scaleStepper);

		characterBoxShit.addGroup(tab_group_character);
	}

	override function getEvent(id:String, sender:Dynamic, data:Dynamic, ?params:Array<Dynamic>)
	{
		if (id == FlxUICheckBox.CLICK_EVENT)
		{
			var check:FlxUICheckBox = cast sender;
			var label = check.getLabel().text;
			switch (label)
			{
				case 'Flip Horizontally':
					character.flipX = check.checked;

				case 'Flip Vertically':
					character.flipY = check.checked;
			}
		}
		else if (id == FlxUINumericStepper.CHANGE_EVENT && (sender is FlxUINumericStepper))
		{
			var nums:FlxUINumericStepper = cast sender;
			var wname = nums.name;
			FlxG.log.add(wname);
			if (wname == 'angle')
			{
				character.angle = nums.value;
			}
			else if (wname == 'scale')
			{
				character.scale.x = nums.value;
				character.scale.y = nums.value;
			}
		}
	}

	override public function update(elapsed:Float)
	{
		var startMousePos:FlxPoint = new FlxPoint();

		if (FlxG.mouse.overlaps(character) && FlxG.mouse.pressed)
		{
			var mousePos:FlxPoint = FlxG.mouse.getScreenPosition();

			character.x = Math.round((mousePos.x - startMousePos.x) + character.x);
			character.y = -Math.round((mousePos.y - startMousePos.y) - character.y);
		}

		super.update(elapsed);
	}
}