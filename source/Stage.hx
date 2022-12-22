package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.tweens.FlxTween;

class Stage extends MusicBeatSubstate
{
	var halloweenBG:FlxSprite;
    var limo:FlxSprite;
	var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;
	var fastCar:FlxSprite;
    var upperBoppers:FlxSprite;
	var bottomBoppers:FlxSprite;
	var santa:FlxSprite;
	public static var bgGirls:BackgroundGirls;
	var wiggleShit:WiggleEffect = new WiggleEffect();
    var phillyCityLights:FlxTypedGroup<FlxSprite>;
    var curLight:Int = 0;
    var fastCarCanDrive:Bool = true;
    var phillyTrain:FlxSprite;
	var trainSound:FlxSound;
    var trainMoving:Bool = false;
	var trainFrameTiming:Float = 0;
	var trainCars:Int = 8;
	var trainFinishing:Bool = false;
	var trainCooldown:Int = 0;
    var daStage:String;
    var startedMoving:Bool = false;

    public function new(stage:String)
    {
        super();

        daStage = stage;

        switch(daStage)
        {
            case 'spooky':
            {
                var hallowTex = Paths.getSparrowAtlas('backgrounds/$stage/halloween_bg');
    
                halloweenBG = new FlxSprite(-200, -100);
                halloweenBG.frames = hallowTex;
                halloweenBG.animation.addByPrefix('idle', 'halloweem bg');
                halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
                halloweenBG.animation.play('idle');
                halloweenBG.antialiasing = OptionHandler.aliasing;
                add(halloweenBG);
            }
            case 'philly':
            {
                var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('backgrounds/' + stage + '/sky'));
                bg.scrollFactor.set(0.1, 0.1);
                add(bg);
    
                var city:FlxSprite = new FlxSprite(-10).loadGraphic(Paths.image('backgrounds/' + stage + '/city'));
                city.scrollFactor.set(0.3, 0.3);
                city.setGraphicSize(Std.int(city.width * 0.85));
                city.updateHitbox();
                add(city);
    
                phillyCityLights = new FlxTypedGroup<FlxSprite>();
                add(phillyCityLights);
    
            for (i in 0...5)
            {
                var light:FlxSprite = new FlxSprite(city.x).loadGraphic(Paths.image('backgrounds/' + stage + '/win' + i));
                light.scrollFactor.set(0.3, 0.3);
                light.visible = false;
                light.setGraphicSize(Std.int(light.width * 0.85));
                light.updateHitbox();
                light.antialiasing = OptionHandler.aliasing;
                phillyCityLights.add(light);
            }
    
                var streetBehind:FlxSprite = new FlxSprite(-40, 50).loadGraphic(Paths.image('backgrounds/' + stage + '/behindTrain'));
                add(streetBehind);
    
                phillyTrain = new FlxSprite(2000, 360).loadGraphic(Paths.image('backgrounds/' + stage + '/train'));
                add(phillyTrain);
    
                trainSound = new FlxSound().loadEmbedded(Paths.sound('train_passes'));
                FlxG.sound.list.add(trainSound);
    
                // var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);
    
                var street:FlxSprite = new FlxSprite(-40, streetBehind.y).loadGraphic(Paths.image('backgrounds/' + stage + '/street'));
                add(street);
            }
            case 'limo':
            {
                PlayState.defaultCamZoom = 0.90;
    
                var skyBG:FlxSprite = new FlxSprite(-120, -50).loadGraphic(Paths.image('backgrounds/' + stage + '/limoSunset'));
                skyBG.scrollFactor.set(0.1, 0.1);
                add(skyBG);
    
                var bgLimo:FlxSprite = new FlxSprite(-200, 480);
                bgLimo.frames = Paths.getSparrowAtlas('backgrounds/' + stage + '/bgLimo');
                bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
                bgLimo.animation.play('drive');
                bgLimo.scrollFactor.set(0.4, 0.4);
                add(bgLimo);
    
                grpLimoDancers = new FlxTypedGroup<BackgroundDancer>();
                add(grpLimoDancers);
    
                for (i in 0...5)
                {
                    var dancer:BackgroundDancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
                    dancer.scrollFactor.set(0.4, 0.4);
                    grpLimoDancers.add(dancer);
                }
    
                var overlayShit:FlxSprite = new FlxSprite(-500, -600).loadGraphic(Paths.image('backgrounds/' + stage + '/limoOverlay'));
                overlayShit.alpha = 0.5;
    
                var limoTex = Paths.getSparrowAtlas('backgrounds/' + stage + '/limoDrive');
    
                limo = new FlxSprite(-120, 550);
                limo.frames = limoTex;
                limo.animation.addByPrefix('drive', "Limo stage", 24);
                limo.animation.play('drive');
                limo.antialiasing = OptionHandler.aliasing;
    
                fastCar = new FlxSprite(-300, 160).loadGraphic(Paths.image('backgrounds/' + stage + '/fastCarLol'));
                add(fastCar);
    
                add(limo);
    
                PlayState.boyfriend.y -= 220;
                PlayState.boyfriend.x += 260;
                }
                case 'mall':
                {
                    PlayState.defaultCamZoom = 0.80;
    
                    var bg:FlxSprite = new FlxSprite(-1000, -500).loadGraphic(Paths.image('backgrounds/' + stage + '/bgWalls'));
                    bg.antialiasing = OptionHandler.aliasing;
                    bg.scrollFactor.set(0.2, 0.2);
                    bg.active = false;
                    bg.setGraphicSize(Std.int(bg.width * 0.8));
                    bg.updateHitbox();
                    add(bg);
    
                    upperBoppers = new FlxSprite(-240, -90);
                    upperBoppers.frames = Paths.getSparrowAtlas('backgrounds/' + stage + '/upperBop');
                    upperBoppers.animation.addByPrefix('bop', "Upper Crowd Bob", 24, false);
                    upperBoppers.antialiasing = OptionHandler.aliasing;
                    upperBoppers.scrollFactor.set(0.33, 0.33);
                    upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 0.85));
                    upperBoppers.updateHitbox();
                    add(upperBoppers);
    
                    var bgEscalator:FlxSprite = new FlxSprite(-1100, -600).loadGraphic(Paths.image('backgrounds/' + stage + '/bgEscalator'));
                    bgEscalator.antialiasing = OptionHandler.aliasing;
                    bgEscalator.scrollFactor.set(0.3, 0.3);
                    bgEscalator.active = false;
                    bgEscalator.setGraphicSize(Std.int(bgEscalator.width * 0.9));
                    bgEscalator.updateHitbox();
                    add(bgEscalator);
    
                    var tree:FlxSprite = new FlxSprite(370, -250).loadGraphic(Paths.image('backgrounds/' + stage + '/christmasTree'));
                    tree.antialiasing = OptionHandler.aliasing;
                    tree.scrollFactor.set(0.40, 0.40);
                    add(tree);
    
                    bottomBoppers = new FlxSprite(-300, 140);
                    bottomBoppers.frames = Paths.getSparrowAtlas('backgrounds/' + stage + '/bottomBop');
                    bottomBoppers.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
                    bottomBoppers.antialiasing = OptionHandler.aliasing;
                    bottomBoppers.scrollFactor.set(0.9, 0.9);
                    bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
                    bottomBoppers.updateHitbox();
                    add(bottomBoppers);
    
                    var fgSnow:FlxSprite = new FlxSprite(-600, 700).loadGraphic(Paths.image('backgrounds/' + stage + '/fgSnow'));
                    fgSnow.active = false;
                    fgSnow.antialiasing = OptionHandler.aliasing;
                    add(fgSnow);
    
                    santa = new FlxSprite(-840, 150);
                    santa.frames = Paths.getSparrowAtlas('backgrounds/' + stage + '/santa');
                    santa.animation.addByPrefix('idle', 'santa idle in fear', 24, false);
                    santa.antialiasing = OptionHandler.aliasing;
                    add(santa);
    
                    PlayState.boyfriend.x += 200;
                }
                case 'mallEvil':
                {
                    var bg:FlxSprite = new FlxSprite(-400, -500).loadGraphic(Paths.image('backgrounds/' + stage + '/evilBG'));
                    bg.antialiasing = OptionHandler.aliasing;
                    bg.scrollFactor.set(0.2, 0.2);
                    bg.active = false;
                    bg.setGraphicSize(Std.int(bg.width * 0.8));
                    bg.updateHitbox();
                    add(bg);
    
                    var evilTree:FlxSprite = new FlxSprite(300, -300).loadGraphic(Paths.image('backgrounds/' + stage + '/evilTree'));
                    evilTree.antialiasing = OptionHandler.aliasing;
                    evilTree.scrollFactor.set(0.2, 0.2);
                    add(evilTree);
    
                    var evilSnow:FlxSprite = new FlxSprite(-200, 700).loadGraphic(Paths.image('backgrounds/' + stage + "/evilSnow"));
                    evilSnow.antialiasing = OptionHandler.aliasing;
                    add(evilSnow);
    
                    PlayState.boyfriend.x += 320;
                    PlayState.dad.y -= 80;
                }
                case 'school':
                {
                    var bgSky = new FlxSprite().loadGraphic(Paths.image('backgrounds/' + stage + '/weebSky'));
                    bgSky.scrollFactor.set(0.1, 0.1);
                    add(bgSky);
    
                    var repositionShit = -200;
    
                    var bgSchool:FlxSprite = new FlxSprite(repositionShit, 0).loadGraphic(Paths.image('backgrounds/' + stage + '/weebSchool'));
                    bgSchool.scrollFactor.set(0.6, 0.90);
                    add(bgSchool);
    
                    var bgStreet:FlxSprite = new FlxSprite(repositionShit).loadGraphic(Paths.image('backgrounds/' + stage + '/weebStreet'));
                    bgStreet.scrollFactor.set(0.95, 0.95);
                    add(bgStreet);
    
                    var fgTrees:FlxSprite = new FlxSprite(repositionShit + 170, 130).loadGraphic(Paths.image('backgrounds/' + stage + '/weebTreesBack'));
                    fgTrees.scrollFactor.set(0.9, 0.9);
                    add(fgTrees);
    
                    var bgTrees:FlxSprite = new FlxSprite(repositionShit - 380, -800);
                    var treetex = Paths.getPackerAtlas('backgrounds/' + stage + '/weebTrees');
                    bgTrees.frames = treetex;
                    bgTrees.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
                    bgTrees.animation.play('treeLoop');
                    bgTrees.scrollFactor.set(0.85, 0.85);
                    add(bgTrees);
    
                    var treeLeaves:FlxSprite = new FlxSprite(repositionShit, -40);
                    treeLeaves.frames = Paths.getSparrowAtlas('backgrounds/' + stage + '/petals');
                    treeLeaves.animation.addByPrefix('leaves', 'PETALS ALL', 24, true);
                    treeLeaves.animation.play('leaves');
                    treeLeaves.scrollFactor.set(0.85, 0.85);
                    add(treeLeaves);
    
                    var widShit = Std.int(bgSky.width * 6);
    
                    bgSky.setGraphicSize(widShit);
                    bgSchool.setGraphicSize(widShit);
                    bgStreet.setGraphicSize(widShit);
                    bgTrees.setGraphicSize(Std.int(widShit * 1.4));
                    fgTrees.setGraphicSize(Std.int(widShit * 0.8));
                    treeLeaves.setGraphicSize(widShit);
    
                    fgTrees.updateHitbox();
                    bgSky.updateHitbox();
                    bgSchool.updateHitbox();
                    bgStreet.updateHitbox();
                    bgTrees.updateHitbox();
                    treeLeaves.updateHitbox();
    
                    bgGirls = new BackgroundGirls(-100, 190);
                    bgGirls.scrollFactor.set(0.9, 0.9);
    
                    bgGirls.setGraphicSize(Std.int(bgGirls.width * PlayState.daPixelZoom));
                    bgGirls.updateHitbox();
                    add(bgGirls);
    
                    PlayState.boyfriend.x += 200;
                    PlayState.boyfriend.y += 220;
                    PlayState.gf.x += 180;
                    PlayState.gf.y += 300;
                }
                case 'schoolEvil':
                {
                    var waveEffectBG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 3, 2);
                    var waveEffectFG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 5, 2);
    
                    var posX = 400;
                    var posY = 200;
    
                    var bg:FlxSprite = new FlxSprite(posX, posY);
                    bg.frames = Paths.getSparrowAtlas('backgrounds/' + stage + '/animatedEvilSchool');
                    bg.animation.addByPrefix('idle', 'background 2', 24);
                    bg.animation.play('idle');
                    bg.scrollFactor.set(0.8, 0.9);
                    bg.scale.set(6, 6);
                    add(bg);
    
                    PlayState.boyfriend.x += 200;
                    PlayState.boyfriend.y += 220;
                    PlayState.gf.x += 180;
                    PlayState.gf.y += 300;
                }
                case 'stage':
                {
                    PlayState.defaultCamZoom = 0.9;
                    var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('backgrounds/' + stage + '/stageback'));
                    bg.antialiasing = OptionHandler.aliasing;
                    bg.scrollFactor.set(0.9, 0.9);
                    bg.active = false;
                    add(bg);
    
                    var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('backgrounds/' + stage + '/stagefront'));
                    stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
                    stageFront.updateHitbox();
                    stageFront.antialiasing = OptionHandler.aliasing;
                    stageFront.scrollFactor.set(0.9, 0.9);
                    stageFront.active = false;
                    add(stageFront);
    
                    var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('backgrounds/' + stage + '/stagecurtains'));
                    stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
                    stageCurtains.updateHitbox();
                    stageCurtains.antialiasing = OptionHandler.aliasing;
                    stageCurtains.scrollFactor.set(1.3, 1.3);
                    stageCurtains.active = false;
    
                    add(stageCurtains);
                }
            }
        }

                
        public function stageUpdate(curBeat:Int, boyfriend:Boyfriend, gf:Character, dadOpponent:Character)
            {
                // trace('update backgrounds');
                switch (PlayState.curStage)
                {
                    case 'highway':
                        // trace('highway update');
                        grpLimoDancers.forEach(function(dancer:BackgroundDancer)
                        {
                            dancer.dance();
                        });
                    case 'mall':
                        upperBoppers.animation.play('bop', true);
                        bottomBoppers.animation.play('bop', true);
                        santa.animation.play('idle', true);
        
                    case 'school':
                        bgGirls.dance();
        
                    case 'philly':
                        if (!trainMoving)
                            trainCooldown += 1;
        
                        if (curBeat % 4 == 0)
                        {
                            var lastLight:FlxSprite = phillyCityLights.members[0];
        
                            phillyCityLights.forEach(function(light:FlxSprite)
                            {
                                // Take note of the previous light
                                if (light.visible == true)
                                    lastLight = light;
        
                                light.visible = false;
                            });
        
                            // To prevent duplicate lights, iterate until you get a matching light
                            while (lastLight == phillyCityLights.members[curLight])
                            {
                                curLight = FlxG.random.int(0, phillyCityLights.length - 1);
                            }
        
                            phillyCityLights.members[curLight].visible = true;
                            phillyCityLights.members[curLight].alpha = 1;
        
                            FlxTween.tween(phillyCityLights.members[curLight], {alpha: 0}, Conductor.stepCrochet * .016);
                        }
        
                        if (curBeat % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8)
                        {
                            trainCooldown = FlxG.random.int(-4, 0);
                            trainStart();
                        }
                }
            }
        
            public function stageUpdateConstant(elapsed:Float, boyfriend:Boyfriend, gf:Character, dadOpponent:Character)
            {
                switch (PlayState.curStage)
                {
                    case 'philly':
                        if (trainMoving)
                        {
                            trainFrameTiming += elapsed;
        
                            if (trainFrameTiming >= 1 / 24)
                            {
                                updateTrainPos(gf);
                                trainFrameTiming = 0;
                            }
                        }
                }
            }
        
            // PHILLY STUFFS!
            function trainStart():Void
            {
                trainMoving = true;
                if (!trainSound.playing)
                    trainSound.play(true);
            }
        
            function updateTrainPos(gf:Character):Void
            {
                if (trainSound.time >= 4700)
                {
                    startedMoving = true;
                    gf.playAnim('hairBlow');
                }
        
                if (startedMoving)
                {
                    phillyTrain.x -= 400;
        
                    if (phillyTrain.x < -2000 && !trainFinishing)
                    {
                        phillyTrain.x = -1150;
                        trainCars -= 1;
        
                        if (trainCars <= 0)
                            trainFinishing = true;
                    }
        
                    if (phillyTrain.x < -4000 && trainFinishing)
                        trainReset(gf);
                }
            }
        
            function trainReset(gf:Character):Void
            {
                gf.playAnim('hairFall');
                phillyTrain.x = FlxG.width + 200;
                trainMoving = false;
                // trainSound.stop();
                // trainSound.time = 0;
                trainCars = 8;
                trainFinishing = false;
                startedMoving = false;
            }
        

}