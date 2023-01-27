package;

import flixel.FlxSprite;
import flixel.FlxBasic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import haxe.Json;
import openfl.utils.Assets as Assets;
#if sys
import sys.FileSystem;
import sys.io.File;
#end

typedef StageShit =
{
    image:String,
    anim:String,
    layer:Int,
    scrollFactor:Float,
    alpha:Float,
    angle:Int
}

typedef StageData =
{
    stage:String,
    defaultCamZoom:Float,
    boyfriendPositions:Array<Float>,
    girlfriendPositions:Array<Float>,
    dadPositions:Array<Float>,
    gf_visible:Bool,
    data:StageShit
}

class StageEditor extends FlxTypedGroup<FlxBasic>
{
    var stageJSON:StageData;

    var curImg:Int = 0;

    var defPath:String = 'backgrounds/';

    public function new(stageName:String) //SPAGHETTI CODE INCOMING!!1!
    {
        super();
        stageJSON = Json.parse(Paths.getTextFromFile('images/backgrounds/' + stageName + '/' + stageName + '.json'));

        stageName = stageJSON.stage;

        if (Assets.exists(Paths.getPath('images/backgrounds/' + stageName + '/' + stageJSON.data.image + '.xml')))
            addSparrowSprite(defPath + stageName + stageJSON.data.image);
        else if (Assets.exists(Paths.getPath('images/backgrounds/' + stageName + '/' + stageJSON.data.image + '.txt')))
            addPackerSprite(defPath + stageName + stageJSON.data.image);
        else
            addImgSprite(defPath + stageName + stageJSON.data.image);
    }

    function addImgSprite(daPath:String)
    {
        var sprite:FlxSprite = new FlxSprite().loadGraphic(Paths.image(daPath));
        add(sprite);
    }

    function addSparrowSprite(daPath:String)
    {
        var tex:FlxAtlasFrames = Paths.getSparrowAtlas(daPath);
        var sparrowSprite:FlxSprite = new FlxSprite().loadGraphic(Paths.image(daPath));
        sparrowSprite.frames = tex;
        add(sparrowSprite);
    }

    function addPackerSprite(daPath:String)
    {
        var tex:FlxAtlasFrames = Paths.getPackerAtlas(daPath);
        var packerSprite:FlxSprite = new FlxSprite().loadGraphic(Paths.image(daPath));
        packerSprite.frames = tex;
        add(packerSprite);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}