package;

import ChartParser.SwagSection;
import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;

#if sys
import sys.io.File;
import sys.FileSystem;
#end

using StringTools;

typedef SwagSong =
{
	var song:String;
	var stage:String;
	var noteTypes:String;
	var notes:Array<SwagSection>;
	var bpm:Int;
	var needsVoices:Bool;
	var speed:Float;
	var gfVersion:String;
	var player1:String;
	var player2:String;
	var validScore:Bool;
}

class Song
{
	public var song:String;
	public var notes:Array<SwagSection>;
	public var stage:String = 'stage';
	public var noteTypes:String = 'default';
	public var bpm:Int;
	public var needsVoices:Bool = true;
	public var speed:Float = 1;
	public var gfVersion:String = 'gf';
	public var player1:String = 'bf';
	public var player2:String = 'dad';

	public function new(song, notes, bpm)
	{
		this.song = song;
		this.notes = notes;
		this.bpm = bpm;
	}

	public static function loadFromJson(folder:String, difficulty:String):SwagSong
	{
		var rawJson = null;

		if(rawJson == null) {
			#if sys
			rawJson = File.getContent(Paths.json(folder + '/' + difficulty)).trim();
			#else
			rawJson = Assets.getText(Paths.json(folder + '/' + difficulty)).trim();
			#end
		}

		while (!rawJson.endsWith("}"))
		{
			rawJson = rawJson.substr(0, rawJson.length - 1);
		}

		var songJson:Dynamic = parseJSONshit(rawJson);
		return songJson;
	}

	public static function parseJSONshit(rawJson:String):SwagSong
	{
		var swagShit:SwagSong = cast Json.parse(rawJson).song;
		swagShit.validScore = true;
		return swagShit;
	}
}
