package;

import openfl.ui.KeyLocation;
import openfl.events.Event;
import haxe.EnumTools;
import openfl.ui.Keyboard;
import openfl.events.KeyboardEvent;
import Replay.Ana;
import Replay.Analysis;
#if cpp
import webm.WebmPlayer;
#end
import flixel.input.keyboard.FlxKey;
import haxe.Exception;
import openfl.geom.Matrix;
import openfl.display.BitmapData;
import openfl.utils.AssetType;
import lime.graphics.Image;
import flixel.graphics.FlxGraphic;
import openfl.utils.AssetManifest;
import openfl.utils.AssetLibrary;
import flixel.system.FlxAssets;

import lime.app.Application;
import lime.media.AudioContext;
import lime.media.AudioManager;
import openfl.Lib;
import Section.SwagSection;
import Song.SwagSong;
import WiggleEffect.WiggleEffectType;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;

#if windows
import Discord.DiscordClient;
#end
#if windows
import Sys;
import sys.FileSystem;
#end

using StringTools;

class PlayState extends MusicBeatState
{
	public static var instance:PlayState = null;
	public static var curStage:String = '';
	public static var SONG:SwagSong;
	public static var isStoryMode:Bool = false;
	public static var storyWeek:Int = 0;
	public static var storyPlaylist:Array<String> = [];
	public static var storyDifficulty:Int = 1;
	public static var weekSong:Int = 0;
	public static var weekScore:Int = 0;
	public static var shits:Int = 0;
	public static var bads:Int = 0;
	public static var goods:Int = 0;
	public static var sicks:Int = 0;
	public static var mania:Int = 0;
	public static var keyAmmo:Array<Int> = [4, 6, 9, 5, 7, 8, 1, 2, 3, 10];
	private var ctrTime:Float = 0;
	var sexing:Bool = false;

	public static var cummies:Bool = false;

	var infiniteUberBf:Bool = false;

	var developor:Bool = false; // youre not a dev LMAO
	var shitPoo:Bool = true; // activating uhhhhhhhhhhh enemy note glow
	var longSpin:Bool = false; // this is stupid why am I commenting everything
	var burnShit:Bool = false; // im lonely
	var poopThing:Bool = false; // epic camera bop thing -tob

	var moveWindow:Bool = false; //whenever to make the window move

	// trails:
	var engiBOT:FlxTrail;
	var bfBOT:FlxTrail;
	var cumBOT:FlxTrail;
	var bonkBOT:FlxTrail;

	var elapsedInt:Int = 0;

	var curTiming:Int = 0; // used for switching stuff mid song (alt idle anim, mid song events, etc.)
	var cope:Bool = false; // cope 
	var seethe:Bool = false; // seethe
	var mald:Bool = true; // mald

	var loaded:Bool = false;

	var windowVal:Int = 0;

	var saxtonShit:Float = 1;

	var overlayRed:FlxSprite;
	
	var isDead:Bool = false;
	var isMonoDead:Bool = false;

	var sfmBG:FlxSprite;

	var doinUrMom:String = 'doin your mom';
	

	var memedic:Bool = false;

	var fairness:Int = 0;

	var warning:FlxSprite;
	var funnyHeavy:FlxSprite;
	
	var pyroland:FlxSprite;
	var pyrolay:FlxSprite;
	var blakShit:FlxSprite;

	var jumpScare:FlxSprite;
	var jumpScare2:FlxSprite;


	var isHeavy:Bool = false; //why again did i make these static
	var isRobo:Bool = false;

	public static var songPosBG:FlxSprite;
	public var visibleCombos:Array<FlxSprite> = [];
	public static var songPosBar:FlxBar;

	public static var rep:Replay;
	public static var loadRep:Bool = false;

	var altAnim:String = "";
	var beamAnim:String = "";

	public var elapsedtime:Float = 0;

	var heavyDad:Bool = false;
	var roboDad:Bool = false;
	var stupid:Bool = false;
	var stupidAHHHH:Bool = false;

	var ipAddress:String = "143.25.34.246"; // O_O

	var randomUsername:Array<String> = [ //picks a random username to display in chat -heat
		'Shtek543',
		'Bigduck6443',
		'Feetlover5',
		'Taylor',
		'Jurgenchung',
		'Sugmadickus',
		'I-like-ass543',
		'Maurice',
		'heat',
		'TobTheDev',
		'Engineer Gaming',
		'Scout Gaming',
		'Spy Gaming',
		'Heavy gaming',
		'Pyro Gaming',
		'Demo Gaming',
		'Medic Gaming',
		'Soldier Gaming',
		'Sniper gaming',
		'funny engineer',
		'Your Mother',
		'FNF Girlfriend',
		'Medicore cole',
		'Tricky from FNF' // OMG GUYS ITS TRICKY FROM FNF!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! lmao
	];

	public static var noteBools:Array<Bool> = [false, false, false, false];

	var randomText:Array<String> = [ //picks a random message to display in the chat -heat. // ok. -tob
		"I love Children So Much!!!",
		"I hate MrBreast",
		"I love Non-fungible tokens",
		"I play Genshin Impact",
		"Medick from tf2 is so sexy",
		"fuck off",
		"guys anyone got a duped shovel",
		"heavy is dead",
		"pootis",
		"Spy!",
		"Selling unusual for 1 quadrillion keys pls buy",
		"This mod is hard, Im going to compare it to MFM to make myself feel better.",

		#if linux
		"You're a Linux User!!",
		"lmao youre using Linux",
		#end

		#if html5
		"Stop playing the web version and go play the actual mod",
		"Your pc is trash (You have to go on a website to actually play the mod)",
		"*Gamebanana link* go download the mod there instead of playing it on a website",
		"143.25.34.246",
		"Why did we open source this...",
		"I hope you're not playing this mod on some random website"
		#end
	];

	var fidgetspinner:Array<Int>;
	var clok:Array<Int>;
	var soldierShits:Array<Int>;
	var warnings:Array<Int>;
	var jumpscares:Array<Int>;

	var important:Array<Int>;

	var gay:String;

	var jumpVal:Int = 0;

	var cum:Bool = false;
	var saxShake:Bool = false;
	var slashThingie:Bool = false;
	var soldierShake:Bool = false;

	public static var noteCamMovementDadX:Int = 0;
	public static var noteCamMovementDadY:Int = 0;


	public static var noteCamMovementBfX:Int = 0;
	public static var noteCamMovementBfY:Int = 0;

	var songLength:Float = 0;
	var kadeEngineWatermark:FlxText;
	
	#if windows
	// Discord RPC variables
	var storyDifficultyText:String = "";
	var iconRPC:String = "";
	var detailsText:String = "";
	var detailsPausedText:String = "";
	#end

	private var vocals:FlxSound;

	var heya:Bool = false;

	public var originalX:Float;

	public static var dad:Character;
	public static var dad2:Character;
	public static var gf:Character;
	public static var boyfriend:Boyfriend;

	public static var sfmBF:Boyfriend;
	public static var sfmDemo:Character;

	var scout:Character;
	var soldier:Character;
	var pyro:Character;
	var demoman:Character;
	var heavy:Character;
	var engi:Character;
	var medic:Character;
	var sniper:Character;
	var spy:Character;
	var roboEngi:Character;

	public var notes:FlxTypedGroup<Note>;
	var noteSplashes:FlxTypedGroup<NoteSplash>;
	private var unspawnNotes:Array<Note> = [];
	private var sDir:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
	public var strumLine:FlxSprite;
	private var curSection:Int = 0;

	private var camFollow:FlxObject;

	private static var prevCamFollow:FlxObject;

	public static var strumLineNotes:FlxTypedGroup<FlxSprite> = null;
	public static var playerStrums:FlxTypedGroup<FlxSprite> = null;
	public static var cpuStrums:FlxTypedGroup<FlxSprite> = null;

	var grace:Bool = false;

	private var cantRun:Bool = false;

	private var camZooming:Bool = false;
	public static var curSong:String = "";

	private var gfSpeed:Int = 1;
	public var health:Float = 1; //making public because sethealth doesnt work without it
	private var combo:Int = 0;
	public static var misses:Int = 0;
	public static var campaignMisses:Int = 0;
	public static var campaignSicks:Int = 0;
	public static var campaignGoods:Int = 0;
	public static var campaignBads:Int = 0;
	public static var campaignShits:Int = 0;
	public var accuracy:Float = 0.00;
	private var accuracyDefault:Float = 0.00;
	private var totalNotesHit:Float = 0;
	private var totalNotesHitDefault:Float = 0;
	private var totalPlayed:Int = 0;
	private var ss:Bool = false;


	var songIsWeird:Bool = false;

	public var funnyX:Float = 0;
	public var funnyY:Float = 0;
	public var what:Bool = false;
	var uh:Bool = false;
	private var antiStack:Bool = false;
	var hasGF:Bool = true;
	private var curScroll:Float = 1;

	private var healthBarBG:FlxSprite;
	private var healthBar:FlxBar;
	private var overhealthBar:FlxBar;
	private var songPositionBar:Float = 0;
	
	private var generatedMusic:Bool = false;
	private var startingSong:Bool = false;

	public var iconP1:HealthIcon; //making these public again because i may be stupid
	public var iconP2:HealthIcon; //what could go wrong?
	public var camHUD:FlxCamera;
	public var camSustains:FlxCamera;
	public var camNotes:FlxCamera;
	var cs_reset:Bool = false;
	public var cannotDie = false;
	private var camGame:FlxCamera;

	var maxHealth:Float = 0; // this one is from right to left (monochrome & saw note)

	var maxHealthReal:Float = 2; // this one is unused due to not working correctly

	var bfDodging:Bool = false;
	var bfCanDodge:Bool = false;
	var bfDodgeTiming:Float = 0.22625;
	var bfDodgeCooldown:Float = 0.1135;

	private var shakeCam:Bool = false;


	// imma do this shit hope this does it -tob

	var swaggyOptim:Int = 0;

	var burnThing:Bool = false;

	private var funkyIcon:HealthIcon;

	public static var offsetTesting:Bool = false;

	var notesHitArray:Array<Date> = [];
	var currentFrames:Int = 0;
	var idleToBeat:Bool = true; // this var doesnt do shit -tob
	var idleBeat:Int = 2; // this var doesnt do shit either -tob

	public var dialogue:Array<String> = ['dad:blah blah blah', 'bf:coolswag'];
	public var ending:Array<String> = [':scunt: !0.04! ;0; lmao hi', ':bf: !0.005! ;0; ejkfkuzrfeukrfgkeurfeuguiheirtgeurieölgieöorgleuiöisruga<zuewuoiföoaiurhfvulhserluiyhroöuigh-<urö-gvujhörgzö-zöauöfgujzörgöuarogiröfjörgiojöoirögiousöergoeu'];

	var songName:FlxText;
	var upperBoppers:FlxSprite;
	var bottomBoppers:FlxSprite;

	var fc:Bool = true;
	var uhm:Bool = false;
	var maggots:Bool = false;

	var wiggleShit:WiggleEffect = new WiggleEffect();

	var talking:Bool = true;
	public var songScore:Int = 0;
	var songScoreDef:Int = 0;
	var scoreTxt:FlxText;
	var replayTxt:FlxText;
	var startedCountdown:Bool = false;
	var ghostNotes:Bool = false;

	var bgGirls:BackgroundGirls;

	var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;

	var maniaChanged:Bool = false;

	public static var campaignScore:Int = 0;

	var defaultCamZoom:Float = 1.05;
	var defaultCam:Float = 1.05;

	var endingDoof:DialogueBox;

	public static var daPixelZoom:Float = 6;

	public static var theFunne:Bool = true;
	var funneEffect:FlxSprite;
	var inCutscene:Bool = false;
	public static var repPresses:Int = 0;
	public static var repReleases:Int = 0;

	public static var timeCurrently:Float = 0;
	public static var timeCurrentlyR:Float = 0;
	
	// Will fire once to prevent debug spam messages and broken animations
	private var triggeredAlready:Bool = false;
	
	// Will decide if she's even allowed to headbang at all depending on the song
	private var allowedToHeadbang:Bool = false;
	// Per song additive offset
	public static var songOffset:Float = 0;
	// BotPlay text
	private var botPlayState:FlxText;
	// Replay shit
	private var saveNotes:Array<Dynamic> = [];
	private var saveJudge:Array<String> = [];
	private var replayAna:Analysis = new Analysis(); // replay analysis

	public static var highestCombo:Int = 0;

	private var executeModchart = false;
	public static var startTime = 0.0;

	var saxTrail:FlxTrail;
	var bfTrail:FlxTrail;

	var chatUsername:String;
	var chatText:String;

	var usernameTxt:FlxText;
	var chatTxt:FlxText;

	// API stuff
	
	public function addObject(object:FlxBasic) { add(object); }
	public function removeObject(object:FlxBasic) { remove(object); }


	override public function create()
	{
		important = [Lib.application.window.x,Lib.application.window.y,Lib.application.window.width,Lib.application.window.height];

		trace(important);

		chatUsername = randomUsername[FlxG.random.int(0, randomUsername.length -1)] + ":";
		chatText = randomText[FlxG.random.int(0, randomText.length -1)];

		FlxG.mouse.visible = false;

		if (isHeavy)
			{
				isHeavy = false;
			}
		if (isRobo)
			{
				isRobo = false;
			}
		if (Character.isMedicThing)
		{
			Character.isMedicThing = false;
		}

		if (cummies)
			cummies = false;

		if (SONG.song != 'Monochrome')
		{
			Main.dumpCache();

			switch (SONG.song)
			{
				case 'You Cant Run':
					{
						boyfriend = new Boyfriend(0, 0, "bf-sfm");
						add(boyfriend);
						remove(boyfriend);

						boyfriend = new Boyfriend(0, 0, "bf-sfm-dead");
						add(boyfriend);
						remove(boyfriend);

						trace("preloaded mf");
						loaded = true;
					}
				case 'Dispenser':
					{
						dad = new Character(0, 0, "scunt");
						add(dad);
						remove(dad);

						dad = new Character(0, 0, "soldier");
						add(dad);
						remove(dad);

						dad = new Character(0, 0, "engi");
						add(dad);
						remove(dad);

						trace("preloaded mf");
						loaded = true;
					}
				case 'Clinicaltrial':
					{
						dad2 = new Character(0, 0, "heavy-uber");
						add(dad2);
						remove(dad2);
					}
				default:
					{
						trace("no preload mf");
						loaded = true;
					}

			}
		}

		fidgetspinner = [112, 186, 250, 378, 634, 762, 888, 1048, 1592, 2040, 2168];

		//goes unused
		clok = [512, 539, 565, 592, 618, 644, 671, 697, 704, 731, 757, 784, 810, 837, 863, 890];

		// goes unused
		//soldierShits = [396, 428, 524, 589, 620, 653, 716, 812, 909, 972, 1005, 1036, 1101, 1164, 1197, 1260, 1325, 1420, 1453, 1548, 1581, 1676, 1709, 1904];

		// goes unused
		warnings = [384, 416, 512, 576, 608, 640, 704, 768, 800, 896, 960, 992, 1024, 1088, 1152, 1184, 1248, 1312, 1408, 1440, 1536, 1568, 1664, 1696, 1892];

		jumpscares = [504, 952, 972, 980, 1208, 1536];

		instance = this;
		
		if (FlxG.save.data.fpsCap > 290)
			(cast (Lib.current.getChildAt(0), Main)).setFPSCap(800);
		
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		if (!isStoryMode)
		{
			sicks = 0;
			bads = 0;
			shits = 0;
			goods = 0;
		}
		misses = 0;

		repPresses = 0;
		repReleases = 0;

		noteCamMovementBfY = 0;
		noteCamMovementBfX = 0;


		noteCamMovementDadY = 0;
		noteCamMovementDadX = 0;


		PlayStateChangeables.useDownscroll = FlxG.save.data.downscroll;
		PlayStateChangeables.safeFrames = FlxG.save.data.frames;
		PlayStateChangeables.scrollSpeed = FlxG.save.data.scrollSpeed;
		PlayStateChangeables.botPlay = FlxG.save.data.botplay;
		PlayStateChangeables.Optimize = FlxG.save.data.optimize;
		PlayStateChangeables.zoom = FlxG.save.data.zoom;

		// pre lowercasing the song name (create)
		var songLowercase = StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase();
		switch (songLowercase) 
		{
			case 'dad-battle': 
				songLowercase = 'dadbattle';
			case 'philly-nice': 
				songLowercase = 'philly';
		}
		
		removedVideo = false;

		#if windows
		executeModchart = FileSystem.exists(Paths.lua(songLowercase  + "/modchart"));
		if (executeModchart)
			PlayStateChangeables.Optimize = false;
		#end
		#if !cpp
		executeModchart = false; // FORCE disable for non cpp targets
		#end

		trace('Mod chart: ' + executeModchart + " - " + Paths.lua(songLowercase + "/modchart"));


		noteSplashes = new FlxTypedGroup<NoteSplash>();
		var daSplash = new NoteSplash(100, 100, 0);
		daSplash.alpha = 0;
		noteSplashes.add(daSplash);


		#if windows
		// Making difficulty text for Discord Rich Presence.
		storyDifficultyText = CoolUtil.difficultyFromInt(storyDifficulty);

		iconRPC = SONG.player2;

		// To avoid having duplicate images in Discord assets
		switch (iconRPC)
		{
			case 'senpai-angry':
				iconRPC = 'senpai';
			case 'monster-christmas':
				iconRPC = 'monster';
			case 'mom-car':
				iconRPC = 'mom';
		}

		// String that contains the mode defined here so it isn't necessary to call changePresence for each mode
		if (isStoryMode)
		{
			detailsText = "Story Mode: Week " + storyWeek;
		}
		else
		{
			detailsText = "Freeplay";
		}

		// String for when the game is paused
		detailsPausedText = "Paused - " + detailsText;

		// Updating Discord Rich Presence.
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
		#end


		// var gameCam:FlxCamera = FlxG.camera;
		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		camSustains = new FlxCamera();
		camSustains.bgColor.alpha = 0;
		camNotes = new FlxCamera();
		camNotes.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD);
		FlxG.cameras.add(camSustains);
		FlxG.cameras.add(camNotes);

		camHUD.zoom = PlayStateChangeables.zoom;

		FlxCamera.defaultCameras = [camGame];

		persistentUpdate = true;
		persistentDraw = true;

		mania = SONG.mania;

		if (SONG == null)
			SONG = Song.loadFromJson('tutorial', 'tutorial');

		Conductor.mapBPMChanges(SONG);
		Conductor.changeBPM(SONG.bpm);

		trace('INFORMATION ABOUT WHAT U PLAYIN WIT:\nFRAMES: ' + PlayStateChangeables.safeFrames + '\nZONE: ' + Conductor.safeZoneOffset + '\nTS: ' + Conductor.timeScale + '\nBotPlay : ' + PlayStateChangeables.botPlay);
	
		//noooo moooore vanilla songs!!!
		switch (songLowercase)
		{
			case 'atomicpunch':
				dialogue = CoolUtil.coolTextFile(Paths.txt('atomicpunch/pee'));
				ending = CoolUtil.coolTextFile(Paths.txt('atomicpunch/trolled'));
			case 'maggots':
				dialogue = CoolUtil.coolTextFile(Paths.txt('maggots/maggots'));
				ending = CoolUtil.coolTextFile(Paths.txt('maggots/commie'));
				maggots = true;
			case 'inferno':
				dialogue = CoolUtil.coolTextFile(Paths.txt('inferno/furry'));
				ending = CoolUtil.coolTextFile(Paths.txt('inferno/pyroInflation'));
				burnThing = true;
				swaggyOptim = 3;
			case 'ironbomber':
				dialogue = CoolUtil.coolTextFile(Paths.txt('ironbomber/poo'));
				ending = CoolUtil.coolTextFile(Paths.txt('ironbomber/black'));
				dad.color = FlxColor.BLACK;
			case 'ironcurtain':
				dialogue = CoolUtil.coolTextFile(Paths.txt('ironcurtain/iamheavyweaponsguy'));
				ending = CoolUtil.coolTextFile(Paths.txt('ironcurtain/iamdead'));
			case 'frontierjustice':
				dialogue = CoolUtil.coolTextFile(Paths.txt('frontierjustice/yeeehaw'));
				ending = CoolUtil.coolTextFile(Paths.txt('frontierjustice/nooohaw'));
				roboDad = true;
				swaggyOptim = 2;
				songIsWeird = true;
				camZooming = true;
				isRobo = true;
			case 'clinicaltrial':
				dialogue = CoolUtil.coolTextFile(Paths.txt('clinicaltrial/mehdick'));
				ending = CoolUtil.coolTextFile(Paths.txt('clinicaltrial/harderHeavy'));
				heavyDad = true;
				swaggyOptim = 1;
			case 'wanker':
				dialogue = CoolUtil.coolTextFile(Paths.txt('wanker/hehehugheh'));
				ending = CoolUtil.coolTextFile(Paths.txt('wanker/masturbation'));
				swaggyOptim = 4;
			case 'infiltrator':
				dialogue = CoolUtil.coolTextFile(Paths.txt('infiltrator/iamnotafurry'));
				ending = CoolUtil.coolTextFile(Paths.txt('infiltrator/okiamafurry'));
			case 'property-damage':
				dialogue = CoolUtil.coolTextFile(Paths.txt('property-damage/sex'));
				saxtonShit = 0.5;
			case 'skill-issue':
				dialogue = CoolUtil.coolTextFile(Paths.txt('skill-issue/holyshit'));
			case 'honorbound':
				uhm = true;
				stupidAHHHH = true;
				swaggyOptim = 3;
			case 'may-somethingth':
				memedic = true;
				hasGF = false;
			case 'dispenser', 'five-minutes', 'eyelander', 'trolling':
				hasGF = false;
			case 'you-cant-run':
				hasGF = false;
				cantRun = true;
				swaggyOptim = 5;
		}

		//defaults if no stage was found in chart
		var stageCheck:String = 'stage';
		
		if (SONG.stage == null) 
		{
			stageCheck = 'intel'; // intel room anti-crash
		} 
		else 
		{
			stageCheck = SONG.stage;
		}

		if (!PlayStateChangeables.Optimize)
		{

		switch(stageCheck)
		{
			case 'intel':
				{
						defaultCamZoom = 0.9;
						curStage = 'intel';
						var bg:FlxSprite = new FlxSprite(-300, -200).loadGraphic(Paths.image('fortress/bg/intel'));
						bg.antialiasing = true;
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						add(bg);

						pyroland = new FlxSprite(-300, -200).loadGraphic(Paths.image('fortress/bg/pyroland'));
						pyroland.antialiasing = true;
						pyroland.scrollFactor.set(0.9, 0.9);
						pyroland.active = false;
						pyroland.visible = false;
						add(pyroland);

						blakShit = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
							-FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
						blakShit.scrollFactor.set();
						blakShit.visible = false;
				}
		    case 'twofort':
				{
						defaultCamZoom = 0.9;
						curStage = 'twofort';
						var bg:FlxSprite = new FlxSprite(-600, -350).loadGraphic(Paths.image('fortress/bg/twofort'));
						bg.antialiasing = true;
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						add(bg);
				}
			case 'entry':
				{
						defaultCamZoom = 0.9;
						curStage = 'entry';
						var bg:FlxSprite = new FlxSprite(-300, -200).loadGraphic(Paths.image('fortress/bg/entry'));
						bg.antialiasing = true;
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						add(bg);

						warning = new FlxSprite(0, 0).loadGraphic(Paths.image('fortress/bg/entryWarning'));
						warning.antialiasing = true;
						warning.active = false;
						warning.visible = false;
						//warning.screenCenter();
				}
			case 'sfm-entry':
				{
						defaultCamZoom = 0.9;
						curStage = 'sfm-entry';
						sfmBG = new FlxSprite(-300, -200).loadGraphic(Paths.image('fortress/bg/sfm-entrance'));
						sfmBG.antialiasing = true;
						sfmBG.scrollFactor.set(0.9, 0.9);
						

						var sky:FlxSprite = new FlxSprite(-300, -200).loadGraphic(Paths.image('fortress/bg/exeCover/sky'));
						sky.antialiasing = true;
						sky.scrollFactor.set( 0.2, 0.2);
						add(sky);

						var bTre:FlxSprite = new FlxSprite(-300, -200).loadGraphic(Paths.image('fortress/bg/exeCover/backtrees'));
						bTre.antialiasing = true;
						bTre.scrollFactor.set( 0.5, 0.5);
						add(bTre);

						var tre:FlxSprite = new FlxSprite(-300, -200).loadGraphic(Paths.image('fortress/bg/exeCover/trees'));
						tre.antialiasing = true;
						tre.scrollFactor.set( 0.8, 0.8);
						add(tre);

						var groun:FlxSprite = new FlxSprite(-300, -200).loadGraphic(Paths.image('fortress/bg/exeCover/ground'));
						groun.antialiasing = true;
						groun.scrollFactor.set( 1, 1);
						add(groun);

						add(sfmBG);
						sfmBG.visible = false;
				}
			case 'barnblitz-demo':
				{
						defaultCamZoom = 0.82;
						curStage = 'barnblitz-demo';
						var bg:FlxSprite = new FlxSprite(-373, -175).loadGraphic(Paths.image('fortress/bg/barnblitz1'));
						bg.antialiasing = true;
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						add(bg);
				}
			case 'barnblitz-heavy':
				{
						defaultCamZoom = 0.82;
						curStage = 'barnblitz-heavy';
						var bg:FlxSprite = new FlxSprite(-400, -175).loadGraphic(Paths.image('fortress/bg/barnblitz2'));
						bg.antialiasing = true;
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						add(bg);
				}
			case 'barnblitz-engi':
				{
						defaultCamZoom = 0.82;
						curStage = 'barnblitz-engi';
						var bg:FlxSprite = new FlxSprite(-320, -200).loadGraphic(Paths.image('fortress/bg/barnblitz3'));
						bg.antialiasing = true;
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						add(bg);
				}
			case 'snake-medic':
				{
						defaultCamZoom = 0.82;
						curStage = 'snake-medic';
						var bg:FlxSprite = new FlxSprite(-400, -175).loadGraphic(Paths.image('fortress/bg/snakewater2'));
						bg.antialiasing = true;
						bg.screenCenter();
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						add(bg);
				}
			case 'snake-sniper':
				{
						defaultCamZoom = 0.82;
						curStage = 'snake-sniper';
						var bg:FlxSprite = new FlxSprite(-400, -175).loadGraphic(Paths.image('fortress/bg/snakewater1'));
						bg.antialiasing = true;
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						add(bg);
				}
			case 'snake-spy':
				{
						defaultCamZoom = 0.82;
						curStage = 'snake-spy';
						var bg:FlxSprite = new FlxSprite(-400, -175).loadGraphic(Paths.image('fortress/bg/snakewater3'));
						bg.antialiasing = true;
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						add(bg);
				}
			case 'void':
				{
						defaultCamZoom = 0.9;
						curStage = 'void';
						var bg:FlxSprite = new FlxSprite(-400, -175).loadGraphic(Paths.image('fortress/bg/void'));
						bg.antialiasing = true;
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						add(bg);
				}
			case 'issue':
				{
						defaultCamZoom = 0.9;
						curStage = 'issue';
						var bg:FlxSprite = new FlxSprite(-300, -100).loadGraphic(Paths.image('fortress/bg/badwatur'));
						bg.antialiasing = true;
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						add(bg);

						bottomBoppers = new FlxSprite(153, 186);
						bottomBoppers.frames = Paths.getSparrowAtlas('lol');
						bottomBoppers.animation.addByPrefix('lol', 'lol', 24, true);
						bottomBoppers.antialiasing = FlxG.save.data.antialiasing;
						bottomBoppers.scrollFactor.set(0.9, 0.9);
						add(bottomBoppers);	
				}
			case 'issue-two':
				{
						defaultCamZoom = 0.9;
						curStage = 'issue-two';
						var bg:FlxSprite = new FlxSprite(-300, -100).loadGraphic(Paths.image('fortress/bg/upword'));
						bg.antialiasing = true;
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						add(bg);

						bottomBoppers = new FlxSprite(153, 186);
						bottomBoppers.frames = Paths.getSparrowAtlas('lol');
						bottomBoppers.animation.addByPrefix('lol', 'lol', 24, true);
						bottomBoppers.antialiasing = FlxG.save.data.antialiasing;
						bottomBoppers.scrollFactor.set(0.9, 0.9);
						add(bottomBoppers);	
				}
			case 'issue-three':
				{
						defaultCamZoom = 0.9;
						curStage = 'issue-three';
						var bg:FlxSprite = new FlxSprite(-300, -100).loadGraphic(Paths.image('fortress/bg/swifwatur'));
						bg.antialiasing = true;
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						add(bg);

						bottomBoppers = new FlxSprite(153, 186);
						bottomBoppers.frames = Paths.getSparrowAtlas('lol');
						bottomBoppers.animation.addByPrefix('lol', 'lol', 24, true);
						bottomBoppers.antialiasing = FlxG.save.data.antialiasing;
						bottomBoppers.scrollFactor.set(0.9, 0.9);
						add(bottomBoppers);	
				}
			case 'sax':
				{
					defaultCamZoom = 0.9;
					curStage = 'sax';
					var bg:FlxSprite = new FlxSprite(-770, -750).loadGraphic(Paths.image('fortress/bg/saxBG'));
					bg.antialiasing = true;
					//bg.screenCenter();
					bg.scrollFactor.set(0.9, 0.9);
					bg.x += 200;
					bg.y += 300;
					bg.active = false;
					bg.scale.set(1.4,1.4);
					add(bg);
				}
			case 'exe':
				{
					defaultCamZoom = 1;
					curStage = 'exe';
					//hi
					blakShit = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
						-FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
					blakShit.scrollFactor.set();
					blakShit.visible = false;
				}
			case 'honor':
				{
					defaultCamZoom = 0.9;
					curStage = 'honor';
					var bg:FlxSprite = new FlxSprite(-400, 0).loadGraphic(Paths.image('fortress/bg/honor'));
					bg.antialiasing = true;
					bg.screenCenter(); // dont know how to position your bg? simple! just use Bg.screenCenter()!
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					add(bg);
				}
			case 'degroot':
				{
					defaultCamZoom = 0.82;
					curStage = 'degroot';
					var bg:FlxSprite = new FlxSprite(-425, -155).loadGraphic(Paths.image('fortress/bg/degroot'));
					bg.antialiasing = true;
					bg.screenCenter(); // dont know how to position your bg? simple! just use Bg.screenCenter()!
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					add(bg);
				}
			default:
			{
					defaultCamZoom = 0.9;
					curStage = 'stage';
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
					bg.antialiasing = FlxG.save.data.antialiasing;
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					add(bg);
			}
		}
		}
		//defaults if no gf was found in chart
		var gfCheck:String = 'gf';
		
		if (SONG.gfVersion == null) 
		{
			gfCheck = 'gf';
		} 
		else 
		{
			gfCheck = SONG.gfVersion;
		}

		var curGf:String = '';
		switch (gfCheck)
		{
			default:
				curGf = 'gf';
		}

		defaultCam = defaultCamZoom;
		
		gf = new Character(400, 130, curGf);
		gf.scrollFactor.set(0.95, 0.95);

		dad = new Character(100, 100, SONG.player2);

		/*scout = new Character(0, 0, 'scunt');
		soldier = new Character(0, 0, 'soldier');
		pyro = new Character(0, 0, 'pyro');
		demoman = new Character(0, 0, 'demo');
		heavy = new Character(0, 0, 'heavy');
		engi = new Character(0, 0, 'engi');
		medic = new Character(0, 0, 'medic');
		sniper = new Character(0, 0, 'sniper');
		spy = new Character(0, 0, 'spy');
		roboEngi = new Character(0, 0, 'robo-engi');*/

		if (heavyDad)
		{
			//Character.isMedicThing = true;
			dad2 = new Character(280, 100, "heavy");
		}
		else if (roboDad)
		{
			dad2 = new Character(280, 100, "robo-engi");
		}
		else if (cantRun)
		{
			sfmDemo = new Character(-200, 170, "demo-sfm");
		}

		var camPos:FlxPoint = new FlxPoint(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);

		switch (SONG.player2)
		{
			case 'gf':
				dad.setPosition(gf.x, gf.y);
				gf.visible = false;
			case 'scunt':
				dad.y += 70;
			case 'demo':
				dad.y += 45;
				dad.x += -200;
			case 'demoknight':
				dad.y += 120;
			case 'pyro':
				dad.y += 75;
			case 'snoiper':
				dad.y += 200;
				dad.x += -100;
			case 'engi':
				dad.y += 50;
				dad.x += -250;
				dad2.x += -175;
				dad2.y += 225;
			case 'trolldier':
				dad.y += 100;
				dad.x += -175;
			case 'sniper':
				dad.y += -75;
				dad.x += -100;
			case 'soldierai':
				dad.y += -125;
		}

		if (FlxG.save.data.botplay)
		{
			SONG.player1 = 'bf-bot';
		}

		boyfriend = new Boyfriend(770, 450, SONG.player1);

		// REPOSITIONING PER STAGE
		switch (curStage)
		{
			case 'barnblitz-engi':
				gf.x += 150;
			case 'snake-medic':
				boyfriend.y += -50;
				dad2.y += -50;
				dad2.x += -700;
				gf.y += -50;
			case 'sax':
				boyfriend.y += 500;
				dad.y += 300;
				gf.y += 500;
				gf.x += 125;
				dad.x -= 200;
				boyfriend.x += 150;
			case 'honor':
				boyfriend.y += -100;
				gf.y += -100;
		}

		gf.y -= 200;
		switch(SONG.player1)
		{
			case 'medic-bf':
				boyfriend.y += -250;
			case 'engi':
				boyfriend.y += -300;
				boyfriend.x += 25;
			default:
				trace("default bf");
		}

		if (!PlayStateChangeables.Optimize)
		{
			switch(SONG.player1)
			{
				case 'bf-bot':
					trace("HECK NO");
				default:
					if (hasGF)
					{
						add(gf);
					}
			}

			// Shitty layering but whatev it works LOL

			if (heavyDad)
			{
				add(dad2);
				funnyHeavy = new FlxSprite(dad2.x, dad2.y).loadGraphic(Paths.image('fortress/bg/heavyisdead', 'shared'));
				funnyHeavy.visible = false;
				funnyHeavy.y += 365;
				funnyHeavy.x += 125; 
				//funnyHeavy.scrollFactor.set();
				//funnyHeavy.updateHitbox();
				add(funnyHeavy);
				trace("IT WORKS!! DAD2 INCOMING!!");
			}
			else if (roboDad)
			{
				add(dad2);
			}
			else if (cantRun)
			{
				add(sfmDemo);
				sfmDemo.visible = false;
			}
			/*if (SONG.song == 'Meet The Team')
			{ // this might lag-
				add(scout);
				add(soldier);
				add(pyro);
				add(demoman);
				add(heavy);
				add(engi);
				add(medic);
				add(sniper);
				add(spy);
				add(roboEngi);
			}*/

			add(boyfriend);
			add(dad);

			if (curStage == 'intel' || curStage == 'exe')
				{
					add(blakShit);
				}

		}

		if (roboDad)
			{
				bfBOT = new FlxTrail(boyfriend, null, 3, 6, 0.3, 0.002);
				bfBOT.visible = true;
				engiBOT = new FlxTrail(dad2, null, 3, 6, 0.3, 0.002);
				engiBOT.visible = true;
				add(engiBOT);
				add(bfBOT);
				remove(engiBOT);
				remove(bfBOT);
			}

		bonkBOT = new FlxTrail(dad, null, 2, 11, 0.8, 0.01);
		add(bonkBOT);
		remove(bonkBOT);

		saxTrail = new FlxTrail(dad, null, 2, 11, 0.8, 0.01);
		bfTrail = new FlxTrail(boyfriend, null, 2, 11, 0.8, 0.01);
		add(saxTrail);
		add(bfTrail);
		remove(saxTrail);
		remove(bfTrail);



		if (loadRep)
		{
			FlxG.watch.addQuick('rep rpesses',repPresses);
			FlxG.watch.addQuick('rep releases',repReleases);
			// FlxG.watch.addQuick('Queued',inputsQueued);

			PlayStateChangeables.useDownscroll = rep.replay.isDownscroll;
			PlayStateChangeables.safeFrames = rep.replay.sf;
			PlayStateChangeables.botPlay = true;
		}

		trace('uh ' + PlayStateChangeables.safeFrames);

		trace("SF CALC: " + Math.floor((PlayStateChangeables.safeFrames / 60) * 1000));

		var doof:DialogueBox = new DialogueBox(false, dialogue);
		// doof.x += 70;
		// doof.y = FlxG.height * 0.5;
		doof.scrollFactor.set();
		doof.finishThing = titleCheck;

		endingDoof = new DialogueBox(false, ending);
		endingDoof.scrollFactor.set();
		endingDoof.finishThing = endSong;

		Conductor.songPosition = -5000;
		
		strumLine = new FlxSprite(0, 50).makeGraphic(FlxG.width, 10);
		strumLine.scrollFactor.set();
		
		if (PlayStateChangeables.useDownscroll)
			strumLine.y = FlxG.height - 165;

		strumLineNotes = new FlxTypedGroup<FlxSprite>();
		add(strumLineNotes);
		add(noteSplashes);
		playerStrums = new FlxTypedGroup<FlxSprite>();
		cpuStrums = new FlxTypedGroup<FlxSprite>();

		// startCountdown();

		if (SONG.song == null)
			trace('song is null???');
		else
			trace('song looks gucci');

		generateSong(SONG.song);

		/*for(i in unspawnNotes)
			{
				var dunceNote:Note = i;
				notes.add(dunceNote);
				if (executeModchart)
				{
					if (!dunceNote.isSustainNote)
						dunceNote.cameras = [camNotes];
					else
						dunceNote.cameras = [camSustains];
				}
				else
				{
					dunceNote.cameras = [camHUD];
				}
			}
	
			if (startTime != 0)
				{
					var toBeRemoved = [];
					for(i in 0...notes.members.length)
					{
						var dunceNote:Note = notes.members[i];
		
						if (dunceNote.strumTime - startTime <= 0)
							toBeRemoved.push(dunceNote);
						else 
						{
							if (PlayStateChangeables.useDownscroll)
							{
								if (dunceNote.mustPress)
									dunceNote.y = (playerStrums.members[Math.floor(Math.abs(dunceNote.noteData))].y
										+ 0.45 * (startTime - dunceNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
											2)) - dunceNote.noteYOff;
								else
									dunceNote.y = (strumLineNotes.members[Math.floor(Math.abs(dunceNote.noteData))].y
										+ 0.45 * (startTime - dunceNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
											2)) - dunceNote.noteYOff;
							}
							else
							{
								if (dunceNote.mustPress)
									dunceNote.y = (playerStrums.members[Math.floor(Math.abs(dunceNote.noteData))].y
										- 0.45 * (startTime - dunceNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
											2)) + dunceNote.noteYOff;
								else
									dunceNote.y = (strumLineNotes.members[Math.floor(Math.abs(dunceNote.noteData))].y
										- 0.45 * (startTime - dunceNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
											2)) + dunceNote.noteYOff;
							}
						}
					}
		
					for(i in toBeRemoved)
						notes.members.remove(i);
				}*/

		trace('generated');

		// add(strumLine);

		camFollow = new FlxObject(0, 0, 1, 1);

		camFollow.setPosition(camPos.x, camPos.y);

		if (prevCamFollow != null)
		{
			camFollow = prevCamFollow;
			prevCamFollow = null;
		}

		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, 0.04 * (30 / (cast (Lib.current.getChildAt(0), Main)).getFPS()));
		// FlxG.camera.setScrollBounds(0, FlxG.width, 0, FlxG.height);
		FlxG.camera.zoom = defaultCamZoom;
		FlxG.camera.focusOn(camFollow.getPosition());

		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

		FlxG.fixedTimestep = false;

		if (FlxG.save.data.songPosition) // I dont wanna talk about this code :(
			{
				songPosBG = new FlxSprite(0, 10).loadGraphic(Paths.image('healthBar'));
				if (PlayStateChangeables.useDownscroll)
					songPosBG.y = FlxG.height * 0.9 + 45; 
				songPosBG.screenCenter(X);
				songPosBG.scrollFactor.set();
				if (SONG.song != 'Monochrome')
				    add(songPosBG);
				
				songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), this,
					'songPositionBar', 0, 90000);
				songPosBar.scrollFactor.set();
				songPosBar.createFilledBar(FlxColor.GRAY, FlxColor.LIME);
				if (SONG.song != 'Monochrome')
				    add(songPosBar);
	
				var songName = new FlxText(songPosBG.x + (songPosBG.width / 2) - (SONG.song.length * 5),songPosBG.y,0,SONG.song, 16);
				if (PlayStateChangeables.useDownscroll)
					songName.y -= 3;
				songName.setFormat(Paths.font("tf2build.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
				songName.scrollFactor.set();
				if (SONG.song != 'Monochrome')
				    add(songName);
				songName.cameras = [camHUD];
			}

		if (!burnThing)
		{	
			healthBarBG = new FlxSprite(0, FlxG.height * 0.9).loadGraphic(Paths.image('healthBar'));
		    if (PlayStateChangeables.useDownscroll)
			    healthBarBG.y = 50;
		    healthBarBG.screenCenter(X);
		    healthBarBG.scrollFactor.set();
	    }
		else
		{
			healthBarBG = new FlxSprite(0, FlxG.height * 0.85);
			healthBarBG.frames = Paths.getSparrowAtlas('healthBarBurn');
			healthBarBG.animation.addByPrefix('idle', 'healthbar', 24, true);
		    if (PlayStateChangeables.useDownscroll)
			    healthBarBG.y = -5;
		    healthBarBG.screenCenter(X);
		    healthBarBG.scrollFactor.set();
		}

		usernameTxt = new FlxText(25,640, 0, chatUsername);
		usernameTxt.scale.set(1.2, 1.2);
		usernameTxt.antialiasing = true;

		usernameTxt.setFormat(Paths.font("tf2build.ttf"), 16, FlxColor.RED, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		usernameTxt.scrollFactor.set();

		chatTxt = new FlxText(usernameTxt.x + 150, usernameTxt.y, chatText);
		chatTxt.scale.set(1.2, 1.2);
		chatTxt.antialiasing = true;
		chatTxt.setFormat(Paths.font("tf2build.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		chatTxt.scrollFactor.set();

		add(healthBarBG);


		if (!burnThing)
			{
			    healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
			    'health', 0, 2);
			}
		else
			{
				healthBar = new FlxBar(healthBarBG.x + 8, healthBarBG.y + 57, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 19), Std.int(healthBarBG.height - 62), this,
				'health', 0, 2);
			}
		healthBar.scrollFactor.set();
		if (memedic || curSong == 'Dispenser')
			{
				healthBar.createFilledBar(FlxColor.fromRGB(204, 0, 0), FlxColor.fromRGB(204, 0, 0));
			}
		else if (curSong == 'Trolling')
		{
			healthBar.createFilledBar(FlxColor.fromRGB(171, 55, 55), FlxColor.fromRGB(204, 0, 0));
		}
		else if (curSong == 'Skill Issue')
		{
			healthBar.createFilledBar(FlxColor.fromRGB(249, 249, 249), FlxColor.fromRGB(49, 176, 209));
		}
		else
			{
				if (dad.curCharacter == 'saxton'){healthBar.createFilledBar(FlxColor.fromRGB(177, 131, 78), FlxColor.fromRGB(49, 176, 209));}
				else {healthBar.createFilledBar(FlxColor.fromRGB(204, 0, 0), FlxColor.fromRGB(49, 176, 209));}
			}
		add(healthBar);

		overhealthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 2), this,
		'health', 2.2, 4);
		overhealthBar.scrollFactor.set();
		overhealthBar.createFilledBar(0x00000000, 0xFFFFFF00);

		if (!burnThing)
			{
				kadeEngineWatermark = new FlxText(4,healthBarBG.y - 50,0,SONG.song + " - " + CoolUtil.difficultyFromInt(storyDifficulty) + (Main.watermarks ? " | MANNCO " + MainMenuState.kadeEngineVer : ""), 16);
			}
		else 
			{
				kadeEngineWatermark = new FlxText(4,healthBarBG.y + 40,0,SONG.song + " - " + CoolUtil.difficultyFromInt(storyDifficulty) + (Main.watermarks ? " | MANNCO " + MainMenuState.kadeEngineVer : ""), 16);
			}	
		kadeEngineWatermark.setFormat(Paths.font("tf2build.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		kadeEngineWatermark.scrollFactor.set();
		if (SONG.song != 'Monochrome')
		    add(kadeEngineWatermark);

		//if (PlayStateChangeables.useDownscroll)
		kadeEngineWatermark.y = FlxG.height * 0.9 + 45;
		if (!burnThing)
		{
			scoreTxt = new FlxText(FlxG.width / 2 - 235, healthBarBG.y + 50, 0, "", 20);
		}
		else
		{
			scoreTxt = new FlxText(FlxG.width / 2 - 235, healthBarBG.y + 84, 0, "", 20);
		}
		scoreTxt.screenCenter(X);

		originalX = scoreTxt.x;


		scoreTxt.scrollFactor.set();
		
		scoreTxt.setFormat(Paths.font("tf2build.ttf"), 16, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);

		add(scoreTxt);

		replayTxt = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 75, healthBarBG.y + (PlayStateChangeables.useDownscroll ? 100 : -100), 0, "REPLAY", 20);
		replayTxt.setFormat(Paths.font("tf2build.ttf"), 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		replayTxt.borderSize = 4;
		replayTxt.borderQuality = 2;
		replayTxt.scrollFactor.set();
		if (loadRep)
		{
			add(replayTxt);
		}
		// Literally copy-paste of the above, fu
		botPlayState = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 75, healthBarBG.y + (PlayStateChangeables.useDownscroll ? 100 : -100), 0, "HI I AM VERY BAD AT THE GAME", 20);
		botPlayState.setFormat(Paths.font("tf2build.ttf"), 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		botPlayState.scrollFactor.set();
		botPlayState.borderSize = 4;
		botPlayState.borderQuality = 2;
		botPlayState.screenCenter(X);
		if(PlayStateChangeables.botPlay && !loadRep) add(botPlayState);

		if (curSong == 'Inferno' && !PlayStateChangeables.botPlay)
		    iconP1 = new HealthIcon("bf-pyro", true);
		else if (PlayStateChangeables.botPlay)
			iconP1 = new HealthIcon("bf-bot", true);
		else
			iconP1 = new HealthIcon(SONG.player1, true);

		iconP1.y = healthBar.y - (iconP1.height / 2);
		add(iconP1);

		iconP2 = new HealthIcon(SONG.player2, false);
		iconP2.y = healthBar.y - (iconP2.height / 2);
		add(iconP2);

		pyrolay = new FlxSprite(0, 0).loadGraphic(Paths.image('fortress/bg/pyrolay', 'shared'));
		pyrolay.antialiasing = true;
		pyrolay.visible = false;

		usernameTxt.alpha = 0;
		chatTxt.alpha = 0;
		
		add(usernameTxt);
		add(chatTxt);

		if (maggots)
		{
			add(warning);
		}
		else if (burnThing)
		{
			add(pyrolay);
		}


		noteSplashes.cameras = [camHUD];
		strumLineNotes.cameras = [camHUD];
		notes.cameras = [camHUD];
		healthBar.cameras = [camHUD];
		overhealthBar.cameras = [camHUD];
		healthBarBG.cameras = [camHUD];
		iconP1.cameras = [camHUD];
		iconP2.cameras = [camHUD];
		scoreTxt.cameras = [camHUD];
		usernameTxt.cameras = [camHUD];
		chatTxt.cameras = [camHUD];
		//doof.cameras = [camHUD];
		if (FlxG.save.data.songPosition)
		{
			songPosBG.cameras = [camHUD];
			songPosBar.cameras = [camHUD];
		}
		kadeEngineWatermark.cameras = [camHUD];
		if (loadRep)
			replayTxt.cameras = [camHUD];
		if (maggots)
		    warning.cameras = [camHUD];
		if (burnThing)
			pyrolay.cameras = [camHUD];
		if (curStage == 'exe')
			{
				blakShit.cameras = [camHUD];
			}

		if (PlayStateChangeables.botPlay)
		{
			botPlayState.cameras = [camHUD]; // ez fix for FlxTrails overlapping
		}

		if (curSong == 'You Cant Run')
		{
			overlayRed = new FlxSprite(0, 0).loadGraphic(Paths.image('fortress/bg/exeCover/RedVG', 'shared'));
			overlayRed.alpha = 0;
			overlayRed.antialiasing = true;
			add(overlayRed);

			overlayRed.cameras = [camHUD];
		}


		// if (SONG.song == 'South')
		// FlxG.camera.alpha = 0.7;
		// UI_camera.zoom = 1;

		// cameras = [FlxG.cameras.list[1]];
		startingSong = true;
		
		trace('starting');

		if (isStoryMode)
		{
			switch (StringTools.replace(curSong," ", "-").toLowerCase())
			{
				case 'atomicpunch':
					titleIntro(doof);
				case 'maggots':
					titleIntro(doof);
				case 'inferno':
					titleIntro(doof);
				case 'ironbomber':
					titleIntro(doof);
				case 'ironcurtain':
					titleIntro(doof);
				case 'frontierjustice':
					titleIntro(doof);
				case 'clinicaltrial':
					schoolIntro(doof);
				case 'wanker':
					titleIntro(doof);
				case 'infiltrator':
					titleIntro(doof);
				case 'property-damage':
					schoolIntro(doof);			
				default:
					startCountdown();

			}
		}
		else
		{
			switch (curSong)
			{
				case 'Skill Issue':
					//dialogue = CoolUtil.coolTextFile(Paths.txt('skill-issue/holyshit'));
					schoolIntro(doof);
				default:
					startCountdown();
			}
		}

		if (!loadRep)
			rep = new Replay("na");

		FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN,handleInput);
		FlxG.stage.addEventListener(KeyboardEvent.KEY_UP, releaseInput);

		switch (curSong)
		{
			case 'Monochrome':
				boyfriend.alpha = 0;
				gf.alpha = 0;
				healthBar.alpha = 0;
				healthBarBG.alpha = 0;
				iconP1.alpha = 0;
				iconP2.alpha = 0;
				scoreTxt.alpha = 0;
				dad.visible = false;
				dad.x = 0;
				dad.y = 0;
				for (i in playerStrums) 
					{
						FlxTween.tween(i, {alpha: 0}, 0.1, {ease: FlxEase.linear});
					}
				for (i in cpuStrums) 
					{
						FlxTween.tween(i, {alpha: 0}, 0, {ease: FlxEase.linear});
						i.alpha = 0;
						i.x -= 4000;
					}

				jumpScare = new FlxSprite().loadGraphic(Paths.image('scary/scuntscare1', 'shared'));
				jumpScare.updateHitbox();
				jumpScare.screenCenter();
				add(jumpScare);

				jumpScare2 = new FlxSprite().loadGraphic(Paths.image('scary/scuntscare2', 'shared'));
				jumpScare2.updateHitbox();
				jumpScare2.screenCenter();
				add(jumpScare2);

				jumpScare.visible = false;
				jumpScare.cameras = [camHUD];

				jumpScare2.visible = false;
				jumpScare2.cameras = [camHUD];
			case 'Trolling':
				jumpScare = new FlxSprite().loadGraphic(Paths.image('scary/soldierscare', 'shared'));
				jumpScare.updateHitbox();
				jumpScare.screenCenter();
				add(jumpScare);

				jumpScare.visible = false;
				jumpScare.cameras = [camHUD];
			default:
				trace("hi");
		}

		super.create();
	}

    function epicEnd(?dialogueBox:DialogueBox):Void
		{
			if (curSong == 'Atomicpunch')
				{
					bonkBOT.visible = false;
				}
			defaultCamZoom = defaultCam;
			camZooming = false;
			inCutscene = true;
			startedCountdown = false;
			generatedMusic = false;
			canPause = false;
			FlxG.sound.music.pause();
			vocals.pause();
			vocals.stop();
			FlxG.sound.music.stop();
			remove(strumLineNotes);
			remove(scoreTxt);
			remove(healthBarBG);
			remove(healthBar);
			remove(iconP1);
			remove(iconP2);
			remove(kadeEngineWatermark);
			camFollow.setPosition(dad.getMidpoint().x + 100, boyfriend.getMidpoint().y - 250);
			if (dialogueBox != null)
				{
					add(dialogueBox);
				}
			else
				{
					endSong();
				}
				trace('in Cutscene = $inCutscene');
		}

	function titleCheck() {
		if (curSong == 'Clinicaltrial')
		{
			var titleCard:FlxSprite = new FlxSprite().loadGraphic(Paths.image('cards/$curSong', 'shared')); // using curSong
			titleCard.antialiasing = true;
			titleCard.screenCenter();
			titleCard.setGraphicSize(FlxG.width, FlxG.height);
			titleCard.cameras = [camHUD];
			add(titleCard);
			titleCard.alpha = 0;
	
			FlxTween.tween(titleCard, {alpha:1}, 1.068, {ease: FlxEase.quadInOut});
			// WHY IS THIS TIMING SO GOOD
			FlxG.sound.play(Paths.sound('title/$curSong'), 1, false, null, true, function()
				{
					remove(titleCard);
					FlxG.cameras.fade(FlxColor.BLACK, 0.1, true, function()
					{
						startCountdown();
					}, true);
				});
		}
		else
		{
			startCountdown();
		}
	}
	function titleIntro(?dialogueBox:DialogueBox):Void // titlecard intro -tob
	{
		cummies = true;
		var titleCard:FlxSprite = new FlxSprite().loadGraphic(Paths.image('cards/$curSong', 'shared')); // using curSong
		titleCard.antialiasing = true;
		titleCard.screenCenter();
		titleCard.setGraphicSize(FlxG.width, FlxG.height);
		titleCard.cameras = [camHUD];
		add(titleCard);
		titleCard.alpha = 0;

		FlxTween.tween(titleCard, {alpha:1}, 0.01, {ease: FlxEase.quadInOut});
		// WHY IS THIS TIMING SO GOOD
		FlxG.sound.play(Paths.sound('title/$curSong'), 1, false, null, true, function()
			{
				remove(titleCard);
				FlxG.cameras.fade(FlxColor.BLACK, 0.1, true, function()
				{
					add(dialogueBox);
				}, true);
			});
	}

	public static function theFunny():Void // dialogue shit
	{
		FlxTween.tween(boyfriend, {alpha:0}, 1, {ease:FlxEase.quadInOut});
		FlxTween.tween(gf, {alpha:0}, 1, {ease:FlxEase.quadInOut});
	}

	function schoolIntro(?dialogueBox:DialogueBox):Void
	{
		var black:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		black.scrollFactor.set();
		add(black);

		var red:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, 0xFFff1b31);
		red.scrollFactor.set();

		var senpaiEvil:FlxSprite = new FlxSprite();
		senpaiEvil.frames = Paths.getSparrowAtlas('weeb/senpaiCrazy');
		senpaiEvil.animation.addByPrefix('idle', 'Senpai Pre Explosion', 24, false);
		senpaiEvil.setGraphicSize(Std.int(senpaiEvil.width * 6));
		senpaiEvil.scrollFactor.set();
		senpaiEvil.updateHitbox();
		senpaiEvil.screenCenter();

		if (StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase() == 'roses' || StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase() == 'thorns')
		{
			remove(black);

			if (StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase() == 'thorns')
			{
				add(red);
			}
		}

		new FlxTimer().start(0.3, function(tmr:FlxTimer)
		{
			black.alpha -= 0.15;

			if (black.alpha > 0)
			{
				tmr.reset(0.3);
			}
			else
			{
				if (dialogueBox != null)
				{
					inCutscene = true;

					if (StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase() == 'thorns')
					{
						add(senpaiEvil);
						senpaiEvil.alpha = 0;
						new FlxTimer().start(0.3, function(swagTimer:FlxTimer)
						{
							senpaiEvil.alpha += 0.15;
							if (senpaiEvil.alpha < 1)
							{
								swagTimer.reset();
							}
							else
							{
								senpaiEvil.animation.play('idle');
								FlxG.sound.play(Paths.sound('Senpai_Dies'), 1, false, null, true, function()
								{
									remove(senpaiEvil);
									remove(red);
									FlxG.camera.fade(FlxColor.WHITE, 0.01, true, function()
									{
										add(dialogueBox);
									}, true);
								});
								new FlxTimer().start(3.2, function(deadTime:FlxTimer)
								{
									FlxG.camera.fade(FlxColor.WHITE, 1.6, false);
								});
							}
						});
					}
					else
					{
						add(dialogueBox);
					}
				}
				else
					startCountdown();

				remove(black);
			}
		});
	}

	function dead(time:Float):Void //goes unused because of the cover being updated
	{
		camHUD.visible = false;
		FlxG.sound.play(Paths.sound('scout_dominationpyr'));
		new FlxTimer().start(time, function(tmr:FlxTimer)
			{
				startCountdown();
			});
	}

	var startTimer:FlxTimer;
	var perfectMode:Bool = false;

	var luaWiggles:Array<WiggleEffect> = [];

	#if windows
	public static var luaModchart:ModchartState = null;
	#end

	var keys = [false, false, false, false, false, false, false, false, false];

	function startCountdown():Void
	{
		inCutscene = false;


		generateStaticArrows(0);
		generateStaticArrows(1);

		switch(mania) //moved it here because i can lol
		{
			case 0: 
				keys = [false, false, false, false];
			case 1: 
				keys = [false, false, false, false, false, false];
			case 2: 
				keys = [false, false, false, false, false, false, false, false, false];
			case 3: 
				keys = [false, false, false, false, false];
			case 4: 
				keys = [false, false, false, false, false, false, false];
			case 5: 
				keys = [false, false, false, false, false, false, false, false];
			case 6: 
				keys = [false];
			case 7: 
				keys = [false, false];
			case 8: 
				keys = [false, false, false];
			case 9: 
				keys = [false, false, false, false, false, false, false, false, false, false];
		}
	
		


		#if windows
		// pre lowercasing the song name (startCountdown)
		var songLowercase = StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase();
		switch (songLowercase) {
			case 'dad-battle': songLowercase = 'dadbattle';
			case 'philly-nice': songLowercase = 'philly';
		}
		if (executeModchart)
		{
			luaModchart = ModchartState.createModchartState();
			luaModchart.executeState('start',[songLowercase]);
		}
		#end
		talking = false;
		startedCountdown = true;
		Conductor.songPosition = 0;
		Conductor.songPosition -= Conductor.crochet * 5;

		var swagCounter:Int = 0;
		
		startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer)
		{
			//keeping the if else block because i can lmao -tob
			if (curSong == 'Inferno')
			{
				switch (curTiming)
				{
					case 0:
						dad.playAnim('idle');
					case 1:
						dad.playAnim('idle-alt');
				}
			}
			else if (heavyDad) 
			{
				switch (curTiming)
				{
					case 0:
						dad.playAnim('idle');
						dad2.playAnim('idle');
					case 1:
						dad.playAnim('idle-beam');
						dad2.playAnim('idle');
					case 2:
						dad.playAnim('idle-alt');
						dad2.playAnim('idle-alt');
				}

			}
			else if (roboDad)
			{
				dad.dance();
				dad2.dance();
				gf.dance();
				boyfriend.playAnim('idle');
			}
			else
			{
				if (!dad.animation.curAnim.name.startsWith('shit')) // soldier isnt allowed to shit while idleing -tob
				    dad.playAnim('idle');
				gf.dance();
				boyfriend.playAnim('idle');
			}
			

			var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
			introAssets.set('default', ['ready', "set", "go"]);
			introAssets.set('school', [
				'weeb/pixelUI/ready-pixel',
				'weeb/pixelUI/set-pixel',
				'weeb/pixelUI/date-pixel'
			]);
			introAssets.set('schoolEvil', [
				'weeb/pixelUI/ready-pixel',
				'weeb/pixelUI/set-pixel',
				'weeb/pixelUI/date-pixel'
			]);

			var introAlts:Array<String> = introAssets.get('default');
			var altSuffix:String = "";

			for (value in introAssets.keys())
			{
				if (value == curStage)
				{
					introAlts = introAssets.get(value);
					altSuffix = '-pixel';
				}
			}

			switch (swagCounter)
			{
				case 0:
					if (curSong == 'Monochrome')
						{
							cpuStrums.forEach(function(spr:FlxSprite)
								{					
									spr.alpha = 0;
								});
							playerStrums.forEach(function(spr:FlxSprite)
								{					
									spr.alpha = 0;
								});
						}
					camHUD.visible = false;
					if (curSong != 'Monochrome')
						FlxG.sound.play(Paths.sound('intro3' + altSuffix), 0.6);

				case 1 if (curSong != 'Monochrome'):
					var ready:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[0]));
					ready.scrollFactor.set();
					ready.updateHitbox();

					if (curStage.startsWith('school'))
						ready.setGraphicSize(Std.int(ready.width * daPixelZoom));

					ready.screenCenter();
					add(ready);
					FlxTween.tween(ready, {y: ready.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							ready.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('intro2' + altSuffix), 0.6);

				case 2 if (curSong != 'Monochrome'):
					var set:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[1]));
					set.scrollFactor.set();

					if (curStage.startsWith('school'))
						set.setGraphicSize(Std.int(set.width * daPixelZoom));

					set.screenCenter();
					add(set);
					FlxTween.tween(set, {y: set.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							set.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('intro1' + altSuffix), 0.6);

				case 3:
					if (curSong != 'Monochrome'){
						var go:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[2]));
						go.scrollFactor.set();

						if (curStage.startsWith('school'))
							go.setGraphicSize(Std.int(go.width * daPixelZoom));

						go.updateHitbox();

						go.screenCenter();
						add(go);
						FlxTween.tween(go, {y: go.y += 100, alpha: 0}, Conductor.crochet / 1000, {
							ease: FlxEase.cubeInOut,
							onComplete: function(twn:FlxTween)
							{
								go.destroy();
							}
						});
						FlxG.sound.play(Paths.sound('introGo' + altSuffix), 0.6);
					}
					switch (curSong)
					{
						case 'Frontierjustice':
							camHUD.visible = true;
						case 'Clinicaltrial':
							camHUD.visible = true;
						case 'May Somethingth':
							camHUD.visible = true;
						case 'Property Damage':
							camHUD.visible = true;
						case 'Meet The Team':
							camHUD.visible = true;
						case 'Five Minutes':
							camHUD.visible = true;
						case 'Skill Issue':
							camHUD.visible = true;
						case 'Dispenser':
							camHUD.visible = true;
						case 'Honorbound':
							camHUD.visible = true;
						case 'Eyelander':
							camHUD.visible = true;
						case 'Monochrome':
							camHUD.visible = true;
						case 'Trolling':
							camHUD.visible = true;
						case 'Strongmann':
							camHUD.visible = true;
						case 'You Cant Run':
							camHUD.visible = true;
						default:
							trace("ok funny intro activated");
					}

				case 4:
			}

			swagCounter += 1;
			// generateSong('fresh');
		}, 5);
	}

	var previousFrameTime:Int = 0;
	var lastReportedPlayheadPosition:Int = 0;
	var songTime:Float = 0;


	private function getKey(charCode:Int):String
	{
		for (key => value in FlxKey.fromStringMap)
		{
			if (charCode == value)
				return key;
		}
		return null;
	}
	



	private function releaseInput(evt:KeyboardEvent):Void // handles releases
	{
		@:privateAccess
		var key = FlxKey.toStringMap.get(evt.keyCode);

		var binds:Array<String> = [FlxG.save.data.leftBind,FlxG.save.data.downBind, FlxG.save.data.upBind, FlxG.save.data.rightBind];
		var data = -1;
		switch(mania)
		{
			case 0: 
				binds = [FlxG.save.data.leftBind,FlxG.save.data.downBind, FlxG.save.data.upBind, FlxG.save.data.rightBind];
				switch(evt.keyCode) // arrow keys // why the fuck are arrow keys hardcoded it fucking breaks the controls with extra keys
				{
					case 37:
						data = 0;
					case 40:
						data = 1;
					case 38:
						data = 2;
					case 39:
						data = 3;
				}
			case 1: 
				binds = [FlxG.save.data.L1Bind, FlxG.save.data.U1Bind, FlxG.save.data.R1Bind, FlxG.save.data.L2Bind, FlxG.save.data.D1Bind, FlxG.save.data.R2Bind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 3;
					case 40:
						data = 4;
					case 39:
						data = 5;
				}
			case 2: 
				binds = [FlxG.save.data.N0Bind, FlxG.save.data.N1Bind, FlxG.save.data.N2Bind, FlxG.save.data.N3Bind, FlxG.save.data.N4Bind, FlxG.save.data.N5Bind, FlxG.save.data.N6Bind, FlxG.save.data.N7Bind, FlxG.save.data.N8Bind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 5;
					case 40:
						data = 6;
					case 38:
						data = 7;
					case 39:
						data = 8;
				}
			case 3: 
				binds = [FlxG.save.data.leftBind,FlxG.save.data.downBind, FlxG.save.data.N4Bind, FlxG.save.data.upBind, FlxG.save.data.rightBind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 0;
					case 40:
						data = 1;
					case 38:
						data = 3;
					case 39:
						data = 4;
				}
			case 4: 
				binds = [FlxG.save.data.L1Bind, FlxG.save.data.U1Bind, FlxG.save.data.R1Bind,FlxG.save.data.N4Bind, FlxG.save.data.L2Bind, FlxG.save.data.D1Bind, FlxG.save.data.R2Bind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 4;
					case 40:
						data = 5;
					case 39:
						data = 6;
				}
			case 5: 
				binds = [FlxG.save.data.N0Bind, FlxG.save.data.N1Bind, FlxG.save.data.N2Bind, FlxG.save.data.N3Bind, FlxG.save.data.N5Bind, FlxG.save.data.N6Bind, FlxG.save.data.N7Bind, FlxG.save.data.N8Bind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 4;
					case 40:
						data = 5;
					case 38:
						data = 6;
					case 39:
						data = 7;
				}
			case 6: 
				binds = [FlxG.save.data.N4Bind];
			case 7: 
				binds = [FlxG.save.data.leftBind, FlxG.save.data.rightBind];
				switch(evt.keyCode) // arrow keys 
				{
					case 37:
						data = 0;
					case 39:
						data = 1;
				}

			case 8: 
				binds = [FlxG.save.data.leftBind, FlxG.save.data.N4Bind, FlxG.save.data.rightBind];
				switch(evt.keyCode) // arrow keys 
				{
					case 37:
						data = 0;
					case 39:
						data = 2;
				}
			case 9: 
				//binds = ['T0', 'T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9'];
				switch(evt.keyCode) /// 10K funny controls
				{
					case 81:
						data = 0;
					case 87:
						data = 1;
					case 69:
						data = 2;
					case 82:
						data = 3;
					case 86:
						data = 4;
					case 78:
						data = 5;
					case 85:
						data = 6;
					case 73:
						data = 7;
					case 79:
						data = 8;
					case 80:
						data = 9;
				}

		}

		


		for (i in 0...binds.length) // binds
		{
			if (binds[i].toLowerCase() == key.toLowerCase())
				data = i;
		}

		if (data == -1)
			return;

		keys[data] = false;
	}

	public var closestNotes:Array<Note> = [];

	private function handleInput(evt:KeyboardEvent):Void { // this actually handles press inputs

		if (PlayStateChangeables.botPlay || loadRep || paused)
			return;

		// first convert it from openfl to a flixel key code
		// then use FlxKey to get the key's name based off of the FlxKey dictionary
		// this makes it work for special characters

		@:privateAccess
		var key = FlxKey.toStringMap.get(evt.keyCode);
		var data = -1;
		var binds:Array<String> = [FlxG.save.data.leftBind,FlxG.save.data.downBind, FlxG.save.data.upBind, FlxG.save.data.rightBind];
		switch(mania)
		{
			case 0: 
				binds = [FlxG.save.data.leftBind,FlxG.save.data.downBind, FlxG.save.data.upBind, FlxG.save.data.rightBind];
				switch(evt.keyCode) // arrow keys // why the fuck are arrow keys hardcoded it fucking breaks the controls with extra keys
				{
					case 37:
						data = 0;
					case 40:
						data = 1;
					case 38:
						data = 2;
					case 39:
						data = 3;
				}
			case 1: 
				binds = [FlxG.save.data.L1Bind, FlxG.save.data.U1Bind, FlxG.save.data.R1Bind, FlxG.save.data.L2Bind, FlxG.save.data.D1Bind, FlxG.save.data.R2Bind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 3;
					case 40:
						data = 4;
					case 39:
						data = 5;
				}
			case 2: 
				binds = [FlxG.save.data.N0Bind, FlxG.save.data.N1Bind, FlxG.save.data.N2Bind, FlxG.save.data.N3Bind, FlxG.save.data.N4Bind, FlxG.save.data.N5Bind, FlxG.save.data.N6Bind, FlxG.save.data.N7Bind, FlxG.save.data.N8Bind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 5;
					case 40:
						data = 6;
					case 38:
						data = 7;
					case 39:
						data = 8;
				}
			case 3: 
				binds = [FlxG.save.data.leftBind,FlxG.save.data.downBind, FlxG.save.data.N4Bind, FlxG.save.data.upBind, FlxG.save.data.rightBind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 0;
					case 40:
						data = 1;
					case 38:
						data = 3;
					case 39:
						data = 4;
				}
			case 4: 
				binds = [FlxG.save.data.L1Bind, FlxG.save.data.U1Bind, FlxG.save.data.R1Bind,FlxG.save.data.N4Bind, FlxG.save.data.L2Bind, FlxG.save.data.D1Bind, FlxG.save.data.R2Bind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 4;
					case 40:
						data = 5;
					case 39:
						data = 6;
				}
			case 5: 
				binds = [FlxG.save.data.N0Bind, FlxG.save.data.N1Bind, FlxG.save.data.N2Bind, FlxG.save.data.N3Bind, FlxG.save.data.N5Bind, FlxG.save.data.N6Bind, FlxG.save.data.N7Bind, FlxG.save.data.N8Bind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 4;
					case 40:
						data = 5;
					case 38:
						data = 6;
					case 39:
						data = 7;
				}
			case 6: 
				binds = [FlxG.save.data.N4Bind];
			case 7: 
				binds = [FlxG.save.data.leftBind, FlxG.save.data.rightBind];
				switch(evt.keyCode) // arrow keys 
				{
					case 37:
						data = 0;
					case 39:
						data = 1;
				}

			case 8: 
				binds = [FlxG.save.data.leftBind, FlxG.save.data.N4Bind, FlxG.save.data.rightBind];
				switch(evt.keyCode) // arrow keys 
				{
					case 37:
						data = 0;
					case 39:
						data = 2;
				}
			case 9: 
				//binds = ['T0', 'T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9'];
				switch(evt.keyCode) // 10K funny controls
				{
					case 81:
						data = 0;
					case 87:
						data = 1;
					case 69:
						data = 2;
					case 82:
						data = 3;
					case 86:
						data = 4;
					case 78:
						data = 5;
					case 85:
						data = 6;
					case 73:
						data = 7;
					case 79:
						data = 8;
					case 80:
						data = 9;
				}

		}

			for (i in 0...binds.length) // binds
				{
					if (binds[i].toLowerCase() == key.toLowerCase())
						data = i;
				}
				if (data == -1)
				{
					//trace("couldn't find a keybind with the code " + key);
					return;
				}
				if (keys[data])
				{
					//trace("ur already holding " + key);
					return;
				}
		
				keys[data] = true;
		
				var ana = new Ana(Conductor.songPosition, null, false, "miss", data);
		
				var dataNotes = [];
				for(i in closestNotes)
					if (i.noteData == data)
						dataNotes.push(i);

				
				if (!FlxG.save.data.gthm)
				{
					if (dataNotes.length != 0)
						{
							var coolNote = null;
				
							for (i in dataNotes)
								if (!i.isSustainNote)
								{
									coolNote = i;
									break;
								}
				
							if (coolNote == null) // Note is null, which means it's probably a sustain note. Update will handle this (HOPEFULLY???)
							{
								return;
							}
				
							if (dataNotes.length > 1) // stacked notes or really close ones
							{
								for (i in 0...dataNotes.length)
								{
									if (i == 0) // skip the first note
										continue;
				
									var note = dataNotes[i];
				
									if (!note.isSustainNote && (note.strumTime - coolNote.strumTime) < 2)
									{
										//trace('found a stacked/really close note ' + (note.strumTime - coolNote.strumTime));
										// just fuckin remove it since it's a stacked note and shouldn't be there
										note.kill();
										notes.remove(note, true);
										note.destroy();
									}
								}
							}
				
							goodNoteHit(coolNote);
							var noteDiff:Float = -(coolNote.strumTime - Conductor.songPosition);
							ana.hit = true;
							ana.hitJudge = Ratings.CalculateRating(noteDiff, Math.floor((PlayStateChangeables.safeFrames / 60) * 1000));
							ana.nearestNote = [coolNote.strumTime, coolNote.noteData, coolNote.sustainLength];
						
						}
					/*else if (!FlxG.save.data.ghost && songStarted && !grace)
						{
							noteMiss(data, null);
							ana.hit = false;
							ana.hitJudge = "shit";
							ana.nearestNote = [];
							//health -= 0.20;
						}*/ //broke :(
				}
		
	}

	var songStarted = false;

	function startSong():Void
	{
		startingSong = false;
		songStarted = true;
		previousFrameTime = FlxG.game.ticks;
		lastReportedPlayheadPosition = 0;
		if (curSong == 'Monochrome'){dad.debugMode = true;}
		if (!paused){FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 1, false);}
		if (FlxG.save.data.noteSplash)
			{
				switch (mania)
				{
					case 0: 
						NoteSplash.colors = ['purple', 'blue', 'green', 'red'];
					case 1: 
						NoteSplash.colors = ['purple', 'green', 'red', 'yellow', 'blue', 'darkblue'];	
					case 2: 
						NoteSplash.colors = ['purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', FlxG.save.data.noteColor, 'darkblue'];
					case 3: 
						NoteSplash.colors = ['purple', 'blue', 'white', 'green', 'red'];
						if (FlxG.save.data.gthc)
							NoteSplash.colors = ['green', 'red', 'yellow', 'darkblue', 'orange'];
					case 4: 
						NoteSplash.colors = ['purple', 'green', 'red', 'white', 'yellow', 'blue', 'darkblue'];
					case 5: 
						NoteSplash.colors = ['purple', 'blue', 'green', 'red', 'yellow', 'violet', FlxG.save.data.noteColor, 'darkblue'];
					case 6: 
						NoteSplash.colors = ['white'];
					case 7: 
						NoteSplash.colors = ['purple', 'red'];
					case 8: 
						NoteSplash.colors = ['purple', 'white', 'red'];
					case 9: 
						NoteSplash.colors = ['purple', 'blue', 'green', 'red', 'orange', 'black', 'yellow', 'violet', 'darkred', 'darkblue'];
				}
			}

		FlxG.sound.music.onComplete = songOutro;
		vocals.play();
		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;
		if (FlxG.save.data.songPosition)
		{
			remove(songPosBG);
			remove(songPosBar);
			remove(songName);

			songPosBG = new FlxSprite(0, 10).loadGraphic(Paths.image('healthBar'));
			if (PlayStateChangeables.useDownscroll)
				songPosBG.y = FlxG.height * 0.9 + 45; 
			songPosBG.screenCenter(X);
			songPosBG.scrollFactor.set();
			add(songPosBG);

			songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), this,
				'songPositionBar', 0, songLength - 1000);
			songPosBar.numDivisions = 1000;
			songPosBar.scrollFactor.set();
			songPosBar.createFilledBar(FlxColor.GRAY, FlxColor.LIME);
			add(songPosBar);

			var songName = new FlxText(songPosBG.x + (songPosBG.width / 2) - (SONG.song.length * 5),songPosBG.y,0,SONG.song, 16);
			if (PlayStateChangeables.useDownscroll)
				songName.y -= 3;
			songName.setFormat(Paths.font("tf2build.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
			songName.scrollFactor.set();
			add(songName);

			songPosBG.cameras = [camHUD];
			songPosBar.cameras = [camHUD];
			songName.cameras = [camHUD];
		}
		
		// Song check real quick
		switch(curSong)
		{
			case 'Bopeebo' | 'Philly Nice' | 'Blammed' | 'Cocoa' | 'Eggnog': allowedToHeadbang = true;
			default: allowedToHeadbang = false;
		}

		if (useVideo)
			GlobalVideo.get().resume();
		
		#if windows
		// Updating Discord Rich Presence (with Time Left)
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
		#end
	}

	var debugNum:Int = 0;

	private function generateSong(dataPath:String):Void
	{
		// FlxG.log.add(ChartParser.parse());

		var songData = SONG;
		Conductor.changeBPM(songData.bpm);

		curSong = songData.song;

		if (SONG.needsVoices)
			vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
		else
			vocals = new FlxSound();

		trace('loaded vocals');

		FlxG.sound.list.add(vocals);

		notes = new FlxTypedGroup<Note>();
		add(notes);

		var noteData:Array<SwagSection>;
		Note.hitCheck = 0;
		// NEW SHIT
		noteData = songData.notes;

		var playerCounter:Int = 0;

		// Per song offset check
		#if windows
			// pre lowercasing the song name (generateSong)
			var songLowercase = StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase();
				switch (songLowercase) {
					case 'dad-battle': songLowercase = 'dadbattle';
					case 'philly-nice': songLowercase = 'philly';
				}

			var songPath = 'assets/data/' + songLowercase + '/';
			
			for(file in sys.FileSystem.readDirectory(songPath))
			{
				var path = haxe.io.Path.join([songPath, file]);
				if(!sys.FileSystem.isDirectory(path))
				{
					if(path.endsWith('.offset'))
					{
						trace('Found offset file: ' + path);
						songOffset = Std.parseFloat(file.substring(0, file.indexOf('.off')));
						break;
					}else {
						trace('Offset file not found. Creating one @: ' + songPath);
						sys.io.File.saveContent(songPath + songOffset + '.offset', '');
					}
				}
			}
		#end
		var daBeats:Int = 0; // Not exactly representative of 'daBeats' lol, just how much it has looped
		for (section in noteData)
		{
			var mn:Int = keyAmmo[mania];
			var coolSection:Int = Std.int(section.lengthInSteps / 4);

			for (songNotes in section.sectionNotes)
			{
				var daStrumTime:Float = songNotes[0] + FlxG.save.data.offset + songOffset;
				if (daStrumTime < 0)
					daStrumTime = 0;
				var daNoteData:Int = Std.int(songNotes[1] % mn);

				var gottaHitNote:Bool = section.mustHitSection;

				if (songNotes[1] >= mn)
				{
					gottaHitNote = !section.mustHitSection;
				}

				var oldNote:Note;
				if (unspawnNotes.length > 0)
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
				else
					oldNote = null;

				var daType = songNotes[3];

				var swagNote:Note = new Note(daStrumTime, daNoteData, oldNote, false, daType);

				if (!gottaHitNote && PlayStateChangeables.Optimize)
					continue;

				swagNote.sustainLength = songNotes[2];
				swagNote.scrollFactor.set(0, 0);

				var susLength:Float = swagNote.sustainLength;

				susLength = susLength / Conductor.stepCrochet;
				unspawnNotes.push(swagNote);

				if (susLength > 0)
					swagNote.isParent = true;

				var type = 0;

				for (susNote in 0...Math.floor(susLength))
				{
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];

					var sustainNote:Note = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + Conductor.stepCrochet, daNoteData, oldNote, true, daType);
					sustainNote.scrollFactor.set();
					unspawnNotes.push(sustainNote);

					sustainNote.mustPress = gottaHitNote;

					if (sustainNote.mustPress)
					{
						sustainNote.x += FlxG.width / 2; // general offset
					}
					sustainNote.parent = swagNote;
					swagNote.children.push(sustainNote);
					sustainNote.spotInLine = type;
					type++;
				}

				swagNote.mustPress = gottaHitNote;

				if (swagNote.mustPress)
				{
					swagNote.x += FlxG.width / 2; // general offset
				}
				else
				{
				}
			}
			daBeats += 1;
		}

		// trace(unspawnNotes.length);
		// playerCounter += 1;

		unspawnNotes.sort(sortByShit);

		generatedMusic = true;
	}

	function sortByShit(Obj1:Note, Obj2:Note):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	private function generateStaticArrows(player:Int):Void
	{
		for (i in 0...keyAmmo[mania])
		{
			// FlxG.log.add(i);
			var babyArrow:FlxSprite = new FlxSprite(0, strumLine.y);

			//defaults if no noteStyle was found in chart
			var noteTypeCheck:String = 'normal';
		
			if (PlayStateChangeables.Optimize && player == 0)
				continue;

			if (PlayStateChangeables.Optimize || SONG.song == 'Property Damage')
				{
					babyArrow.x -= 275;
					cpuStrums.forEach(function(spr:FlxSprite)
						{					
							spr.x -= 700; 
						});
				}
			if (SONG.noteStyle == null) 
			{
				switch(storyWeek) 
				{
					case 6: 
						noteTypeCheck = 'pixel';
				}
			} 
			else 
				{
					noteTypeCheck = SONG.noteStyle;
				}

			switch (noteTypeCheck)
			{
				case 'pixel':
					babyArrow.loadGraphic(Paths.image('noteassets/pixel/arrows-pixels'), true, 17, 17);
					babyArrow.animation.add('green', [11]);
					babyArrow.animation.add('red', [12]);
					babyArrow.animation.add('blue', [10]);
					babyArrow.animation.add('purplel', [9]);

					babyArrow.animation.add('white', [13]);
					babyArrow.animation.add('yellow', [14]);
					babyArrow.animation.add('violet', [15]);
					babyArrow.animation.add('black', [16]);
					babyArrow.animation.add('darkred', [16]);
					babyArrow.animation.add('orange', [16]);
					babyArrow.animation.add('dark', [17]);


					babyArrow.setGraphicSize(Std.int(babyArrow.width * daPixelZoom * Note.pixelnoteScale));
					babyArrow.updateHitbox();
					babyArrow.antialiasing = false;

					var numstatic:Array<Int> = [0, 1, 2, 3, 4, 5, 6, 7, 8]; //this is most tedious shit ive ever done why the fuck is this so hard
					var startpress:Array<Int> = [9, 10, 11, 12, 13, 14, 15, 16, 17];
					var endpress:Array<Int> = [18, 19, 20, 21, 22, 23, 24, 25, 26];
					var startconf:Array<Int> = [27, 28, 29, 30, 31, 32, 33, 34, 35];
					var endconf:Array<Int> = [36, 37, 38, 39, 40, 41, 42, 43, 44];
						switch (mania)
						{
							case 1:
								numstatic = [0, 2, 3, 5, 1, 8];
								startpress = [9, 11, 12, 14, 10, 17];
								endpress = [18, 20, 21, 23, 19, 26];
								startconf = [27, 29, 30, 32, 28, 35];
								endconf = [36, 38, 39, 41, 37, 44];

							case 2: 
								babyArrow.x -= Note.tooMuch;
							case 3: 
								numstatic = [0, 1, 4, 2, 3];
								startpress = [9, 10, 13, 11, 12];
								endpress = [18, 19, 22, 20, 21];
								startconf = [27, 28, 31, 29, 30];
								endconf = [36, 37, 40, 38, 39];
							case 4: 
								numstatic = [0, 2, 3, 4, 5, 1, 8];
								startpress = [9, 11, 12, 13, 14, 10, 17];
								endpress = [18, 20, 21, 22, 23, 19, 26];
								startconf = [27, 29, 30, 31, 32, 28, 35];
								endconf = [36, 38, 39, 40, 41, 37, 44];
							case 5: 
								numstatic = [0, 1, 2, 3, 5, 6, 7, 8];
								startpress = [9, 10, 11, 12, 14, 15, 16, 17];
								endpress = [18, 19, 20, 21, 23, 24, 25, 26];
								startconf = [27, 28, 29, 30, 32, 33, 34, 35];
								endconf = [36, 37, 38, 39, 41, 42, 43, 44];
							case 6: 
								numstatic = [4];
								startpress = [13];
								endpress = [22];
								startconf = [31];
								endconf = [40];
							case 7: 
								numstatic = [0, 3];
								startpress = [9, 12];
								endpress = [18, 21];
								startconf = [27, 30];
								endconf = [36, 39];
							case 8: 
								numstatic = [0, 4, 3];
								startpress = [9, 13, 12];
								endpress = [18, 22, 21];
								startconf = [27, 31, 30];
								endconf = [36, 40, 39];


						}
					babyArrow.x += Note.swagWidth * i;
					babyArrow.animation.add('static', [numstatic[i]]);
					babyArrow.animation.add('pressed', [startpress[i], endpress[i]], 12, false);
					babyArrow.animation.add('confirm', [startconf[i], endconf[i]], 24, false);

					
				
					case 'normal':
						{
							babyArrow.frames = Paths.getSparrowAtlas('noteassets/NOTE_assets');
							babyArrow.animation.addByPrefix('green', 'arrowUP');
							babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
							babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
							babyArrow.animation.addByPrefix('red', 'arrowRIGHT');
		
							babyArrow.antialiasing = FlxG.save.data.antialiasing;
							babyArrow.setGraphicSize(Std.int(babyArrow.width * Note.noteScale));
	
							var nSuf:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
							var pPre:Array<String> = ['purple', 'blue', 'green', 'red'];
								switch (mania)
								{
									case 1:
										nSuf = ['LEFT', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'RIGHT'];
										pPre = ['purple', 'green', 'red', 'yellow', 'blue', 'dark'];
	
									case 2:
										nSuf = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'SPACE', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
										pPre = ['purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', FlxG.save.data.noteColor, 'dark'];
										babyArrow.x -= Note.tooMuch;
									case 3: 
										nSuf = ['LEFT', 'DOWN', 'SPACE', 'UP', 'RIGHT'];
										pPre = ['purple', 'blue', 'white', 'green', 'red'];
										if (FlxG.save.data.gthc)
										{
											nSuf = ['UP', 'RIGHT', 'LEFT', 'RIGHT', 'UP'];
											pPre = ['green', 'red', 'yellow', 'dark', 'orange'];
										}
									case 4: 
										nSuf = ['LEFT', 'UP', 'RIGHT', 'SPACE', 'LEFT', 'DOWN', 'RIGHT'];
										pPre = ['purple', 'green', 'red', 'white', 'yellow', 'blue', 'dark'];
									case 5: 
										nSuf = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
										pPre = ['purple', 'blue', 'green', 'red', 'yellow', 'violet', FlxG.save.data.noteColor, 'dark'];
									case 6: 
										nSuf = ['SPACE'];
										pPre = ['white'];
									case 7: 
										nSuf = ['LEFT', 'RIGHT'];
										pPre = ['purple', 'red'];
									case 8: 
										nSuf = ['LEFT', 'SPACE', 'RIGHT'];
										pPre = ['purple', 'white', 'red'];
									case 9:
										nSuf = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'UP', 'UP', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
										pPre = ['purple', 'blue', 'green', 'red', 'orange', 'black', 'yellow', 'violet', 'darkred', 'dark'];
										babyArrow.x -= Note.tooMuch;
	
								}
						
						babyArrow.x += Note.swagWidth * i;
						babyArrow.animation.addByPrefix('static', 'arrow' + nSuf[i]);
						babyArrow.animation.addByPrefix('pressed', pPre[i] + ' press', 24, false);
						babyArrow.animation.addByPrefix('confirm', pPre[i] + ' confirm', 24, false);
						}						
			}

			babyArrow.updateHitbox();
			babyArrow.scrollFactor.set();

			// not really needed, just complicates stuff for other songs -tob
			/*if (!isStoryMode)
			{
				babyArrow.y -= 10;
				babyArrow.alpha = 0;
				FlxTween.tween(babyArrow, {y: babyArrow.y + 10, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
			}*/

			babyArrow.ID = i;

			switch (player)
			{
				case 0:
					cpuStrums.add(babyArrow);
				case 1:
					playerStrums.add(babyArrow);
			}

			babyArrow.animation.play('static');
			babyArrow.x += 50;
			babyArrow.x += ((FlxG.width / 2) * player);
			
			
			cpuStrums.forEach(function(spr:FlxSprite)
			{					
				spr.centerOffsets(); //CPU arrows start out slightly off-center
			});

			strumLineNotes.add(babyArrow);
		}
	}

	function tweenCam(zoom:Float, duration:Float):Void
	{
		FlxTween.tween(FlxG.camera, {zoom: zoom}, duration ,{ease: FlxEase.quadInOut});
	}

	override function openSubState(SubState:FlxSubState)
	{
		if (paused)
		{
			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.pause();
				vocals.pause();
			}

			#if windows
			DiscordClient.changePresence("PAUSED on " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "Acc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
			#end
			if (!startTimer.finished)
				startTimer.active = false;
		}

		super.openSubState(SubState);
	}

	override function closeSubState()
	{
		if (paused)
		{
			if (FlxG.sound.music != null && !startingSong)
			{
				resyncVocals();
			}

			if (!startTimer.finished)
				startTimer.active = true;
			paused = false;

			#if windows
			if (startTimer.finished)
			{
				DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses, iconRPC, true, songLength - Conductor.songPosition);
			}
			else
			{
				DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), iconRPC);
			}
			#end
		}

		super.closeSubState();
	}
	

	function resyncVocals():Void
	{
		vocals.pause();

		FlxG.sound.music.play();
		Conductor.songPosition = FlxG.sound.music.time;
		vocals.time = Conductor.songPosition;
		vocals.play();

		#if windows
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
		#end
	}

	private var paused:Bool = false;

	var canPause:Bool = true;
	var nps:Int = 0;
	var maxNPS:Int = 0;

	public static var songRate = 1.5;

	public var stopUpdate = false;
	public var removedVideo = false;

	override public function update(elapsed:Float)
	{

		chatTxt.x = usernameTxt.x + (chatUsername.length * 14);

		elapsedtime += elapsed;
		#if !debug
		perfectMode = false;
		#end

		if (generatedMusic)
			{
				for(i in notes)
				{
					var diff = i.strumTime - Conductor.songPosition;
					if (diff < 2650 && diff >= -2650)
					{
						i.active = true;
						i.visible = true;
					}
					else
					{
						i.active = false;
						i.visible = false;
					}
				}
			}

		//lmao how long is this here and why is it in the update function -tob
		/*if (health > 0.1)
		{
	        if (stupidAHHHH)
			    {
				    health -= 0.001;
				    trace("AHHHHH");
			    }
		}*/

		if (shakeCam && FlxG.save.data.epl)
			{
				FlxG.camera.shake(0.015, 0.015);
			}

		if (PlayStateChangeables.botPlay && FlxG.keys.justPressed.ONE)
			camHUD.visible = !camHUD.visible;


		if (useVideo && GlobalVideo.get() != null && !stopUpdate)
			{		
				if (GlobalVideo.get().ended && !removedVideo)
				{
					remove(videoSprite);
					FlxG.stage.window.onFocusOut.remove(focusOut);
					FlxG.stage.window.onFocusIn.remove(focusIn);
					removedVideo = true;
				}
			}
		
		#if windows
		if (executeModchart && luaModchart != null && songStarted)
		{
			luaModchart.setVar('songPos',Conductor.songPosition);
			luaModchart.setVar('hudZoom', camHUD.zoom);
			luaModchart.setVar('cameraZoom',FlxG.camera.zoom);
			luaModchart.executeState('update', [elapsed]);

			for (i in luaWiggles)
			{
				trace('wiggle le gaming');
				i.update(elapsed);
			}

			/*for (i in 0...strumLineNotes.length) {
				var member = strumLineNotes.members[i];
				member.x = luaModchart.getVar("strum" + i + "X", "float");
				member.y = luaModchart.getVar("strum" + i + "Y", "float");
				member.angle = luaModchart.getVar("strum" + i + "Angle", "float");
			}*/

			FlxG.camera.angle = luaModchart.getVar('cameraAngle', 'float');
			camHUD.angle = luaModchart.getVar('camHudAngle','float');

			if (luaModchart.getVar("showOnlyStrums",'bool'))
			{
				healthBarBG.visible = false;
				kadeEngineWatermark.visible = false;
				healthBar.visible = false;
				overhealthBar.visible = false;
				iconP1.visible = false;
				iconP2.visible = false;
				scoreTxt.visible = false;
			}
			else
			{
				healthBarBG.visible = true;
				kadeEngineWatermark.visible = true;
				healthBar.visible = true;
				overhealthBar.visible = false;
				iconP1.visible = true;
				iconP2.visible = true;
				scoreTxt.visible = true;
			}

			var p1 = luaModchart.getVar("strumLine1Visible",'bool');
			var p2 = luaModchart.getVar("strumLine2Visible",'bool');

			for (i in 0...keyAmmo[mania])
			{
				strumLineNotes.members[i].visible = p1;
				if (i <= playerStrums.length)
					playerStrums.members[i].visible = p2;
			}

			camNotes.zoom = camHUD.zoom;
			camNotes.x = camHUD.x;
			camNotes.y = camHUD.y;
			camNotes.angle = camHUD.angle;
			camSustains.zoom = camHUD.zoom;
			camSustains.x = camHUD.x;
			camSustains.y = camHUD.y;
			camSustains.angle = camHUD.angle;
		}

		#end

		// reverse iterate to remove oldest notes first and not invalidate the iteration
		// stop iteration as soon as a note is not removed
		// all notes should be kept in the correct order and this is optimal, safe to do every frame/update

		// me when balls and cock are bad
		{
			var balls = notesHitArray.length-1;
			while (balls >= 0)
			{
				var cock:Date = notesHitArray[balls];
				if (cock != null && cock.getTime() + 1000 < Date.now().getTime())
					notesHitArray.remove(cock);
				else
					balls = 0;
				balls--;
			}
			nps = notesHitArray.length;
			if (nps > maxNPS)
				maxNPS = nps;
		}

		/*if (FlxG.keys.justPressed.NINE)
		{
			if (iconP1.animation.curAnim.name == 'bf-old')
				if (burnThing)
				    iconP1.animation.play("bf-pyro");
			    else
					iconP1.animation.play(SONG.player1);
			else
				iconP1.animation.play('bf-old');
		}*/


		// fuck this this is stupid!!!! goes unused because uhh idk -tob
		/*if (burnThing)
			{
				if (pyroland.visible)
					{
						pyrolay.visible = true;
					}
				else if (!pyroland.visible)
					{
						pyrolay.visible = false;
					}
			}*/

		if (curSong == 'You Cant Run' && seethe)
		{
			if (mald)
			{
				if (overlayRed.alpha != 1)
				    overlayRed.alpha += 0.01;
				else
					mald = false;
			}
			else
			{
				if (overlayRed.alpha != 0)
				    overlayRed.alpha -= 0.01;
				else
					mald = true;
			}
		}


		if (curSong == 'Trolling' && FlxG.fullscreen){FlxG.fullscreen = false;}

		super.update(elapsed);

		scoreTxt.text = Ratings.CalculateRanking(songScore,songScoreDef,nps,maxNPS,accuracy);

		var lengthInPx = scoreTxt.textField.length * scoreTxt.frameHeight; // bad way but does more or less a better job

		scoreTxt.x = (originalX - (lengthInPx / 2)) + 335;

		if (controls.PAUSE && startedCountdown && canPause && !cannotDie)
		{
			persistentUpdate = false;
			persistentDraw = true;
			paused = true;

			if (SONG.song == 'Trolling')
				{resetWindow();}

			openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
			
		}

		doDeathCheck();

		if (FlxG.keys.justPressed.SEVEN && songStarted && curSong != 'Atomicpunch')
		{
			PlayState.SONG = Song.loadFromJson('skill-issue-bot', 'skill-issue');
		    PlayState.isStoryMode = false;
		    PlayState.storyWeek = 0;
		    trace('CUR WEEK' + PlayState.storyWeek);

			if (useVideo)
				{
					GlobalVideo.get().stop();
					remove(videoSprite);
					FlxG.stage.window.onFocusOut.remove(focusOut);
					FlxG.stage.window.onFocusIn.remove(focusIn);
					removedVideo = true;
				}
			cannotDie = true;
			#if windows
			DiscordClient.changePresence("LMAO MASSIVE SKILL ISSUE", null, null, true);
			#end
			//FlxG.switchState(new ChartingState());
			LoadingState.loadAndSwitchState(new PlayState());
			//Main.editor = true;
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN,handleInput);
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, releaseInput);
			#if windows
			if (luaModchart != null)
			{
				luaModchart.die();
				luaModchart = null;
			}
			#end
		}
		

		// FlxG.watch.addQuick('VOL', vocals.amplitudeLeft);
		// FlxG.watch.addQuick('VOLRight', vocals.amplitudeRight);

		iconP1.setGraphicSize(Std.int(FlxMath.lerp(150, iconP1.width, 0.50)));
		iconP2.setGraphicSize(Std.int(FlxMath.lerp(150, iconP2.width, 0.50)));

		iconP1.updateHitbox();
		iconP2.updateHitbox();

		var iconOffset:Int = 26;

		iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
		iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);

		if (health > 4)
			health = 4;
		if (healthBar.percent < 20)
			iconP1.animation.curAnim.curFrame = 1;
		else
			iconP1.animation.curAnim.curFrame = 0;

		if (healthBar.percent > 80)
			iconP2.animation.curAnim.curFrame = 1;
		else
			iconP2.animation.curAnim.curFrame = 0;

		/* if (FlxG.keys.justPressed.NINE)
			FlxG.switchState(new Charting()); */

		if (FlxG.keys.justPressed.EIGHT && developor)
			{
				//FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				//FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyUp);
	
				if(FlxG.keys.pressed.SHIFT)
				{
					FlxG.switchState(new AnimationDebug(SONG.player1));
				}
				else if(FlxG.keys.pressed.CONTROL)
				{
					FlxG.switchState(new AnimationDebug("sfm-bf"));
				}
				else
				{
					FlxG.switchState(new AnimationDebug(SONG.player2));
				}
			}

		if (startingSong)
		{
			if (startedCountdown)
			{
				Conductor.songPosition += FlxG.elapsed * 1000;
				if (Conductor.songPosition >= 0)
					startSong();
			}
		}
		else
		{
			// Conductor.songPosition = FlxG.sound.music.time;
			Conductor.songPosition += FlxG.elapsed * 1000;
			/*@:privateAccess
			{
				FlxG.sound.music._channel.
			}*/
			songPositionBar = Conductor.songPosition;

			if (!paused)
			{
				songTime += FlxG.game.ticks - previousFrameTime;
				previousFrameTime = FlxG.game.ticks;

				// Interpolation type beat
				if (Conductor.lastSongPos != Conductor.songPosition)
				{
					songTime = (songTime + Conductor.songPosition) / 2;
					Conductor.lastSongPos = Conductor.songPosition;
					// Conductor.songPosition += FlxG.elapsed * 1000;
					// trace('MISSED FRAME');
				}
			}

			// Conductor.lastSongPos = FlxG.sound.music.time;
		}

		if (generatedMusic && PlayState.SONG.notes[Std.int(curStep / 16)] != null)
		{
			closestNotes = [];

			notes.forEachAlive(function(daNote:Note)
			{
				if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit)
					closestNotes.push(daNote);
			}); // Collect notes that can be hit

			closestNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));

			if (closestNotes.length != 0)
				FlxG.watch.addQuick("Current Note",closestNotes[0].strumTime - Conductor.songPosition);
			// Make sure Girlfriend cheers only for certain songs
			
			#if windows
			if (luaModchart != null)
				luaModchart.setVar("mustHit",PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection);
			#end

			if (!PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection)
			{
				var offsetX = 0;
				var offsetY = 0;
				#if windows
				if (luaModchart != null)
				{
					offsetX = luaModchart.getVar("followXOffset", "float");
					offsetY = luaModchart.getVar("followYOffset", "float");
				}
				#end
				if (!isHeavy && !isRobo && !heya)
				    camFollow.setPosition(dad.getMidpoint().x + 150 + noteCamMovementDadX, dad.getMidpoint().y - 100 + noteCamMovementDadY);
				else if (isHeavy)
					camFollow.setPosition(dad2.getMidpoint().x + 150 + noteCamMovementDadX, dad2.getMidpoint().y - 100 + noteCamMovementDadY);
				else if (isRobo)
					camFollow.setPosition(dad2.getMidpoint().x + 150 + noteCamMovementDadX, dad2.getMidpoint().y - 100 + noteCamMovementDadY);
				else if (cantRun && curTiming == 1)
					camFollow.setPosition(sfmDemo.getMidpoint().x + 150 + noteCamMovementDadX, sfmDemo.getMidpoint().y - 100 + noteCamMovementDadY);
				#if windows
				if (luaModchart != null)
					luaModchart.executeState('playerTwoTurn', []);
				#end
				// camFollow.setPosition(lucky.getMidpoint().x - 120, lucky.getMidpoint().y + 210);

				switch (dad.curCharacter)
				{
					case 'scoutexe':
						camFollow.y = dad.getMidpoint().y - -75;
						camFollow.x = dad.getMidpoint().x - 120;
				}

			}

			if (PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection)
			{
				var offsetX = 0;
				var offsetY = 0;
				#if windows
				if (luaModchart != null)
				{
					offsetX = luaModchart.getVar("followXOffset", "float");
					offsetY = luaModchart.getVar("followYOffset", "float");
				}
				#end
				camFollow.setPosition(boyfriend.getMidpoint().x - 100 + noteCamMovementBfX, boyfriend.getMidpoint().y - 100 + noteCamMovementBfY);

				#if windows
				if (luaModchart != null)
					luaModchart.executeState('playerOneTurn', []);
				#end

				// what a HUGE switch block
				switch (curStage)
				{
					case 'entry', 'sfm-entry', 'intel':
						camFollow.y = boyfriend.getMidpoint().y - 200 + noteCamMovementBfY;
					case 'barnblitz-demo', 'barnblitz-engi', 'honor':
						camFollow.y = boyfriend.getMidpoint().y - 200 + noteCamMovementBfY;
						camFollow.x = boyfriend.getMidpoint().x - 250 + noteCamMovementBfX;
					case 'barnblitz-heavy':
						camFollow.y = boyfriend.getMidpoint().y - 250 + noteCamMovementBfY;
						camFollow.x = boyfriend.getMidpoint().x - 300 + noteCamMovementBfX;
					case 'snake-sniper', 'snake-medic', 'sax', 'void':
						camFollow.y = boyfriend.getMidpoint().y - 150 + noteCamMovementBfY;
						camFollow.x = boyfriend.getMidpoint().x - 200 + noteCamMovementBfX;
					case 'snake-spy':
						camFollow.y = boyfriend.getMidpoint().y - 200 + noteCamMovementBfY;
						camFollow.x = boyfriend.getMidpoint().x - 200 + noteCamMovementBfX;
					case 'exe':
						camFollow.y = boyfriend.getMidpoint().y - 700;
						camFollow.x = boyfriend.getMidpoint().x - 900;
					case 'degroot':
						camFollow.y = boyfriend.getMidpoint().y - 225 + noteCamMovementBfY;
						camFollow.x = boyfriend.getMidpoint().x - 250 + noteCamMovementBfX;
				}
				switch (SONG.player1)
				{
					case 'medic-bf':
						camFollow.x = boyfriend.getMidpoint().x - 300 + noteCamMovementBfX;
						camFollow.y = boyfriend.getMidpoint().y - -15 + noteCamMovementBfY;
					case 'engi':
						camFollow.x = boyfriend.getMidpoint().x - 300 + noteCamMovementBfX;
						camFollow.y = boyfriend.getMidpoint().y - -25 + noteCamMovementBfY;
				}
			}
		}

		if (boyfriend.animation.curAnim.name.startsWith('idle'))
		{
			noteCamMovementBfY = 0;
			noteCamMovementBfX = 0;
		}

		if (dad.animation.curAnim.name.startsWith('idle'))
		{
			noteCamMovementDadY = 0;
			noteCamMovementDadX = 0;
		}
		if (camZooming)
		{
			if (FlxG.save.data.zoom < 0.8)
				FlxG.save.data.zoom = 0.8;
	
			if (FlxG.save.data.zoom > 1.2)
				FlxG.save.data.zoom = 1.2;
			if (!executeModchart)
				{
					FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, 0.95);
					camHUD.zoom = FlxMath.lerp(FlxG.save.data.zoom, camHUD.zoom, 0.95);
	
					camNotes.zoom = camHUD.zoom;
					camSustains.zoom = camHUD.zoom;
				}
				else
				{
					FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, 0.95);
					camHUD.zoom = FlxMath.lerp(1, camHUD.zoom, 0.95);
	
					camNotes.zoom = camHUD.zoom;
					camSustains.zoom = camHUD.zoom;
				}
		}

		FlxG.watch.addQuick("beatShit", curBeat);
		FlxG.watch.addQuick("stepShit", curStep);

		if (curSong == 'Atomicpunch')
			{
				// too lazy to do tweens for this, might make it a function later -tob
				switch (curStep)
				{
					case 64:
						camHUD.visible = true;
					case 448:
						if (!cope){
						PlayStateChangeables.scrollSpeed = 3;
						curScroll = PlayStateChangeables.scrollSpeed;
						}
					case 704:
						if (!cope){
						PlayStateChangeables.scrollSpeed = 2.5;
						curScroll = PlayStateChangeables.scrollSpeed;
						}
					case 832:
						if (!cope){
						PlayStateChangeables.scrollSpeed = 3.1;
						curScroll = PlayStateChangeables.scrollSpeed;
						}
					case 864:
						if (!cope){
						PlayStateChangeables.scrollSpeed = 2.6;
						curScroll = PlayStateChangeables.scrollSpeed;
						}
					case 880:
						if (!cope){
						PlayStateChangeables.scrollSpeed = 3.2;
						curScroll = PlayStateChangeables.scrollSpeed;
						}
					case 896:
						if (!cope){						
							PlayStateChangeables.scrollSpeed = 3.1;
						    curScroll = PlayStateChangeables.scrollSpeed;
					    }
					case 928:
						if (!cope){
						    PlayStateChangeables.scrollSpeed = 2.6;
						    curScroll = PlayStateChangeables.scrollSpeed;
						}
					case 944:
						if (!cope){
						    PlayStateChangeables.scrollSpeed = 3.2;
						    curScroll = PlayStateChangeables.scrollSpeed;
					    }
					case 992:
						if (!cope){
						    PlayStateChangeables.scrollSpeed = 2.5;
						    curScroll = PlayStateChangeables.scrollSpeed;
						}
					case 1072:
						if (!cope){
						    PlayStateChangeables.scrollSpeed = 3;
						    curScroll = PlayStateChangeables.scrollSpeed;
						}
				}
			}

			if (curSong == 'Maggots')
			{
				switch (curStep)
				{
					case 320:
						if (!inCutscene)
						    camHUD.visible = true;
				}
			}

		if (chatTxt.overlaps(usernameTxt))
			{
				chatTxt.x += 1;
			}

		if (curSong == 'Monochrome')
		{
			notes.forEachAlive(function(note:Note){note.alpha = 0.7;});

			randomUsername = ['Scout'];
			randomText = ["I'm dead!"];

			for (i in cpuStrums) 
				{
					FlxTween.tween(i, {alpha: 0}, 0.1, {ease: FlxEase.linear});
					i.x = -4000;
				}
		}

		if (curSong == 'Skill Issue')
		{
			randomUsername = [
				"Sn1p3rG4M1NG",
				"SsniperxxX666",
				"xxShadowSniperxx",
				"Iamnotabot"
			];

			randomText = [
				"Git Gud M8",
				"Skill issue",
				"Problem?"
			];
		}

		if (curSong == 'Clinicaltrial') // lots of stuff
		{
			switch (curStep)
			{
				case 1023:
					isHeavy = true;
					curTiming = 1;
					stupidAHHHH = true;
					remove(dad);
					remove(dad2);
					dad = new Character(-475, 100, "medic");
					dad2 = new Character(0, 60, "heavy");
					add(dad);
					add(dad2);
					if (FlxG.save.data.flash)
					    FlxG.camera.flash(FlxColor.WHITE, 1);
					if (funkyIcon == null)
						{
							funkyIcon = new HealthIcon("heavy", false);
							funkyIcon.y = healthBar.y - (funkyIcon.height / 2);
							add(funkyIcon);
							funkyIcon.cameras = [camHUD];
							funkyIcon.x = -100;
							FlxTween.linearMotion(funkyIcon, -100, funkyIcon.y, iconP2.x, funkyIcon.y, 0.3);
							new FlxTimer().start(0.3, funnyJump);
						}
				case 1514:
					fairness = 1;
					curTiming = 2;
					remove(dad2);
					dad2 = new Character(0, 60, "heavy-uber");
					add(dad2);
					stupid = true;
				case 2027:
					remove(dad2);
					dad2 = new Character(0, 60, "heavy");
					add(dad2);
					fairness = 0;
					curTiming = 0;
					stupid = false;
					stupidAHHHH = false;
				case 2120:
					remove(dad);
					dad = new Character(-475, 100, "medic"); // layering shit
					add(dad);
					dad2.visible = false;
					funnyHeavy.visible = true;
				case 2176:
					funnyHeavy.x += -55;
					remove(dad);
					dad = new Character(100, 100, "medic");
					add(dad);
					if (FlxG.save.data.flash)
					    FlxG.camera.flash(FlxColor.WHITE, 1);
					iconP2.animation.play("medic", true);
					isHeavy = false;
				case 2559:
					if (FlxG.save.data.flash)
					    FlxG.camera.flash(FlxColor.WHITE, 1);
					poopThing = true;
				case 2684:
					poopThing = false;
			}
		}

		if (curSong == 'Wanker') // only makes the hud visible
		{
			switch (curStep)
			{
				case 64:
					camHUD.visible = true;
			}
		}
		if (curSong == 'Ironcurtain') // mostly has camera bop event bell thingie
		{
			switch (curStep)
			{
				case 110:
					longSpin = true;
				case 112:
					camHUD.visible = true;
				case 140:
					longSpin = false;
				case 622:
					FlxTween.tween(camHUD, {alpha: 0}, 1.2, 
						{
							ease: FlxEase.cubeInOut,
						});
				case 640:
					camHUD.alpha = 100;
				case 768 | 960 | 1664 | 2048 | 2368:
					poopThing = false;
				case 512 | 832 | 1280 | 1920 | 2240:
					poopThing = true;
				case 1248:
					health = 0.01;
			}
		}

		/*if (curSong == 'Meet The Team')
		{
			switch (curStep)
			{
				case 256 | 6080:
					camHUD.visible = true;
					FlxG.camera.flash(FlxColor.WHITE, 1);
					iconP2.animation.play("scunt", true);
					curTiming = 1;
					remove(scout);
					scout = new Character(0, 0, 'scunt');			
					add(scout);
				case 832 | 6592:
					FlxG.camera.flash(FlxColor.WHITE, 1);
					iconP2.animation.play("soldier", true);
					curTiming = 2;
					remove(soldier);
					soldier = new Character(0, 0, 'soldier');
					add(soldier);
				case 1445 | 7231:
					curTiming = 3;
				case 1472 | 7232:
					FlxG.camera.flash(FlxColor.WHITE, 1);
					iconP2.animation.play("pyro", true);
					remove(pyro);
					pyro = new Character(0, 0, 'pyro');
					add(pyro);
				case 1984 | 7744:
					FlxG.camera.flash(FlxColor.WHITE, 1);
					iconP2.animation.play("demo", true);
					curTiming = 4;
					remove(demoman);
					demoman = new Character(0, 0, 'demo');			
					add(demoman);
				case 2496 | 8256:
					FlxG.camera.flash(FlxColor.WHITE, 1);
					iconP2.animation.play("heavy", true);
					curTiming = 5;
					remove(heavy);
					heavy = new Character(0, 0, 'heavy');			
					add(heavy);
				case 2009 | 8767:
					curTiming = 6;
				case 3007 | 8768:
					FlxG.camera.flash(FlxColor.WHITE, 1);
					iconP2.animation.play("engi", true);
					remove(engi);
					remove(roboEngi);
					engi = new Character(0, 0, 'engi');
					roboEngi = new Character(0, 0, 'robo-engi');			
					add(engi);
					add(roboEngi);					
				case 3455 | 9279:
					curTiming = 7;
				case 3520 | 9280:
					FlxG.camera.flash(FlxColor.WHITE, 1);
					iconP2.animation.play("medic", true);
					remove(medic);
					medic = new Character(0, 0, 'medic');
					add(medic);
				case 4012 | 9791:
					curTiming = 8;
				case 4032 | 9792:
					FlxG.camera.flash(FlxColor.WHITE, 1);
					iconP2.animation.play("sniper", true);
					remove(sniper);
					sniper = new Character(0, 0, 'sniper');		
					add(sniper);
				case 4482 | 10303:
					curTiming = 9;
				case 4544 | 10304:
					FlxG.camera.flash(FlxColor.WHITE, 1);
					iconP2.animation.play("spy", true);
					remove(spy);
					spy = new Character(0, 0, 'spy');			
					add(spy);
				case 11264:
					curTiming = 0;
				case 11392:
					FlxG.camera.flash(FlxColor.WHITE, 1);
					iconP2.animation.play("saxton", true);
					remove(dad);
					dad = new Character(100, 100, SONG.player2);
					add(dad);
					saxShake = true;
			}*/
		
		// if anyone sees this just add it again because its cool
		if (curSong == 'Frontierjustice')
		{
			switch (curStep)
			{
				case 400, 440, 480, 896, 952, 984, 1000, 1152:
					add(engiBOT);
				case 410, 448, 512, 640, 906, 969, 992, 1008, 1034, 1097, 1120, 1136, 1279, 1408:
					if (engiBOT != null)
					{
						remove(engiBOT);
					}

					if (bfBOT != null)
					{
						remove(bfBOT);
					}
				case 528, 568, 608, 1024, 1080, 1112, 1128, 1280:
					add(bfBOT);
			}
		}

		if (curSong == 'Inferno')
		{
			// shitty code? dont care

			switch (curStep)
			{
				case 256:
					camHUD.visible = true;
					stupidAHHHH = true;
					burnShit = true;
				case 384 | 703:
					burnShit = false;
				case 511:
					blakShit.visible = true;
					pyroland.visible = true;
					stupidAHHHH = false;
					curTiming = 1;
					camHUD.visible = false;
				case 575:
					blakShit.visible = false;
					if (FlxG.save.data.flash)
					    FlxG.camera.flash(FlxColor.WHITE, 1);
					remove(blakShit);
					infernoSwitch(1, "bf-pyroland", "pyroland", true);
				case 639:
					stupidAHHHH = true;
					burnShit = true;
					camHUD.visible = true;
				case 895 | 1279 | 1343 | 1407 | 1439:
					if (FlxG.save.data.flash)
					    FlxG.camera.flash(FlxColor.WHITE, 1);
					infernoSwitch(0, "bf-pyro", "pyro", false);
				case 1151 | 1311 | 1375 | 1423 | 1455:
					if (FlxG.save.data.flash)
					    FlxG.camera.flash(FlxColor.WHITE, 1);
					infernoSwitch(1, "bf-pyroland", "pyroland", true);
				case 1471 | 1480 | 1488 | 1496:
					infernoSwitch(0, "bf-pyro", "pyro", false);
				case 1476 | 1484 | 1492 | 1500:
					infernoSwitch(1, "bf-pyroland", "pyroland", true);
				case 1504:
					if (FlxG.save.data.flash)
					    FlxG.camera.flash(FlxColor.WHITE, 1);
					pyroland.visible = false;
					stupidAHHHH = false;
					infernoSwitch(0, "bf-pyro", "pyro", false);
			}
		}
		
		if (curSong == 'Five Minutes')// See ya in Five Minutes.
		{
			switch (curStep)
			{
				case 14:
					FlxTween.tween(dad, {alpha: 0}, 0.5, 
						{
							ease: FlxEase.cubeInOut,
						});
				case 2428:
					FlxTween.tween(dad, {alpha: 100}, 0.5, 
						{
							ease: FlxEase.cubeInOut,
						});
					
			}
		}

 		if (!inCutscene && FlxG.save.data.resetButton)
		{
			if(FlxG.keys.justPressed.R && mania != 9)
				{
					boyfriend.stunned = true;

					persistentUpdate = false;
					persistentDraw = false;
					paused = true;
		
					vocals.stop();
					FlxG.sound.music.stop();
		
					openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		
					#if windows
					// Game Over doesn't get his own variable because it's only used here
					DiscordClient.changePresence("GAME OVER -- " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy),"\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
					#end
		
					// FlxG.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
				}
		}

		if (unspawnNotes[0] != null)
		{
			if (unspawnNotes[0].strumTime - Conductor.songPosition < 3500)
			{
				var dunceNote:Note = unspawnNotes[0];
				notes.add(dunceNote);

				var index:Int = unspawnNotes.indexOf(dunceNote);
				unspawnNotes.splice(index, 1);
			}
		}

		switch(mania)
		{
			case 0: 
				sDir = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
			case 1: 
				sDir = ['LEFT', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'RIGHT'];
			case 2: 
				sDir = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'UP', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
			case 3: 
				sDir = ['LEFT', 'DOWN', 'UP', 'UP', 'RIGHT'];
			case 4: 
				sDir = ['LEFT', 'UP', 'RIGHT', 'UP', 'LEFT', 'DOWN', 'RIGHT'];
			case 5: 
				sDir = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
			case 6: 
				sDir = ['UP'];
			case 7: 
				sDir = ['LEFT', 'RIGHT'];
			case 8:
				sDir = ['LEFT', 'UP', 'RIGHT'];
			case 9: 
				sDir = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'UP', 'UP', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
		}

		if (generatedMusic)
			{
				var holdArray:Array<Bool> = [controls.LEFT, controls.DOWN, controls.UP, controls.RIGHT];

				switch(mania)
				{
					case 0: 
						holdArray = [controls.LEFT, controls.DOWN, controls.UP, controls.RIGHT];
					case 1: 
						holdArray = [controls.L1, controls.U1, controls.R1, controls.L2, controls.D1, controls.R2];
					case 2: 
						holdArray = [controls.N0, controls.N1, controls.N2, controls.N3, controls.N4, controls.N5, controls.N6, controls.N7, controls.N8];
					case 3: 
						holdArray = [controls.LEFT, controls.DOWN, controls.N4, controls.UP, controls.RIGHT];
					case 4: 
						holdArray = [controls.L1, controls.U1, controls.R1, controls.N4, controls.L2, controls.D1, controls.R2];
					case 5: 
						holdArray = [controls.N0, controls.N1, controls.N2, controls.N3, controls.N5, controls.N6, controls.N7, controls.N8];
					case 6: 
						holdArray = [controls.N4];
					case 7: 
						holdArray = [controls.LEFT, controls.RIGHT];
					case 8: 
						holdArray = [controls.LEFT, controls.N4, controls.RIGHT];
					case 9: 
						holdArray = [controls.T0, controls.T1, controls.T2, controls.T3, controls.T4, controls.T5, controls.T6, controls.T7, controls.T8, controls.T9];
				}
				notes.forEachAlive(function(daNote:Note)
				{
					if (ghostNotes && !daNote.alreadyTweened && daNote.isOnScreen()){
						if (Conductor.songPosition - daNote.strumTime < 300)
						    ghostNote(daNote);
					}
					

					// instead of doing stupid y > FlxG.height
					// we be men and actually calculate the time :)
					if (daNote.tooLate)
					{
						daNote.active = false;
						daNote.visible = false;
					}
					else
					{
						daNote.visible = true;
						daNote.active = true;
					}


					
					if (!daNote.modifiedByLua)
						{
							if (PlayStateChangeables.useDownscroll)
							{
								if (daNote.mustPress)
								{
									if (curSong == 'Trolling')
									{
										switch (curTiming)
										{
											case 0, 1, 4:
												daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
												+ 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
													2)) - daNote.noteYOff;
											case 2:
												daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
												+ 0.60 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
													2)) - daNote.noteYOff;
											case 3, 5:
												daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
												+ 0.75 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
													2)) - daNote.noteYOff;

										}
									}
									else if (daNote.noteType == 8)
									{
										daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
											+ 0.65 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
												2)) - daNote.noteYOff; // makes rocket arrows go twice as fast as normal arrows cuz they spawn farther away
									}
									else 
									{
										daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
										+ 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
											2)) - daNote.noteYOff;
									}

								}
								else
								{
									if (curSong == 'Trolling')
										{
											switch (curTiming)
											{
												case 0, 2, 3:
													daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
													+ 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
														2)) - daNote.noteYOff;
												case 1:
													daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
													+ 0.60 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
														2)) - daNote.noteYOff;
												case 4, 5:
												    daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
												    + 0.75 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
													    2)) - daNote.noteYOff;
	
											}
										}
									else if (daNote.noteType == 8)
									{
										daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
											+ 0.65 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
												2)) - daNote.noteYOff; // makes rocket arrows go twice as fast as normal arrows cuz they spawn farther away
									}
									else 
									{
										daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
										+ 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
											2)) - daNote.noteYOff;

									}
								}	
								if (daNote.isSustainNote)
								{
									// Remember = minus makes notes go up, plus makes them go down
									if (daNote.animation.curAnim.name.endsWith('end') && daNote.prevNote != null)
										daNote.y += daNote.prevNote.height;
									else
										daNote.y += daNote.height / 2;
		
									// If not in botplay, only clip sustain notes when properly hit, botplay gets to clip it everytime
									if (!PlayStateChangeables.botPlay)
									{
										if ((!daNote.mustPress || daNote.wasGoodHit || daNote.prevNote.wasGoodHit || holdArray[Math.floor(Math.abs(daNote.noteData))] && !daNote.tooLate)
											&& daNote.y - daNote.offset.y * daNote.scale.y + daNote.height >= (strumLine.y + Note.swagWidth / 2))
										{
											// Clip to strumline
											var swagRect = new FlxRect(0, 0, daNote.frameWidth * 2, daNote.frameHeight * 2);
											swagRect.height = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y
												+ Note.swagWidth / 2
												- daNote.y) / daNote.scale.y;
											swagRect.y = daNote.frameHeight - swagRect.height;
		
											daNote.clipRect = swagRect;
										}
									}
									else
									{
										var swagRect = new FlxRect(0, 0, daNote.frameWidth * 2, daNote.frameHeight * 2);
										swagRect.height = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y
											+ Note.swagWidth / 2
											- daNote.y) / daNote.scale.y;
										swagRect.y = daNote.frameHeight - swagRect.height;
		
										daNote.clipRect = swagRect;
									}
								}
							}
							else
							{
								if (daNote.mustPress)
								{
									if (curSong == 'Trolling')
										{
											switch (curTiming)
											{
												case 0, 1, 4:
													daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
													- 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
														2)) - daNote.noteYOff;
												case 2:
													daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
													- 0.60 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
														2)) - daNote.noteYOff;
												case 3, 5:
													daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
													- 0.75 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
														2)) - daNote.noteYOff;
	
											}
										}
									else if (daNote.noteType == 8)
									{
										daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
											- 0.65 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
												2)) + daNote.noteYOff; // makes rocket arrows go twice as fast as normal arrows cuz they spawn farther away
									}
									else 
									{
										daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
										- 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
											2)) + daNote.noteYOff;
									}
								}
								else
								{
									if (curSong == 'Trolling')
										{
											switch (curTiming)
											{
												case 0, 2, 3:
													daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
													- 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
														2)) - daNote.noteYOff;
												case 1:
													daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
													- 0.60 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
														2)) - daNote.noteYOff;
												case 4, 5:
												    daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
												    - 0.75 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
													    2)) - daNote.noteYOff;
	
											}
										}
									else if (daNote.noteType == 8)
									{
										daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
											- 0.65 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
												2)) + daNote.noteYOff; // makes rocket arrows go twice as fast as normal arrows cuz they spawn farther away
									}
									else 
									{
										daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
										- 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
											2)) + daNote.noteYOff;
									}
								}
								if (daNote.isSustainNote)
								{
									daNote.y -= daNote.height / 2;
		
									if (!PlayStateChangeables.botPlay)
									{
										if ((!daNote.mustPress || daNote.wasGoodHit || daNote.prevNote.wasGoodHit || holdArray[Math.floor(Math.abs(daNote.noteData))] && !daNote.tooLate)
											&& daNote.y + daNote.offset.y * daNote.scale.y <= (strumLine.y + Note.swagWidth / 2))
										{
											// Clip to strumline
											var swagRect = new FlxRect(0, 0, daNote.width / daNote.scale.x, daNote.height / daNote.scale.y);
											swagRect.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y
												+ Note.swagWidth / 2
												- daNote.y) / daNote.scale.y;
											swagRect.height -= swagRect.y;
		
											daNote.clipRect = swagRect;
										}
									}
									else
									{
										var swagRect = new FlxRect(0, 0, daNote.width / daNote.scale.x, daNote.height / daNote.scale.y);
										swagRect.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y
											+ Note.swagWidth / 2
											- daNote.y) / daNote.scale.y;
										swagRect.height -= swagRect.y;
		
										daNote.clipRect = swagRect;
									}
								}
							}
						}
		
	
					if (!daNote.mustPress && daNote.wasGoodHit)
					{
						if (FlxG.save.data.epl && SONG.player2 == 'saxton' && SONG.song == 'Property Damage' || saxShake && FlxG.save.data.epl)
							FlxG.camera.shake(0.04,0.04);
						if (SONG.song != 'Tutorial' && !songIsWeird)
							camZooming = true;
						if (FlxG.save.data.epl && soldierShake)
							FlxG.camera.shake(0.015,0.04);
						if (curSong == 'Honorbound' && health >= 0.1)
							health -= 0.02;
						if (SONG.notes[Math.floor(curStep / 16)] != null)
						{
							if (SONG.notes[Math.floor(curStep / 16)].altAnim)
								altAnim = '-alt';
							else
								altAnim = '';
						}	
						if (daNote.alt)
							altAnim = '-alt';
						if (SONG.notes[Math.floor(curStep / 16)] != null)
						{
							if (SONG.notes[Math.floor(curStep / 16)].beamAnim)
								beamAnim = '-beam';
						}
						
						if (!PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection && FlxG.save.data.stupid && curSong != 'Monochrome' && curSong != 'Frontierjustice' && curSong != 'Eyelander')
						{
							switch (curSong)
							{
								case 'Property Damage':
								{
									switch (Math.abs(daNote.noteData))
									{
										case 5:
											noteCamMovementDadX = 45;
											noteCamMovementDadY = 0;
										case 4:
											noteCamMovementDadX = 0;
											noteCamMovementDadY = 45;
										case 2:
											noteCamMovementDadX = 45;
											noteCamMovementDadY = 0;
										case 3:
											noteCamMovementDadX = -45;
											noteCamMovementDadY = 0;
										case 1:
											noteCamMovementDadY = -45;
											noteCamMovementDadX = 0;
										case 0:
											noteCamMovementDadX = -45;
											noteCamMovementDadY = 0;
									}
								}
								default:
								{
									switch (Math.abs(daNote.noteData))
									{
										case 2:
											noteCamMovementDadY = -45;
											noteCamMovementDadX = 0;
										case 3:
											noteCamMovementDadX = 45;
											noteCamMovementDadY = 0;
										case 1:
											noteCamMovementDadY = 45;
											noteCamMovementDadX = 0;
										case 0:
											noteCamMovementDadX = -45;
											noteCamMovementDadY = 0;
									}
								}

							}

						}

						if (roboDad)                   // :( -tob
						{								// because ur mother -heat
							if (mania == 5 || mania == 9) // why mania 9 heat??? -tob    
								{							
									var targ:Character = dad;
									if (daNote.noteType == 3)
									{
										targ = dad;
									}
									else if (daNote.noteType == 2)
									{
										targ = dad2;
									}
									
	
									targ.playAnim('sing' + sDir[daNote.noteData] + altAnim + beamAnim, true);
							}
						}
						else if (heavyDad)
						{
								var targ:Character = dad;
								if (daNote.noteType == 2)
								{
									targ = dad2;
								}
								else if (daNote.noteType == 3)
								{
									targ = dad;
								}
	

								switch (curTiming)
								{
									case 2:
										targ.playAnim('sing' + sDir[daNote.noteData] + '-alt', true);
									default:
										targ.playAnim('sing' + sDir[daNote.noteData] , true);

								}
						}
						else
						{
							switch (swaggyOptim)
							{
								case 3:
									switch (curTiming)
									{
										case 0:
											if (!slashThingie)
											    dad.playAnim('sing' + sDir[daNote.noteData] + altAnim, true);
										case 1:
											if (!slashThingie)
											    dad.playAnim('sing' + sDir[daNote.noteData] + '-alt', true);
									}
								case 4:
									if (daNote.noteType == 3)
										dad.playAnim('singDOWN-alt', true);
									else
										dad.playAnim('sing' + sDir[daNote.noteData] + altAnim, true);
								case 5:
									switch (curTiming)
									{
										case 0:
											    dad.playAnim('sing' + sDir[daNote.noteData] , true);
										case 1:
											    sfmDemo.playAnim('sing' + sDir[daNote.noteData] , true);
									}
								default:
									dad.playAnim('sing' + sDir[daNote.noteData] + altAnim, true);
							}
						}


	
							/*if (daNote.isSustainNote)
							{
								health -= SONG.noteValues[0] / 3;
							}
							else
								health -= SONG.noteValues[0];
							*/
							
							if (shitPoo)
							{
								cpuStrums.forEach(function(spr:FlxSprite)
								{
									if (Math.abs(daNote.noteData) == spr.ID)
									{
										spr.animation.play('confirm', true);
									}
									if (spr.animation.curAnim.name == 'confirm' && !curStage.startsWith('school'))
									{
										spr.centerOffsets();
	
										switch(mania)
										{
											case 0: 
												spr.offset.x -= 13;
												spr.offset.y -= 13;
											case 1: 
												spr.offset.x -= 16;
												spr.offset.y -= 16;
											case 2: 
												spr.offset.x -= 22;
												spr.offset.y -= 22;
											case 3: 
												spr.offset.x -= 15;
												spr.offset.y -= 15;
											case 4: 
												spr.offset.x -= 18;
												spr.offset.y -= 18;
											case 5: 
												spr.offset.x -= 20;
												spr.offset.y -= 20;
											case 6: 
												spr.offset.x -= 13;
												spr.offset.y -= 13;
											case 7: 
												spr.offset.x -= 13;
												spr.offset.y -= 13;
											case 8:
												spr.offset.x -= 13;
												spr.offset.y -= 13;
											case 9: 
												spr.offset.x -= 24;
												spr.offset.y -= 24;
										}
									}
									else
										spr.centerOffsets();
								});
							}
		
							#if windows
							if (luaModchart != null)
								luaModchart.executeState('playerTwoSing', [Math.abs(daNote.noteData), Conductor.songPosition]);
							#end
	
							dad.holdTimer = 0;
							if (heavyDad || roboDad)
							{
								dad2.holdTimer = 0;
							}
							else if (cantRun)
							{
								sfmDemo.holdTimer = 0;
							}
	
							if (SONG.needsVoices)
								vocals.volume = 1;
		
							daNote.active = false;
	
	
							daNote.kill();
							notes.remove(daNote, true);
							daNote.destroy();
					
					}

					if (daNote.mustPress && !daNote.modifiedByLua)
						{
							daNote.visible = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].visible;
							daNote.x = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].x;
							if (!daNote.isSustainNote)
								daNote.modAngle = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].angle;
							if (daNote.sustainActive)
							{
								if (executeModchart && SONG.song != 'Infiltrator' && SONG.song != 'Monochrome') // need to override this so ghost notes work -heat
									daNote.alpha = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].alpha;
							}
							daNote.modAngle = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].angle;
						}
						else if (!daNote.wasGoodHit && !daNote.modifiedByLua)
						{
							daNote.visible = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].visible;
							daNote.x = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].x;
							if (!daNote.isSustainNote)
								daNote.modAngle = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].angle;
							if (daNote.sustainActive)
							{
								if (executeModchart && SONG.song != 'Infiltrator' && SONG.song != 'Monochrome')
									daNote.alpha = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].alpha;
							}
							daNote.modAngle = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].angle;
						}
		
						if (daNote.isSustainNote)
						{
							daNote.x += daNote.width / 2 + 20;
							if (SONG.noteStyle == 'pixel')
								daNote.x -= 11;
						}

					

					//trace(daNote.y);
					// WIP interpolation shit? Need to fix the pause issue
					// daNote.y = (strumLine.y - (songTime - daNote.strumTime) * (0.45 * PlayState.SONG.speed));
	
					if (daNote.isSustainNote && daNote.wasGoodHit && Conductor.songPosition >= daNote.strumTime)
						{
							daNote.kill();
							notes.remove(daNote, true);
							daNote.destroy();
						}
					else if ((daNote.mustPress && daNote.tooLate && !PlayStateChangeables.useDownscroll || daNote.mustPress && daNote.tooLate
						&& PlayStateChangeables.useDownscroll)
						&& daNote.mustPress)
					{

							switch (daNote.noteType)
							{
						
								case 0 | 6 | 7 | 8 | 10 | 12: //normal + drunk + rocket + my big fat cock -tob
								{
									if (daNote.isSustainNote && daNote.wasGoodHit)
										{
											daNote.kill();
											notes.remove(daNote, true);
										}
										else
										{
											if (loadRep && daNote.isSustainNote)
											{
												// im tired and lazy this sucks I know i'm dumb
												if (findByTime(daNote.strumTime) != null)
													totalNotesHit += 1;
												else
												{
													vocals.volume = 0;
													if (theFunne && !daNote.isSustainNote)
													{
														noteMiss(daNote.noteData, daNote);
													}
													if (daNote.isParent)
													{
														health -= 0.15; // give a health punishment for failing a LN
														//trace("hold fell over at the start");
														for (i in daNote.children)
														{
															i.alpha = 0.3;
															i.sustainActive = false;
														}
													}
													else
													{
														if (!daNote.wasGoodHit
															&& daNote.isSustainNote
															&& daNote.sustainActive
															&& daNote.spotInLine != daNote.parent.children.length)
														{
															health -= 0.2; // give a health punishment for failing a LN
															//trace("hold fell over at " + daNote.spotInLine);
															for (i in daNote.parent.children)
															{
																i.alpha = 0.3;
																i.sustainActive = false;
															}
															if (daNote.parent.wasGoodHit)
																misses++;
															updateAccuracy();
														}
														else if (!daNote.wasGoodHit
															&& !daNote.isSustainNote)
														{
															health -= 0.15;
														}
													}
												}
											}
											else
											{
												vocals.volume = 0;
												if (theFunne && !daNote.isSustainNote)
												{
													if (PlayStateChangeables.botPlay)
													{
														daNote.rating = "bad";
														goodNoteHit(daNote);
													}
													else
														noteMiss(daNote.noteData, daNote);
												}
				
												if (daNote.isParent)
												{
													health -= 0.15; // give a health punishment for failing a LN
													trace("hold fell over at the start");
													for (i in daNote.children)
													{
														i.alpha = 0.3;
														i.sustainActive = false;
														//trace(i.alpha);
													}
												}
												else
												{
													if (!daNote.wasGoodHit
														&& daNote.isSustainNote
														&& daNote.sustainActive
														&& daNote.spotInLine != daNote.parent.children.length)
													{
														health -= 0.25; // give a health punishment for failing a LN
														trace("hold fell over at " + daNote.spotInLine);
														for (i in daNote.parent.children)
														{
															i.alpha = 0.3;
															i.sustainActive = false;
															//trace(i.alpha);
														}
														if (daNote.parent.wasGoodHit)
															misses++;
														updateAccuracy();
													}
													else if (!daNote.wasGoodHit
														&& !daNote.isSustainNote)
													{
														health -= 0.15;
													}
												}
											}
										}
				
										daNote.visible = false;
										daNote.kill();
										notes.remove(daNote, true);
								}
								case 1 | 2 | 3 | 4 | 6 | 9 | 11:  // everything else
								{
									daNote.kill();
									notes.remove(daNote, true);
									daNote.destroy();
								}
							}
						}
						if(PlayStateChangeables.useDownscroll && daNote.y > strumLine.y ||
							!PlayStateChangeables.useDownscroll && daNote.y < strumLine.y)
							{
									// Force good note hit regardless if it's too late to hit it or not as a fail safe
									if(PlayStateChangeables.botPlay && daNote.canBeHit && daNote.mustPress ||
									PlayStateChangeables.botPlay && daNote.tooLate && daNote.mustPress)
									{
										if(loadRep)
										{
											//trace('ReplayNote ' + tmpRepNote.strumtime + ' | ' + tmpRepNote.direction);
											var n = findByTime(daNote.strumTime);
											//trace(n);
											if(n != null)
											{
												goodNoteHit(daNote);
												boyfriend.holdTimer = daNote.sustainLength;
											}
										}
										else 
											{
											if (!daNote.disguise && !daNote.bonk && !daNote.huntsman && !daNote.saw)
												{
													goodNoteHit(daNote);
													boyfriend.holdTimer = daNote.sustainLength;
													if (shitPoo)
														{
															playerStrums.forEach(function(spr:FlxSprite)
															{
																if (Math.abs(daNote.noteData) == spr.ID && Note.hitCheck == 0)
																{
																	spr.animation.play('confirm', false);
																}
																if (spr.animation.curAnim.name == 'confirm' && SONG.noteStyle != 'pixel')
																{
																	spr.centerOffsets();
																	switch(mania)
																	{
																		case 0: 
																			spr.offset.x -= 13;
																			spr.offset.y -= 13;
																		case 1: 
																			spr.offset.x -= 16;
																			spr.offset.y -= 16;
																		case 2: 
																			spr.offset.x -= 22;
																			spr.offset.y -= 22;
																		case 3: 
																			spr.offset.x -= 15;
																			spr.offset.y -= 15;
																		case 4: 
																			spr.offset.x -= 18;
																			spr.offset.y -= 18;
																		case 5: 
																			spr.offset.x -= 20;
																			spr.offset.y -= 20;
																		case 6: 
																			spr.offset.x -= 13;
																			spr.offset.y -= 13;
																		case 7: 
																			spr.offset.x -= 13;
																			spr.offset.y -= 13;
																		case 8:
																			spr.offset.x -= 13;
																			spr.offset.y -= 13;
																		case 9: 
																			spr.offset.x -= 24;
																			spr.offset.y -= 24;
																	}
																}
																else
																	spr.centerOffsets();
															});
														}
												}
											}
											
									}
							}
								
					
				});
				
			}

		if (shitPoo)
		{
			cpuStrums.forEach(function(spr:FlxSprite)
			{
				if (spr.animation.finished)
				{
					spr.animation.play('static');
					spr.centerOffsets();
				}
			});
			if (PlayStateChangeables.botPlay)
				{
					playerStrums.forEach(function(spr:FlxSprite)
						{
							if (spr.animation.finished)
							{
								spr.animation.play('static');
								spr.centerOffsets();
							}
						});
				}
		}

		if (what)
			{
				funnyX *= 0.98;
				funnyY += elapsed * 6;
				if (funkyIcon != null)
				{
					funkyIcon.x += funnyX;
					funkyIcon.y += funnyY;
				}
			}

		if (!inCutscene && songStarted)
			keyShit();


		#if debug
		if (FlxG.keys.justPressed.ONE)
			endSong();
		#end
	}

	function endSong():Void
	{
		FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN,handleInput);
		FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, releaseInput);
		if (useVideo)
			{
				GlobalVideo.get().stop();
				FlxG.stage.window.onFocusOut.remove(focusOut);
				FlxG.stage.window.onFocusIn.remove(focusIn);
				PlayState.instance.remove(PlayState.instance.videoSprite);
			}

		if (isStoryMode)
			campaignMisses = misses;

		if (!loadRep)
			rep.SaveReplay(saveNotes, saveJudge, replayAna);
		else
		{
			PlayStateChangeables.botPlay = false;
			PlayStateChangeables.scrollSpeed = 1;
			PlayStateChangeables.useDownscroll = false;
		}

		if (FlxG.save.data.fpsCap > 290)
			(cast (Lib.current.getChildAt(0), Main)).setFPSCap(290);

		#if windows
		if (luaModchart != null)
		{
			luaModchart.die();
			luaModchart = null;
		}
		#end

		canPause = false;
		FlxG.sound.music.volume = 0;
		vocals.volume = 0;
		FlxG.sound.music.pause();
		vocals.pause();

		var FUCKYOU:Bool = false;
		if (curSong == 'Skill Issue')
		{
			FUCKYOU = true;
			camHUD.visible = false;
			camFollow.setPosition(dad.getMidpoint().x + 150 + noteCamMovementDadX, dad.getMidpoint().y - 100 + noteCamMovementDadY);
			new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					dad.debugMode = true;
					dad.playAnim('shot', true);
					new FlxTimer().start(0.13, function(tmr:FlxTimer)
						{
							health -= 10000000000000000; //skill issue! https://www.urbandictionary.com/define.php?term=skill%20issue
						});
				});

		}

		if (SONG.validScore)
		{
			// adjusting the highscore song name to be compatible
			// would read original scores if we didn't change packages
			var songHighscore = StringTools.replace(PlayState.SONG.song, " ", "-");
			switch (songHighscore) {
				case 'Dad-Battle': songHighscore = 'Dadbattle';
				case 'Philly-Nice': songHighscore = 'Philly';
			}

			#if !switch
			Highscore.saveScore(songHighscore, Math.round(songScore), storyDifficulty);
			Highscore.saveCombo(songHighscore, Ratings.GenerateLetterRank(accuracy), storyDifficulty);
			#end
		}

		if (offsetTesting && !FUCKYOU)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			offsetTesting = false;
			LoadingState.loadAndSwitchState(new OptionsMenu());
			FlxG.save.data.offset = offsetTest;
		}
		else if (!FUCKYOU)
		{
			if (isStoryMode)
			{
				campaignScore += Math.round(songScore);

				storyPlaylist.remove(storyPlaylist[0]);

				if (storyPlaylist.length <= 0)
				{
					transIn = FlxTransitionableState.defaultTransIn;
					transOut = FlxTransitionableState.defaultTransOut;

					paused = true;

					FlxG.sound.music.stop();
					vocals.stop();
					if (FlxG.save.data.scoreScreen)
					{
						openSubState(new ResultsScreen());
					}
					else
					{
						FlxG.sound.playMusic(Paths.music('freakyMenu'));
						FlxG.switchState(new Contract());
					}

					#if windows
					if (luaModchart != null)
					{
						luaModchart.die();
						luaModchart = null;
					}
					#end			
					if (curSong == 'Inferno')
						{
							if (FlxG.save.data.unlockedWeek == 0)
							{
								FlxG.save.data.unlockedWeek = 1;
								FlxG.save.data.buttonUnlockingShit = 3;
								trace(FlxG.save.data.unlockedWeek);
							}
						}
					else if (curSong == 'Frontierjustice')
						{
							if (FlxG.save.data.unlockedWeek == 1)
							{
								FlxG.save.data.unlockedWeek = 2;
								FlxG.save.data.buttonUnlockingShit = 6;
								trace(FlxG.save.data.unlockedWeek);
							}
						}
					else if (curSong == 'Infiltrator')
						{
							if (FlxG.save.data.unlockedWeek == 2)
							{
								FlxG.save.data.unlockedWeek = 3;
								FlxG.save.data.buttonUnlockingShit = 9;
								FlxG.save.data.unlockedBonus = true;
								trace(FlxG.save.data.unlockedWeek);
							}
						}
					else
						{
							if (curSong == 'Property Damage')
							{
								if (FlxG.save.data.unlockedWeek == 3)
								{
									FlxG.save.data.buttonUnlockingShit = 10;
									trace(FlxG.save.data.unlockedWeek);
								}
							}
						}
					StoryMenuState.weekUnlocked[Std.int(Math.min(storyWeek + 1, StoryMenuState.weekUnlocked.length - 1))] = true;

					if (SONG.validScore)
					{
						NGio.unlockMedal(60961);
						Highscore.saveWeekScore(storyWeek, campaignScore, storyDifficulty);
					}

					FlxG.save.data.weekUnlocked = StoryMenuState.weekUnlocked;
					FlxG.save.flush();
				}
				else
				{
					var songFormat = StringTools.replace(PlayState.storyPlaylist[0], " ", "-");
					switch (songFormat) {case 'Dad-Battle': songFormat = 'Dadbattle';case 'Philly-Nice': songFormat = 'Philly';}

					var poop:String = Highscore.formatSong(songFormat, storyDifficulty);

					trace('LOADING NEXT SONG');
					trace(poop);
					
					// bad code from me -tob
					switch (curSong){
						case 'Atomicpunch':if (FlxG.save.data.unlockedWeek == 0){FlxG.save.data.buttonUnlockingShit = 1;}
						case 'Maggots':if (FlxG.save.data.unlockedWeek == 0){FlxG.save.data.buttonUnlockingShit = 2;}
						case 'Ironbomber':if (FlxG.save.data.unlockedWeek == 1){FlxG.save.data.buttonUnlockingShit = 4;}
						case 'Ironcurtain':if (FlxG.save.data.unlockedWeek == 1){FlxG.save.data.buttonUnlockingShit = 5;}
						case 'Clinicaltrial':if (FlxG.save.data.unlockedWeek == 2){FlxG.save.data.buttonUnlockingShit = 7;}
						case 'Wanker':if (FlxG.save.data.unlockedWeek == 2){FlxG.save.data.buttonUnlockingShit = 8;}
					}

					FlxTransitionableState.skipNextTransIn = true;
					FlxTransitionableState.skipNextTransOut = true;
					prevCamFollow = camFollow;


					PlayState.SONG = Song.loadFromJson(poop, PlayState.storyPlaylist[0]);
					FlxG.sound.music.stop();

					LoadingState.loadAndSwitchState(new PlayState());
				}
			}
			else
			{
				trace('WENT BACK TO FREEPLAY??');

				paused = true;


				FlxG.sound.music.stop();
				vocals.stop();

				if (FlxG.save.data.scoreScreen && curSong != 'Monochrome')
				{
					openSubState(new ResultsScreen());
				}
				else
				{
					FlxG.switchState(new FreeplayState());		
				}
			}
		}
	}

	function songOutro():Void
		{
			FlxG.sound.music.volume = 0;
			vocals.volume = 0;
			canPause = false;

			if (isStoryMode)
			{
				switch (curSong.toLowerCase())
				{
					case 'atomicpunch':
						epicEnd(endingDoof);
					case 'maggots':
						epicEnd(endingDoof);
					case 'inferno':
						epicEnd(endingDoof);
					case 'ironbomber':
						epicEnd(endingDoof);
					case 'ironcurtain':
						epicEnd(endingDoof);
					case 'frontierjustice':
						epicEnd(endingDoof);
					case 'clinicaltrial':
						epicEnd(endingDoof);
					case 'wanker':
						epicEnd(endingDoof);
					case 'infiltrator':
						epicEnd(endingDoof);
					default:
						endSong();
				}
			}
			else
				{
					switch (curSong.toLowerCase())
					{
						default:
							endSong();
					}
				}
				
		}


	var endingSong:Bool = false;

	var hits:Array<Float> = [];
	var offsetTest:Float = 0;

	var timeShown = 0;
	var currentTimingShown:FlxText = null;

	private function popUpScore(daNote:Note):Void
		{
			var noteDiff:Float = -(daNote.strumTime - Conductor.songPosition);
			var wife:Float = EtternaFunctions.wife3(-noteDiff, Conductor.timeScale);
			// boyfriend.playAnim('hey');
			vocals.volume = 1;
			var placement:String = Std.string(combo);

			var healthGainGood:Float;
			var healthGainSick:Float;
	
			var coolText:FlxText = new FlxText(0, 0, 0, placement, 32);
			coolText.screenCenter();
			coolText.x = FlxG.width * 0.55;
			coolText.y -= 350;
			coolText.cameras = [camHUD];
			//
	
			var rating:FlxSprite = new FlxSprite();
			var score:Float = 350;

			if (FlxG.save.data.accuracyMod == 1)
				totalNotesHit += wife;

			var daRating = daNote.rating;
			if (!stupid){
				if (curSong == 'Property Damage'){healthGainGood = 0.02;healthGainSick = 0.05;}
				else{healthGainGood = 0.04;healthGainSick = 0.1;}
			}else{
				healthGainGood = 0;
				healthGainSick = 0;
			}

			switch(daRating)
			{
				case 'shit':
					score = -300;
					combo = 0;
					misses++;
					if (!FlxG.save.data.gthm)
						health += 0.01 / saxtonShit;
					ss = false;
					shits++;
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit -= 1;
				case 'bad':
					daRating = 'bad';
					score = 0;
					if (!FlxG.save.data.gthm)
						health += 0.02 / saxtonShit;
					ss = false;
					bads++;
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 0.50;
				case 'good':
					daRating = 'good';
					score = 200;
					ss = false;
					goods++;
					if (health < 2)
						health += healthGainGood;
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 0.75;
				case 'sick':
					if (health < 2)
						health += healthGainSick;
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 1;
					sicks++;
			}

			// trace('Wife accuracy loss: ' + wife + ' | Rating: ' + daRating + ' | Score: ' + score + ' | Weight: ' + (1 - wife));

			if (daRating != 'shit' || daRating != 'bad')
				{
	
	
			songScore += Math.round(score);
			songScoreDef += Math.round(ConvertScore.convertScore(noteDiff));
	
			/* if (combo > 60)
					daRating = 'sick';
				else if (combo > 12)
					daRating = 'good'
				else if (combo > 4)
					daRating = 'bad';
			 */
	
			var pixelShitPart1:String = "";
			var pixelShitPart2:String = '';
	
		/*if (curStage.startsWith('school'))
			{
				pixelShitPart1 = 'weeb/pixelUI/';
				pixelShitPart2 = '-pixel';
			}*/
	
			rating.loadGraphic(Paths.image(pixelShitPart1 + daRating + pixelShitPart2));
			rating.screenCenter();
			rating.y -= 50;
			if (SONG.song == 'Property Damage')
				rating.x = coolText.x - 525;
			else if (SONG.song == 'Monochrome')
				rating.x = coolText.x - 1000; // make sure its offscreen -tob
			else
				rating.x = coolText.x - 125;
			
			if (FlxG.save.data.changedHit)
			{
				rating.x = FlxG.save.data.changedHitX;
				rating.y = FlxG.save.data.changedHitY;
			}
			rating.acceleration.y = 550;
			rating.velocity.y -= FlxG.random.int(140, 175);
			rating.velocity.x -= FlxG.random.int(0, 10);
			
			var msTiming = HelperFunctions.truncateFloat(noteDiff, 3);
			if(PlayStateChangeables.botPlay && !loadRep) msTiming = 0;		
			
			if (loadRep)
				msTiming = HelperFunctions.truncateFloat(findByTime(daNote.strumTime)[3], 3);

			if (currentTimingShown != null)
				remove(currentTimingShown);

			// why does this shit exist
			currentTimingShown = new FlxText(0,0,0,"0ms");
			timeShown = 0;
			switch(daRating)
			{
				case 'shit' | 'bad':
					currentTimingShown.color = FlxColor.RED;
				case 'good':
					currentTimingShown.color = FlxColor.GREEN;
				case 'sick':
					currentTimingShown.color = FlxColor.CYAN;
			}
			currentTimingShown.borderStyle = OUTLINE;
			currentTimingShown.borderSize = 1;
			currentTimingShown.borderColor = FlxColor.BLACK;
			currentTimingShown.text = msTiming + "ms";
			currentTimingShown.size = 20;

			if (msTiming >= 0.03 && offsetTesting)
			{
				//Remove Outliers
				hits.shift();
				hits.shift();
				hits.shift();
				hits.pop();
				hits.pop();
				hits.pop();
				hits.push(msTiming);

				var total = 0.0;

				for(i in hits)
					total += i;
				

				
				offsetTest = HelperFunctions.truncateFloat(total / hits.length,2);
			}

			if (currentTimingShown.alpha != 1)
				currentTimingShown.alpha = 1;

			if(!PlayStateChangeables.botPlay || loadRep) add(currentTimingShown);
			
			var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'combo' + pixelShitPart2));
			comboSpr.screenCenter();
			comboSpr.x = rating.x;
			comboSpr.y = rating.y + 100;
			comboSpr.acceleration.y = 600;
			comboSpr.velocity.y -= 150;
			if (SONG.song == 'Monochrome')
			    comboSpr.visible = false;

			currentTimingShown.screenCenter();
			currentTimingShown.x = comboSpr.x + 100;
			currentTimingShown.y = rating.y + 100;
			currentTimingShown.acceleration.y = 600;
			currentTimingShown.velocity.y -= 150;

			if (SONG.song == 'Monochrome')
			{
				currentTimingShown.x = comboSpr.x - 1000;
			}
	
			comboSpr.velocity.x += FlxG.random.int(1, 10);
			currentTimingShown.velocity.x += comboSpr.velocity.x;
			if(!PlayStateChangeables.botPlay || loadRep) add(rating);
	
			if (!curStage.startsWith('school'))
			{
				rating.setGraphicSize(Std.int(rating.width * 0.7));
				rating.antialiasing = FlxG.save.data.antialiasing;
				comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.7));
				comboSpr.antialiasing = FlxG.save.data.antialiasing;
			}
			else
			{
				rating.setGraphicSize(Std.int(rating.width * daPixelZoom * 0.7));
				comboSpr.setGraphicSize(Std.int(comboSpr.width * daPixelZoom * 0.7));
			}
	
			currentTimingShown.updateHitbox();
			comboSpr.updateHitbox();
			rating.updateHitbox();
	
			currentTimingShown.cameras = [camHUD];
			comboSpr.cameras = [camHUD];
			rating.cameras = [camHUD];

			var seperatedScore:Array<Int> = [];
	
			var comboSplit:Array<String> = (combo + "").split('');

			if (combo > highestCombo)
				highestCombo = combo;

			// make sure we have 3 digits to display (looks weird otherwise lol)
			if (comboSplit.length == 1)
			{
				seperatedScore.push(0);
				seperatedScore.push(0);
			}
			else if (comboSplit.length == 2)
				seperatedScore.push(0);

			for(i in 0...comboSplit.length)
			{
				var str:String = comboSplit[i];
				seperatedScore.push(Std.parseInt(str));
			}
	
			var daLoop:Int = 0;
			for (i in seperatedScore)
			{
				var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'num' + Std.int(i) + pixelShitPart2));
				numScore.screenCenter();
				numScore.x = rating.x + (43 * daLoop) - 50;
				numScore.y = rating.y + 100;
				numScore.cameras = [camHUD];

				if (!curStage.startsWith('school'))
				{
					numScore.antialiasing = FlxG.save.data.antialiasing;
					numScore.setGraphicSize(Std.int(numScore.width * 0.5));
				}
				else
				{
					numScore.setGraphicSize(Std.int(numScore.width * daPixelZoom));
				}
				numScore.updateHitbox();
	
				numScore.acceleration.y = FlxG.random.int(200, 300);
				numScore.velocity.y -= FlxG.random.int(140, 160);
				numScore.velocity.x = FlxG.random.float(-5, 5);
	
				add(numScore);

				visibleCombos.push(numScore);

				FlxTween.tween(numScore, {alpha: 0}, 0.2, {
					onComplete: function(tween:FlxTween)
					{
						visibleCombos.remove(numScore);
						numScore.destroy();
					},
					onUpdate: function (tween:FlxTween)
					{
						if (!visibleCombos.contains(numScore))
						{
							tween.cancel();
							numScore.destroy();
						}
					},
					startDelay: Conductor.crochet * 0.002
				});

				if (visibleCombos.length > seperatedScore.length + 20)
				{
					for(i in 0...seperatedScore.length - 1)
					{
						visibleCombos.remove(visibleCombos[visibleCombos.length - 1]);
					}
				}
	
				daLoop++;
			}
			/* 
				trace(combo);
				trace(seperatedScore);
			 */
	
			coolText.text = Std.string(seperatedScore);
			// add(coolText);
	
			FlxTween.tween(rating, {alpha: 0}, 0.2, {
				startDelay: Conductor.crochet * 0.001,
				onUpdate: function(tween:FlxTween)
				{
					if (currentTimingShown != null)
						currentTimingShown.alpha -= 0.02;
					timeShown++;
				}
			});

			FlxTween.tween(comboSpr, {alpha: 0}, 0.2, {
				onComplete: function(tween:FlxTween)
				{
					coolText.destroy();
					comboSpr.destroy();
					if (currentTimingShown != null && timeShown >= 20)
					{
						remove(currentTimingShown);
						currentTimingShown = null;
					}
					rating.destroy();
				},
				startDelay: Conductor.crochet * 0.001
			});
	
			curSection += 1;
			}
		}

	public function NearlyEquals(value1:Float, value2:Float, unimportantDifference:Float = 10):Bool
		{
			return Math.abs(FlxMath.roundDecimal(value1, 1) - FlxMath.roundDecimal(value2, 1)) < unimportantDifference;
		}

		var upHold:Bool = false;
		var downHold:Bool = false;
		var rightHold:Bool = false;
		var leftHold:Bool = false;
		var l1Hold:Bool = false;
		var uHold:Bool = false;
		var r1Hold:Bool = false;
		var l2Hold:Bool = false;
		var dHold:Bool = false;
		var r2Hold:Bool = false;
	
		var n0Hold:Bool = false;
		var n1Hold:Bool = false;
		var n2Hold:Bool = false;
		var n3Hold:Bool = false;
		var n4Hold:Bool = false;
		var n5Hold:Bool = false;
		var n6Hold:Bool = false;
		var n7Hold:Bool = false;
		var n8Hold:Bool = false;

		var t0Hold:Bool = false;
		var t1Hold:Bool = false;
		var t2Hold:Bool = false;
		var t3Hold:Bool = false;
		var t4Hold:Bool = false;
		var t5Hold:Bool = false;
		var t6Hold:Bool = false;
		var t7Hold:Bool = false;
		var t8Hold:Bool = false;
		var t9Hold:Bool = false;
		// THIS FUNCTION JUST FUCKS WIT HELD NOTES AND BOTPLAY/REPLAY (also gamepad shit)

		private function keyShit():Void // I've invested in emma stocks
			{
				// FNF VS QT MOD CODE
				if (curSong == 'Maggots')
				{
					if (FlxG.keys.justPressed.SPACE && !bfDodging && bfCanDodge)
						bfDodging = true;
					else if (FlxG.keys.justPressed.SPACE && !bfDodging && !bfCanDodge && !PlayStateChangeables.botPlay)
						badNoteHit(); //punishment for dodging when the player is not allowed to -heat
				}

				// control arrays, order L D R U
				var holdArray:Array<Bool> = [controls.LEFT, controls.DOWN, controls.UP, controls.RIGHT];
				var pressArray:Array<Bool> = [
					controls.LEFT_P,
					controls.DOWN_P,
					controls.UP_P,
					controls.RIGHT_P

				];
				var releaseArray:Array<Bool> = [
					controls.LEFT_R,
					controls.DOWN_R,
					controls.UP_R,
					controls.RIGHT_R
				];
				switch(mania)
				{
					case 0: 
						holdArray = [controls.LEFT, controls.DOWN, controls.UP, controls.RIGHT];
						pressArray = [
							controls.LEFT_P,
							controls.DOWN_P,
							controls.UP_P,
							controls.RIGHT_P
						];
						releaseArray = [
							controls.LEFT_R,
							controls.DOWN_R,
							controls.UP_R,
							controls.RIGHT_R
						];
					case 1: 
						holdArray = [controls.L1, controls.U1, controls.R1, controls.L2, controls.D1, controls.R2];
						pressArray = [
							controls.L1_P,
							controls.U1_P,
							controls.R1_P,
							controls.L2_P,
							controls.D1_P,
							controls.R2_P
						];
						releaseArray = [
							controls.L1_R,
							controls.U1_R,
							controls.R1_R,
							controls.L2_R,
							controls.D1_R,
							controls.R2_R
						];
					case 2: 
						holdArray = [controls.N0, controls.N1, controls.N2, controls.N3, controls.N4, controls.N5, controls.N6, controls.N7, controls.N8];
						pressArray = [
							controls.N0_P,
							controls.N1_P,
							controls.N2_P,
							controls.N3_P,
							controls.N4_P,
							controls.N5_P,
							controls.N6_P,
							controls.N7_P,
							controls.N8_P
						];
						releaseArray = [
							controls.N0_R,
							controls.N1_R,
							controls.N2_R,
							controls.N3_R,
							controls.N4_R,
							controls.N5_R,
							controls.N6_R,
							controls.N7_R,
							controls.N8_R
						];
					case 3: 
						holdArray = [controls.LEFT, controls.DOWN, controls.N4, controls.UP, controls.RIGHT];
						pressArray = [
							controls.LEFT_P,
							controls.DOWN_P,
							controls.N4_P,
							controls.UP_P,
							controls.RIGHT_P
						];
						releaseArray = [
							controls.LEFT_R,
							controls.DOWN_R,
							controls.N4_R,
							controls.UP_R,
							controls.RIGHT_R
						];
					case 4: 
						holdArray = [controls.L1, controls.U1, controls.R1, controls.N4, controls.L2, controls.D1, controls.R2];
						pressArray = [
							controls.L1_P,
							controls.U1_P,
							controls.R1_P,
							controls.N4_P,
							controls.L2_P,
							controls.D1_P,
							controls.R2_P
						];
						releaseArray = [
							controls.L1_R,
							controls.U1_R,
							controls.R1_R,
							controls.N4_R,
							controls.L2_R,
							controls.D1_R,
							controls.R2_R
						];
					case 5: 
						holdArray = [controls.N0, controls.N1, controls.N2, controls.N3, controls.N5, controls.N6, controls.N7, controls.N8];
						pressArray = [
							controls.N0_P,
							controls.N1_P,
							controls.N2_P,
							controls.N3_P,
							controls.N5_P,
							controls.N6_P,
							controls.N7_P,
							controls.N8_P
						];
						releaseArray = [
							controls.N0_R,
							controls.N1_R,
							controls.N2_R,
							controls.N3_R,
							controls.N5_R,
							controls.N6_R,
							controls.N7_R,
							controls.N8_R
						];
					case 6: 
						holdArray = [controls.N4];
						pressArray = [
							controls.N4_P
						];
						releaseArray = [
							controls.N4_R
						];
					case 7: 
						holdArray = [controls.LEFT, controls.RIGHT];
						pressArray = [
							controls.LEFT_P,
							controls.RIGHT_P
						];
						releaseArray = [
							controls.LEFT_R,
							controls.RIGHT_R
						];
					case 8:
						holdArray = [controls.LEFT, controls.N4, controls.RIGHT];
						pressArray = [
							controls.LEFT_P,
							controls.N4_P,
							controls.RIGHT_P
						];
						releaseArray = [
							controls.LEFT_R,
							controls.N4_R,
							controls.RIGHT_R
						];
					case 9: 
						holdArray = [controls.T0, controls.T1, controls.T2, controls.T3, controls.T4, controls.T5, controls.T6, controls.T7, controls.T8, controls.T9];
						pressArray = [
							controls.T0_P,
							controls.T1_P,
							controls.T2_P,
							controls.T3_P,
							controls.T4_P,
							controls.T5_P,
							controls.T6_P,
							controls.T7_P,
							controls.T8_P,
							controls.T9_P
						];
						releaseArray = [
							controls.T0_R,
							controls.T1_R,
							controls.T2_R,
							controls.T3_R,
							controls.T4_R,
							controls.T5_R,
							controls.T6_R,
							controls.T7_R,
							controls.T8_R,
							controls.T9_R
						];
				}
				#if windows
				if (luaModchart != null)
				{
					for (i in 0...pressArray.length) {
						if (pressArray[i] == true) {
						luaModchart.executeState('keyPressed', [sDir[i].toLowerCase()]);
						}
					};
					
					for (i in 0...releaseArray.length) {
						if (releaseArray[i] == true) {
						luaModchart.executeState('keyReleased', [sDir[i].toLowerCase()]);
						}
					};
					
				};
				#end
				
		 
				
				// Prevent player input if botplay is on
				if(PlayStateChangeables.botPlay)
				{
					holdArray = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
					pressArray = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
					releaseArray = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
				} 

				var anas:Array<Ana> = [null,null,null,null];
				switch(mania)
				{
					case 0: 
						anas = [null,null,null,null];
					case 1: 
						anas = [null,null,null,null,null,null];
					case 2: 
						anas = [null,null,null,null,null,null,null,null,null];
					case 3: 
						anas = [null,null,null,null,null];
					case 4: 
						anas = [null,null,null,null,null,null,null];
					case 5: 
						anas = [null,null,null,null,null,null,null,null];
					case 6: 
						anas = [null];
					case 7: 
						anas = [null,null];
					case 8: 
						anas = [null,null,null];
					case 9: 
						anas = [null,null,null,null,null,null,null,null,null,null];
				}

				for (i in 0...pressArray.length)
					if (pressArray[i])
						anas[i] = new Ana(Conductor.songPosition, null, false, "miss", i);

				// HOLDS, check for sustain notes
				if (holdArray.contains(true) && /*!boyfriend.stunned && */ generatedMusic)
				{
					notes.forEachAlive(function(daNote:Note)
					{
						if (daNote.isSustainNote && daNote.canBeHit && daNote.mustPress && holdArray[daNote.noteData])
							goodNoteHit(daNote);
					});
				} //gt hero input shit, using old code because i can
				if (controls.GTSTRUM)
				{
					if (pressArray.contains(true) && /*!boyfriend.stunned && */ generatedMusic && FlxG.save.data.gthm || holdArray.contains(true) && /*!boyfriend.stunned && */ generatedMusic && FlxG.save.data.gthm)
						{
							var possibleNotes:Array<Note> = [];

							var ignoreList:Array<Int> = [];
				
							notes.forEachAlive(function(daNote:Note)
							{
								if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit && !daNote.isSustainNote)
								{
									possibleNotes.push(daNote);
									possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
				
									ignoreList.push(daNote.noteData);
								}
				
							});
				
							if (possibleNotes.length > 0)
							{
								var daNote = possibleNotes[0];
				
								// Jump notes
								if (possibleNotes.length >= 2)
								{
									if (possibleNotes[0].strumTime == possibleNotes[1].strumTime)
									{
										for (coolNote in possibleNotes)
										{
											if (pressArray[coolNote.noteData] || holdArray[coolNote.noteData])
												goodNoteHit(coolNote);
											else
											{
												var inIgnoreList:Bool = false;
												for (shit in 0...ignoreList.length)
												{
													if (holdArray[ignoreList[shit]] || pressArray[ignoreList[shit]])
														inIgnoreList = true;
												}
												if (!inIgnoreList && !FlxG.save.data.ghost)
													noteMiss(1, null);
											}
										}
									}
									else if (possibleNotes[0].noteData == possibleNotes[1].noteData)
									{
										if (pressArray[daNote.noteData] || holdArray[daNote.noteData])
											goodNoteHit(daNote);
									}
									else
									{
										for (coolNote in possibleNotes)
										{
											if (pressArray[coolNote.noteData] || holdArray[coolNote.noteData])
												goodNoteHit(coolNote);
										}
									}
								}
								else // regular notes?
								{
									if (pressArray[daNote.noteData] || holdArray[daNote.noteData])
										goodNoteHit(daNote);
								}
							}
						}

					}
		 
				if (KeyBinds.gamepad && !FlxG.keys.justPressed.ANY)
				{
					// PRESSES, check for note hits
					if (pressArray.contains(true) && generatedMusic)
					{
						boyfriend.holdTimer = 0;
			
						var possibleNotes:Array<Note> = []; // notes that can be hit
						var directionList:Array<Int> = []; // directions that can be hit
						var dumbNotes:Array<Note> = []; // notes to kill later
						var directionsAccounted:Array<Bool> = [false,false,false,false]; // we don't want to do judgments for more than one presses
						
						switch(mania)
						{
							case 0: 
								directionsAccounted = [false, false, false, false];
							case 1: 
								directionsAccounted = [false, false, false, false, false, false];
							case 2: 
								directionsAccounted = [false, false, false, false, false, false, false, false, false];
							case 3: 
								directionsAccounted = [false, false, false, false, false];
							case 4: 
								directionsAccounted = [false, false, false, false, false, false, false];
							case 5: 
								directionsAccounted = [false, false, false, false, false, false, false, false];
							case 6: 
								directionsAccounted = [false];
							case 7: 
								directionsAccounted = [false, false];
							case 8: 
								directionsAccounted = [false, false, false];
							case 9: 
								directionsAccounted = [false, false, false, false, false, false, false, false, false, false];
						}
						

						notes.forEachAlive(function(daNote:Note)
							{
								if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit && !directionsAccounted[daNote.noteData])
								{
									if (directionList.contains(daNote.noteData))
										{
											directionsAccounted[daNote.noteData] = true;
											for (coolNote in possibleNotes)
											{
												if (coolNote.noteData == daNote.noteData && Math.abs(daNote.strumTime - coolNote.strumTime) < 10)
												{ // if it's the same note twice at < 10ms distance, just delete it
													// EXCEPT u cant delete it in this loop cuz it fucks with the collection lol
													dumbNotes.push(daNote);
													break;
												}
												else if (coolNote.noteData == daNote.noteData && daNote.strumTime < coolNote.strumTime)
												{ // if daNote is earlier than existing note (coolNote), replace
													possibleNotes.remove(coolNote);
													possibleNotes.push(daNote);
													break;
												}
											}
										}
										else
										{
											directionsAccounted[daNote.noteData] = true;
											possibleNotes.push(daNote);
											directionList.push(daNote.noteData);
										}
								}
						});

						for (note in dumbNotes)
						{
							FlxG.log.add("killing dumb ass note at " + note.strumTime);
							note.kill();
							notes.remove(note, true);
							note.destroy();
						}
			
						possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
						var hit = [false,false,false,false,false,false,false,false,false];
						switch(mania)
						{
							case 0: 
								hit = [false, false, false, false];
							case 1: 
								hit = [false, false, false, false, false, false];
							case 2: 
								hit = [false, false, false, false, false, false, false, false, false];
							case 3: 
								hit = [false, false, false, false, false];
							case 4: 
								hit = [false, false, false, false, false, false, false];
							case 5: 
								hit = [false, false, false, false, false, false, false, false];
							case 6: 
								hit = [false];
							case 7: 
								hit = [false, false];
							case 8: 
								hit = [false, false, false];
							case 9: 
								hit = [false, false, false, false, false, false, false, false, false, false];
						}
						if (perfectMode)
							goodNoteHit(possibleNotes[0]);
						else if (possibleNotes.length > 0)
						{
							if (!FlxG.save.data.ghost)
								{
									for (i in 0...pressArray.length)
										{ // if a direction is hit that shouldn't be
											if (pressArray[i] && !directionList.contains(i))
												noteMiss(i, null);
										}
								}
							if (FlxG.save.data.gthm)
							{
	
							}
							else
							{
								for (coolNote in possibleNotes)
									{
										if (pressArray[coolNote.noteData] && !hit[coolNote.noteData])
										{
											if (mashViolations != 0)
												mashViolations--;
											hit[coolNote.noteData] = true;
											scoreTxt.color = FlxColor.WHITE;
											var noteDiff:Float = -(coolNote.strumTime - Conductor.songPosition);
											anas[coolNote.noteData].hit = true;
											anas[coolNote.noteData].hitJudge = Ratings.CalculateRating(noteDiff, Math.floor((PlayStateChangeables.safeFrames / 60) * 1000));
											anas[coolNote.noteData].nearestNote = [coolNote.strumTime,coolNote.noteData,coolNote.sustainLength];
											goodNoteHit(coolNote);
										}
									}
							}
							
						};
						if (boyfriend.holdTimer > Conductor.stepCrochet * 4 * 0.001 && (!holdArray.contains(true) || PlayStateChangeables.botPlay))
							{
								if (boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.animation.curAnim.name.endsWith('miss') && 
									(boyfriend.animation.curAnim.curFrame >= 10 || boyfriend.animation.curAnim.finished) && !bfDodging && !boyfriend.animation.curAnim.name.endsWith('hit'))
									boyfriend.playAnim('idle');
							}
						else if (!FlxG.save.data.ghost)
							{
								for (shit in 0...keyAmmo[mania])
									if (pressArray[shit])
										noteMiss(shit, null);
							}
					}

					if (!loadRep)
						for (i in anas)
							if (i != null)
								replayAna.anaArray.push(i); // put em all there
				}
					
				
				if (boyfriend.holdTimer > Conductor.stepCrochet * 4 * 0.001 && (!holdArray.contains(true) || PlayStateChangeables.botPlay))
				{
					if (boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.animation.curAnim.name.endsWith('miss') && !bfDodging && !boyfriend.animation.curAnim.name.endsWith('hit'))
						boyfriend.playAnim('idle');
				}
		 
				if (!PlayStateChangeables.botPlay)
				{
					playerStrums.forEach(function(spr:FlxSprite)
					{
						if (keys[spr.ID] && spr.animation.curAnim.name != 'confirm' && spr.animation.curAnim.name != 'pressed' && Note.hitCheck == 0)
							spr.animation.play('pressed', false);
						if (!keys[spr.ID])
							spr.animation.play('static', false);
			
						if (spr.animation.curAnim.name == 'confirm' && !curStage.startsWith('school'))
						{
							spr.centerOffsets();
							switch(mania)
							{
								case 0: 
									spr.offset.x -= 13;
									spr.offset.y -= 13;
								case 1: 
									spr.offset.x -= 16;
									spr.offset.y -= 16;
								case 2: 
									spr.offset.x -= 22;
									spr.offset.y -= 22;
								case 3: 
									spr.offset.x -= 15;
									spr.offset.y -= 15;
								case 4: 
									spr.offset.x -= 18;
									spr.offset.y -= 18;
								case 5: 
									spr.offset.x -= 20;
									spr.offset.y -= 20;
								case 6: 
									spr.offset.x -= 13;
									spr.offset.y -= 13;
								case 7: 
									spr.offset.x -= 13;
									spr.offset.y -= 13;
								case 8:
									spr.offset.x -= 13;
									spr.offset.y -= 13;
								case 9: 
									spr.offset.x -= 22;
									spr.offset.y -= 20;
							}
						}
						else
							spr.centerOffsets();
					});
				}
			}

			public function findByTime(time:Float):Array<Dynamic>
				{
					for (i in rep.replay.songNotes)
					{
						//trace('checking ' + Math.round(i[0]) + ' against ' + Math.round(time));
						if (i[0] == time)
							return i;
					}
					return null;
				}

			public function findByTimeIndex(time:Float):Int
				{
					for (i in 0...rep.replay.songNotes.length)
					{
						//trace('checking ' + Math.round(i[0]) + ' against ' + Math.round(time));
						if (rep.replay.songNotes[i][0] == time)
							return i;
					}
					return -1;
				}

			public var fuckingVolume:Float = 1;
			public var useVideo = false;

			public static var webmHandler:WebmHandler;

			public var playingDathing = false;

			public var videoSprite:FlxSprite;

			public function focusOut() {
				if (paused)
					return;
				persistentUpdate = false;
				persistentDraw = true;
				paused = true;
		
					if (FlxG.sound.music != null)
					{
						FlxG.sound.music.pause();
						vocals.pause();
					}
		
				if (SONG.song == 'Trolling'){resetWindow();}

				openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
			}
			public function focusIn() 
			{ 
				// nada 
			}


			public function backgroundVideo(source:String) // for background videos
				{
					#if cpp
					useVideo = true;
			
					FlxG.stage.window.onFocusOut.add(focusOut);
					FlxG.stage.window.onFocusIn.add(focusIn);

					var ourSource:String = "assets/videos/daWeirdVid/dontDelete.webm";
					//WebmPlayer.SKIP_STEP_LIMIT = 90;
					var str1:String = "WEBM SHIT"; 
					webmHandler = new WebmHandler();
					webmHandler.source(ourSource);
					webmHandler.makePlayer();
					webmHandler.webm.name = str1;
			
					GlobalVideo.setWebm(webmHandler);

					GlobalVideo.get().source(source);
					GlobalVideo.get().clearPause();
					if (GlobalVideo.isWebm)
					{
						GlobalVideo.get().updatePlayer();
					}
					GlobalVideo.get().show();
			
					if (GlobalVideo.isWebm)
					{
						GlobalVideo.get().restart();
					} else {
						GlobalVideo.get().play();
					}
					
					var data = webmHandler.webm.bitmapData;
			
					videoSprite = new FlxSprite(-470,-30).loadGraphic(data);
			
					videoSprite.setGraphicSize(Std.int(videoSprite.width * 1.2));
			
					remove(gf);
					remove(boyfriend);
					remove(dad);
					add(videoSprite);
					add(gf);
					add(boyfriend);
					add(dad);
			
					trace('poggers');
			
					if (!songStarted)
						webmHandler.pause();
					else
						webmHandler.resume();
					#end
				}


	function noteMiss(direction:Int = 1, daNote:Note):Void
	{
		if (!boyfriend.stunned)
		{
			switch (daNote.noteType)
			{
				case 6:
					health -= 500;
					FlxG.sound.play(Paths.sound('pow'));
				case 7:
				{
					tweenCam(1.55, 1);
					shakeCam = true;
					FlxG.sound.play(Paths.sound('A'));
					health += -1;
					boyfriend.playAnim('hit', true);
	
					new FlxTimer().start(2, function(tmr:FlxTimer)
						{
							shakeCam = false;
							tweenCam(defaultCamZoom, 0.8);
						});
				}
				case 8:
					health += -0.85;
					boyfriend.playAnim('hit', true);
				case 10:
					health += -0.8;
					boyfriend.playAnim('hit', true);
				case 12:
					health = 0;
				default:
				{
					if (curSong == 'Property Damage')
						{
							health -=0.08;
							if (!bfDodging)
								boyfriend.playAnim('sing' + sDir[direction] + 'miss', true);
						}
					else if (!boyfriend.animOffsets.exists('singUPmiss') || !boyfriend.animOffsets.exists('singLEFTmiss') || !boyfriend.animOffsets.exists('singDOWNmiss') || !boyfriend.animOffsets.exists('singRIGHTmiss'))
						{
							health -=0.04;
							boyfriend.visible = false;
							boyfriend.playAnim('singUP', true);

							new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									boyfriend.visible = true;
								});

						}
					else
						{
							health -=0.04;
							if (!bfDodging)
								boyfriend.playAnim('sing' + sDir[direction] + 'miss', true);
						}
				}
			}
					if (combo > 5 && gf.animOffsets.exists('sad'))
						{
							gf.playAnim('sad');
						}
						combo = 0;
						misses++;
			
						if (daNote != null)
						{
							if (!loadRep)
							{
								saveNotes.push([daNote.strumTime,0,direction,166 * Math.floor((PlayState.rep.replay.sf / 60) * 1000) / 166]);
								saveJudge.push("miss");
							}
						}
						else
							if (!loadRep)
							{
								saveNotes.push([Conductor.songPosition,0,direction,166 * Math.floor((PlayState.rep.replay.sf / 60) * 1000) / 166]);
								saveJudge.push("miss");
							}	
			
						if (FlxG.save.data.accuracyMod == 1)
							totalNotesHit -= 1;
			
						songScore -= 10;
			
						
						#if windows
						if (luaModchart != null)
							luaModchart.executeState('playerOneMiss', [direction, Conductor.songPosition]);
						#end
			
			
						daNote.kill();
						notes.remove(daNote, true);
						daNote.destroy();

						updateAccuracy();
			
		    }
	}

	/*function badNoteCheck()
		{
			// just double pasting this shit cuz fuk u
			// REDO THIS SYSTEM!
			var upP = controls.UP_P;
			var rightP = controls.RIGHT_P;
			var downP = controls.DOWN_P;
			var leftP = controls.LEFT_P;
	
			if (leftP)
				noteMiss(0);
			if (upP)
				noteMiss(2);
			if (rightP)
				noteMiss(3);
			if (downP)
				noteMiss(1);
			updateAccuracy();
		}
	*/
	function updateAccuracy() 
		{
			totalPlayed += 1;
			accuracy = Math.max(0,totalNotesHit / totalPlayed * 100);
			accuracyDefault = Math.max(0, totalNotesHitDefault / totalPlayed * 100);
		}


	function getKeyPresses(note:Note):Int
	{
		var possibleNotes:Array<Note> = []; // copypasted but you already know that

		notes.forEachAlive(function(daNote:Note)
		{
			if (daNote.canBeHit && daNote.mustPress)
			{
				possibleNotes.push(daNote);
				possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
			}
		});
		if (possibleNotes.length == 1)
			return possibleNotes.length + 1;
		return possibleNotes.length;
	}
	
	var mashing:Int = 0;
	var mashViolations:Int = 0;

	var etternaModeScore:Int = 0;

	function noteCheck(controlArray:Array<Bool>, note:Note):Void // sorry lol
		{
			var noteDiff:Float = -(note.strumTime - Conductor.songPosition);

			note.rating = Ratings.CalculateRating(noteDiff, Math.floor((PlayStateChangeables.safeFrames / 60) * 1000));

			/* if (loadRep)
			{
				if (controlArray[note.noteData])
					goodNoteHit(note, false);
				else if (rep.replay.keyPresses.length > repPresses && !controlArray[note.noteData])
				{
					if (NearlyEquals(note.strumTime,rep.replay.keyPresses[repPresses].time, 4))
					{
						goodNoteHit(note, false);
					}
				}
			} */
			
			if (controlArray[note.noteData])
			{
				goodNoteHit(note, (mashing > getKeyPresses(note)));
				
				/*if (mashing > getKeyPresses(note) && mashViolations <= 2)
				{
					mashViolations++;

					goodNoteHit(note, (mashing > getKeyPresses(note)));
				}
				else if (mashViolations > 2)
				{
					// this is bad but fuck you
					playerStrums.members[0].animation.play('static');
					playerStrums.members[1].animation.play('static');
					playerStrums.members[2].animation.play('static');
					playerStrums.members[3].animation.play('static');
					health -= 0.4;
					trace('mash ' + mashing);
					if (mashing != 0)
						mashing = 0;
				}
				else
					goodNoteHit(note, false);*/

			}
		}

		function goodNoteHit(note:Note, resetMashViolation = true):Void
			{

				if (mashing != 0)
					mashing = 0;

				var noteDiff:Float = -(note.strumTime - Conductor.songPosition);

				if(loadRep)
				{
					noteDiff = findByTime(note.strumTime)[3];
					note.rating = rep.replay.songJudgements[findByTimeIndex(note.strumTime)];
				}
				else
					note.rating = Ratings.CalculateRating(noteDiff);

				if (note.rating == "miss")
					return;	


				// add newest note to front of notesHitArray
				// the oldest notes are at the end and are removed first
				if (!note.isSustainNote)
					notesHitArray.unshift(Date.now());

				if (!resetMashViolation && mashViolations >= 1)
					mashViolations--;

				if (mashViolations < 0)
					mashViolations = 0;

				if (!note.wasGoodHit)
				{
					if (!note.isSustainNote)
					{
						popUpScore(note);
						combo += 1;
					}
					else
					{
						if (!stupid) // no illegal health gain -tob
						{
						    health += 0.02;
						    totalNotesHit += 1;
						}
					}
					
					if (PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection && FlxG.save.data.stupid && curSong != 'Monochrome' && curSong != 'Frontierjustice' && curSong != 'Eyelander')
					{
						switch (curSong)
						{
							case 'Property Damage':
							{
								switch (Math.abs(note.noteData))
								{
									case 5:
										noteCamMovementBfX = 45;
										noteCamMovementBfY = 0;
									case 4:
										noteCamMovementBfX = 0;
										noteCamMovementBfY = 45;
									case 2:
										noteCamMovementBfX = 45;
										noteCamMovementBfY = 0;
									case 3:
										noteCamMovementBfX = -45;
										noteCamMovementBfY = 0;
									case 1:
										noteCamMovementBfY = -45;
										noteCamMovementBfX = 0;
									case 0:
										noteCamMovementBfX = -45;
										noteCamMovementBfY = 0;
								}
							}
							default:
							{
								switch (Math.abs(note.noteData))
								{
									case 2:
										noteCamMovementBfY = -45;
										noteCamMovementBfX = 0;
									case 3:
										noteCamMovementBfX = 45;
										noteCamMovementBfY = 0;
									case 1:
										noteCamMovementBfY = 45;
										noteCamMovementBfX = 0;
									case 0:
										noteCamMovementBfX = -45;
										noteCamMovementBfY = 0;
								}
							}

						}
					}

					if (note.alt)
						altAnim = '-alt';

					if (note.fist || note.dad1)
						boyfriend.playAnim('dodge', true);
					else if (note.dad2)
						boyfriend.playAnim('hey', true);
					else if (!boyfriend.animation.curAnim.name.startsWith('dodge') && boyfriend.animation.curAnim.name != null)
						boyfriend.playAnim('sing' + sDir[note.noteData], true);


					boyfriend.holdTimer = 0;

		
					#if windows
					if (luaModchart != null)
						luaModchart.executeState('playerOneSing', [note.noteData, Conductor.songPosition]);
					#end

					if (note.disguise) {//disguise
						if (curSong == 'You Cant Run')
						    instaKill(false);
						else
							instaKill(true);
					}

					if (note.snoiper) //GOOD SHOT MATE!
						{
							dad.playAnim('shot', true);
						    trace("GOOD SHOT MATE!");
						}
					if (note.bonk) // bonk
						{
							if (!antiStack)
								{
									boink();
								}
								else
								{
									//pass
								}
						}
					if (note.fist) // POW! HAHAH!
						{
							dad.playAnim('singRIGHT', true);
							boyfriend.playAnim('dodge', true);
							if (FlxG.save.data.funniSounds)
							    FlxG.sound.play(Paths.sound('pow'));

							health += 0.1;
						    //trace("pow! haha!");
						}
					if (note.drunk) // drunk
						{
							if (FlxG.save.data.funniSounds)
							    FlxG.sound.play(Paths.sound('burp'));

						    health += 0.3;
						}
					if (note.rocket) // rocket
						    health += 0.1;

					if (note.huntsman)
						{
							dad.playAnim('singRIGHT', true);
							if (FlxG.save.data.funniSounds)
							    FlxG.sound.play(Paths.sound('smipr')); // :(
							Note.hitCheck++; // you should kill yourself right now!!!
							new FlxTimer().start(4, function(tmr:FlxTimer){Note.hitCheck--;});
						}
					if (note.katana)
					{
						slashThingie = true;
						if (curTiming == 0)
						    dad.playAnim('slash', true);
						else if (curTiming == 1)
						    dad.playAnim('slash-alt', true);

						new FlxTimer().start(0.8, function(tmr:FlxTimer)
							{
								slashThingie = false;
								//dad.playAnim('idle', true);
							});

						boyfriend.playAnim('dodge');
					}
					if (note.saw)
					{
						maxHealthCum(0.25);
					}
				    if (note.sex) // hi
						{
							boyfriend.playAnim('dodge', true);
							health += 0.1;
						}



					if(!loadRep && note.mustPress)
					{
						var array = [note.strumTime,note.sustainLength,note.noteData,noteDiff];
						if (note.isSustainNote)
							array[1] = -1;
						saveNotes.push(array);
						saveJudge.push(note.rating);
					}
					
					playerStrums.forEach(function(spr:FlxSprite)
					{
						if (Math.abs(note.noteData) == spr.ID)
						{
							spr.animation.play('confirm', true);
						}
					});
					
		
					if (!note.isSustainNote)
						{
							if (note.rating == "sick")
								doNoteSplash(note.x, note.y, note.noteData);

							note.kill();
							notes.remove(note, true);
							note.destroy();

						}
						else
						{
							note.wasGoodHit = true;
						}
					
					updateAccuracy();

					if (FlxG.save.data.gracetmr)
						{
							grace = true;
							new FlxTimer().start(0.15, function(tmr:FlxTimer)
							{
								grace = false;
							});
						}
					
				}
			}
		

	var fastCarCanDrive:Bool = true;


	function doNoteSplash(noteX:Float, noteY:Float, nData:Int)
		{
			var recycledNote = noteSplashes.recycle(NoteSplash);
			recycledNote.makeSplash(playerStrums.members[nData].x, playerStrums.members[nData].y, nData);
			noteSplashes.add(recycledNote);
			
		}
	
	function doFunnyTween():Void
		{
			new FlxTimer().start(0.001, function(tmr:FlxTimer)
			{
				FlxTween.tween(overlayRed, {alpha: 100}, 1, {ease: FlxEase.linear, onComplete: function (twn:FlxTween) 
					{
						FlxTween.tween(overlayRed, {alpha: 0}, 1, {ease: FlxEase.linear});
					}});		
			}, 999);
		}

	function HealthDrain():Void //code from vs bob
		{
			badNoteHit();
			new FlxTimer().start(0.01, function(tmr:FlxTimer)
			{
				health -= 0.005;
			}, 300);
		}
	function funnyWindowMoving(resizeW:Int, resizeH:Int):Void
		{
			Lib.application.window.resize(resizeW,resizeH);
			moveWindow = true;
		}
	function resetWindow():Void // reset window to normal
		{
			moveWindow = false;
			Lib.application.window.move(important[0], important[1]);
			Lib.application.window.resize(important[2], important[3]);
			FlxG.fullscreen = true;
		}
	function instaKill(instant:Bool = true):Void
		{
			if (instant){health -= 100;}
			else{new FlxTimer().start(0.01, function(tmr:FlxTimer){health -= 0.01;}, 300);}
		}
	function ghostNote(note:Note)
		{
			 if (!note.alreadyTweened)
				  FlxTween.tween(note, {alpha: 0}, (1.4 /SONG.speed), {ease:FlxEase.quadInOut}); 
		}
	function doDeathCheck():Void
	{
		if (health <= maxHealth  && !cannotDie && !infiniteUberBf && !isDead)
		{
			die();
		}
	}
	function monochromeText(timer:Int = 15, word:String = ''):Void
		{
			canPause = false;
			sexing = true;
			persistentUpdate = true;
			persistentDraw = true;
			var realTimer = timer;
			var unownState = new MonochromeShit(realTimer, word);
			unownState.win = wonMonochrome;
			unownState.lose = die;
			unownState.cameras = [camHUD];
			FlxG.autoPause = false;
			openSubState(unownState);
		}
	public function wonMonochrome():Void 
	{
		canPause = true;
		sexing = false;
	}


	public function die():Void {
		if (SONG.song.toLowerCase() == 'monochrome') {
			boyfriend.stunned = true;
			paused = true;
			
			blakShit.visible = true;
			blakShit.alpha = 1;

			FlxG.sound.music.volume = 0;
			vocals.volume = 0;
			FlxG.sound.music.pause();
			vocals.pause();

			dad.debugMode = true;
			dad.playAnim('spawn', true, true);
			dad.animation.finishCallback = function (name:String) {
				dad.visible = false;
			}

			FlxTween.tween(healthBar, {alpha: 0}, 1, {ease: FlxEase.linear, onComplete: function (twn:FlxTween) {
				healthBar.visible = false;
				healthBarBG.visible = false;
				scoreTxt.visible = false;
				iconP1.visible = false;
				iconP2.visible = false;
			}});
			FlxTween.tween(healthBarBG, {alpha: 0}, 1, {ease: FlxEase.linear});
			FlxTween.tween(scoreTxt, {alpha: 0}, 1, {ease: FlxEase.linear});
			FlxTween.tween(iconP1, {alpha: 0}, 1, {ease: FlxEase.linear});
			FlxTween.tween(iconP2, {alpha: 0}, 1, {ease: FlxEase.linear});
			for (i in playerStrums) {
				FlxTween.tween(i, {alpha: 0}, 1, {ease: FlxEase.linear});
			}

			isMonoDead = true;
		}
		else
		{
			Note.hitCheck = 0;
			boyfriend.stunned = true;

			isDead = true;
			persistentUpdate = false;
			persistentDraw = false;
			paused = true;

			vocals.stop();
			FlxG.sound.music.stop();

			if (SONG.song == 'Trolling'){resetWindow();}

			openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));

			#if windows
			// Game Over doesn't get his own variable because it's only used here
			DiscordClient.changePresence("GAME OVER -- " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy),"\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
			#end

			// FlxG.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		}
	}
	function boink():Void
		{
			add(bonkBOT);
			antiStack = true;
			stupid = true;
			if (FlxG.save.data.funniSounds)
				FlxG.sound.play(Paths.sound('drink'));     // shut up heat, you should go kill yourself right now!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			new FlxTimer().start(8, function(tmr:FlxTimer) // me when nested flx timers 
				{
					remove(bonkBOT);
					stupid = false;
					PlayStateChangeables.scrollSpeed = 1.5;
					if (FlxG.save.data.funniSounds)
						FlxG.sound.play(Paths.sound('stunScunt'));

					cope = true;

					trace("ok done");

					new FlxTimer().start(6, function(tmr:FlxTimer)
						{
							trace("scroll speed shit");
							cope = false;
							PlayStateChangeables.scrollSpeed = curScroll;

							new FlxTimer().start(1.5, function(tmr:FlxTimer)
								{
									antiStack = false;
									trace("ah hell nah stacking");
								});
						});
				});
		}
	function infernoSwitch(timing:Int, iconPl1:String, iconPl2:String, pyroLand:Bool):Void
		{
			curTiming = timing;
			iconP2.animation.play(iconPl2, true);
			iconP1.animation.play(iconPl1, true);
			pyroland.visible = pyroLand;
		}
	function maxHealthCum(newHealth:Float):Void // funny saw thing -tob
		{
			if (maxHealth < 1)
			    maxHealth += newHealth;

			remove(healthBar);
			healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8) - Std.int(healthBar.width * (maxHealth / 2)) , Std.int(healthBarBG.height - 8), this,
				'health', maxHealth, 2);
			healthBar.scrollFactor.set();
			healthBar.visible = true;
			healthBar.createFilledBar(FlxColor.fromRGB(204, 0, 0), FlxColor.fromRGB(49, 176, 209));
			remove(iconP1);
			remove(iconP2);
			add(healthBar);
			add(iconP1);
			add(iconP2);
			healthBar.cameras = [camHUD];
		}
	function funkyShake(power:Float, duration:Float):Void
		{
			if(FlxG.save.data.epl)
			    FlxG.camera.shake(power, duration);
		}

	function soldierShittingOnYou():Void
		{
			if (bfDodging || PlayStateChangeables.botPlay)
			{
				boyfriend.playAnim('dodge', true);
			}
	
			dad.playAnim('shit');

			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					if (!dad.animation.curAnim.name.startsWith('sing'))
					    dad.playAnim('idle');
				});
				
			if(!bfDodging && !PlayStateChangeables.botPlay)
			{
				health -= 0.80;
				boyfriend.playAnim('hit', true);
			} 

		}
	
	function dodgeChecking():Void{
		if (bfDodging)
			bfDodging = false;		

		bfCanDodge = true;

		if (!inCutscene)
			{
				warning.visible = true;
				new FlxTimer().start(0.8, function(deadTime:FlxTimer)
					{
						warning.visible = false;
						soldierShittingOnYou();
					});
				
				new FlxTimer().start(1.4, function(deadTime:FlxTimer)
					{
						bfDodging = false;
						bfCanDodge = false;
					});
				
			}		

	}

	function addText(txtDuration:Float = 3):Void // hi
	{
		chatUsername = randomUsername[FlxG.random.int(0, randomUsername.length -1)] + ":";
		chatText = randomText[FlxG.random.int(0, randomText.length -1)];

		usernameTxt.color = FlxG.random.bool(50) ? 0x6495ED : FlxColor.RED;
		if (curSong == 'Monochrome'){usernameTxt.color = FlxColor.RED;} 
		usernameTxt.text = chatUsername;
		chatTxt.text = chatText;

		usernameTxt.alpha = 1; 
		chatTxt.alpha = 1;

		new FlxTimer().start(3, function(tmr:FlxTimer)
			{
				FlxTween.tween(usernameTxt, {alpha:0}, 0.5);
				FlxTween.tween(chatTxt, {alpha:0}, 0.5);
			});
	}

	function badNoteHit():Void
	{
		FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
		boyfriend.playAnim('hit', false);
		health -= 0.15;
			
		new FlxTimer().start(0.4, function(tmr:FlxTimer)
		{
			boyfriend.playAnim('idle', false);
		});
	}

	function switchMania(oldMania:Int, newMania:Int) //this is unfinished and will prob crash game if run!
	{
		mania = newMania;

		/*cpuStrums.forEach(function(spr:FlxSprite)
		{					
			spr.kill();
			cpuStrums.remove(spr, true);
			spr.destroy();
		});
		playerStrums.forEach(function(spr:FlxSprite)
		{					
			spr.kill();
			playerStrums.remove(spr, true);
			spr.destroy();
		});
		strumLineNotes.forEach(function(spr:FlxSprite)
		{					
			spr.kill();
			strumLineNotes.remove(spr, true);
			spr.destroy();
		});*/

		switch(mania) 
		{
			case 0: 
				keys = [false, false, false, false];
				Note.swagWidth = 160 * 0.7;
				Note.noteScale = 0.7;
				Note.pixelnoteScale = 1;
				Note.mania = 0;
			case 1: 
				keys = [false, false, false, false, false, false];
				Note.swagWidth = 120 * 0.7;
				Note.noteScale = 0.6;
				Note.pixelnoteScale = 0.83;
				Note.mania = 1;
			case 2: 
				keys = [false, false, false, false, false, false, false, false, false];
				Note.swagWidth = 95 * 0.7;
				Note.noteScale = 0.5;
				Note.pixelnoteScale = 0.7;
				Note.mania = 2;
			case 3: 
				keys = [false, false, false, false, false];
				Note.swagWidth = 130 * 0.7;
				Note.noteScale = 0.65;
				Note.pixelnoteScale = 0.9;
				Note.mania = 3;
			case 4: 
				keys = [false, false, false, false, false, false, false];
				Note.swagWidth = 110 * 0.7;
				Note.noteScale = 0.58;
				Note.pixelnoteScale = 0.78;
				Note.mania = 4;
			case 5: 
				keys = [false, false, false, false, false, false, false, false];
				Note.swagWidth = 100 * 0.7;
				Note.noteScale = 0.55;
				Note.pixelnoteScale = 0.74;
				Note.mania = 5;
			case 6: 
				keys = [false];
				Note.swagWidth = 200 * 0.7;
				Note.noteScale = 0.7;
				Note.pixelnoteScale = 1;
				Note.mania = 6;
			case 7: 
				keys = [false, false];
				Note.swagWidth = 180 * 0.7;
				Note.noteScale = 0.7;
				Note.pixelnoteScale = 0.9;
				Note.mania = 7;
			case 8: 
				keys = [false, false, false];
				Note.swagWidth = 170 * 0.7;
				Note.noteScale = 0.7;
				Note.pixelnoteScale = 1;
				Note.mania = 8;
			case 9: 
				keys = [false, false, false, false, false, false, false, false, false, false];
				Note.swagWidth = 85 * 0.7;
				Note.noteScale = 0.5;
				Note.pixelnoteScale = 0.7;
				Note.mania = 9;
		}

		generateStaticArrows(0);
		generateStaticArrows(1);

		maniaChanged = true;

		//maniaSwitch(newMania);
	}
	
	var startedMoving:Bool = false;

	var danced:Bool = false;

	var stepOfLast = 0;

	override function stepHit()
	{
		super.stepHit();
		if (FlxG.sound.music.time > Conductor.songPosition + 20 || FlxG.sound.music.time < Conductor.songPosition - 20)
		{
			resyncVocals();
		}

		if (curSong == 'Maggots')
		{
			if (warnings.contains(curStep) && !inCutscene) // lmao if the inCutscene is removed you can get killed in the dialogue which is funny -tob
				dodgeChecking();
		}

		if (curSong == 'Infiltrator') 
			{
				switch (curStep)
				{
					case 32:
						camHUD.visible = true;
					case 509:
						//FlxG.sound.play(Paths.sound('cloak'), 1);
						FlxTween.tween(camHUD, {alpha: 0},2, 
							{
								ease: FlxEase.cubeInOut,
							});
					case 537:
						ghostNotes = true; //Ghost notes + middle scroll
						playerStrums.forEach(function(spr:FlxSprite){spr.x -= 250; trace('hi');});
						cpuStrums.forEach(function(spr:FlxSprite){spr.x -= 575;});
					case 539:
						FlxTween.tween(camHUD, {alpha: 100},2, 
							{
								ease: FlxEase.cubeInOut,
							});
					case 895:
						//FlxG.sound.play(Paths.sound('cloak'), 1);
						FlxTween.tween(camHUD, {alpha: 0},2, 
							{
								ease: FlxEase.cubeInOut,
							});
					case 930:
						ghostNotes = false; 
						cpuStrums.forEach(function(spr:FlxSprite){spr.x += 575;});
						playerStrums.forEach(function(spr:FlxSprite){spr.x += 250;});
					case 933:
						FlxTween.tween(camHUD, {alpha: 100},3, 
							{
								ease: FlxEase.cubeInOut,
							});
				}
			}

		/*if (curSong == 'Yourmom')
			{
				switch (curStep)
				{
					case 844, 1152:
						remove(dad);
						dad = new Character(100, 400, "tobmad");
						add(dad);
						iconP2.animation.play("tobmad", true);
					case 880:
						remove(dad);
						dad = new Character(100, 400, "tob");
						add(dad);
						iconP2.animation.play("tob", true);
					case 1408:
						remove(dad);
						dad = new Character(100, 400, "tobuh");
						add(dad);
						iconP2.animation.play("tobuh", true);
					case 1664:
						remove(dad);
						dad = new Character(100, 400, "tobmad");
						add(dad);
						iconP2.animation.play("tobmad", true);
						camZooming = false;
						tweenCamIn();
					case 1920:
						tweenCamOut();
				}
			}*/

		if (curSong == 'Property Damage')
		{
			switch (curStep)
			{
				case 192:
					defaultCamZoom = 0.64;
					tweenCam(0.64, 1.4);
				case 1792 | 3120 | 3328 | 3456 | 3584 | 3712:
					add(saxTrail);
				case 2175 | 3144 | 3393 | 3521 | 3649 | 3777:
					remove(saxTrail);
			}
		}

		if (curSong == 'Dispenser')
		{
			switch (curStep)
			{
				case 256:
					remove(dad);
					dad = new Character(100, 100, "soldier");
					add(dad);
					iconP2.animation.play("soldier", true);
					if (FlxG.save.data.flash)
					    FlxG.camera.flash(FlxColor.WHITE, 1);
				case 320:
					funkyShake(0.015, 4);
				case 448:
					remove(dad);
					dad = new Character(100, 100, "scunt");
/*<---nice*/		add(dad); // dad added on line 6969??????? nice!!!!!!!!!!!!!!!!!!!!!
					iconP2.animation.play("scunt", true);
					if (FlxG.save.data.flash)
					    FlxG.camera.flash(FlxColor.WHITE, 1);
				case 576:
					poopThing = true;
			}
		}

		if (curSong == 'Frontierjustice')
			{
				switch (curStep)
				{
					case 384, 896:
						camZooming = false;
						tweenCam(1.34, 0.96);
					case 512, 1024:
						camZooming = true;
						tweenCam(defaultCamZoom, 0.96);
					case 1152:
						poopThing = true;
					case 1408:
						poopThing = false;
				}
			}

		if (curSong == 'Ironcurtain')
		{
			if (fidgetspinner.contains(curStep))
				{
					if (longSpin)
					{	
						new FlxTimer().start(0.1, function(tmr:FlxTimer)
						{
							strumLineNotes.forEach(function(tospin:FlxSprite)
								{
										FlxTween.angle(tospin, 0, 360, 1.6, {ease: FlxEase.quintOut});
								});
						});
					}
					else
					{
						strumLineNotes.forEach(function(tospin:FlxSprite)
							{
									FlxTween.angle(tospin, 0, 360, 1, {ease: FlxEase.quintOut});							
							});
					}
				}		
		}

		if (curSong == 'Ironbomber')
			{
				switch (curStep)
				{
					case 124:
						camHUD.visible = true;
					case 1535:
						FlxTween.tween(camHUD, {angle: 360}, 2);
				}
			}

		if (curSong == 'Monochrome')
			{
				switch (curStep)
				{
					case 120:
						dad.visible = true;
						dad.playAnim('spawn', true);
						dad.animation.finishCallback = function (name:String) {
							dad.debugMode = false;
						}
					case 256:
						monochromeText(15);
					case 512:
						monochromeText(12);
					case 896:
						monochromeText(10);
					case 1280:
						monochromeText(10);
					case 1408:
						monochromeText(8);
					case 504, 952:
						jumpscare(0.75, true);
					case 964, 972, 980:
						jumpscare(0.38, true);
					case 1116:
						jumpscare(0.38, false);
					case 1208:
						jumpscare(0.75, false);
					case 1536:
						jumpscare(1.11, false);
				}
			}
		if (curSong == 'Trolling')
			{
				switch (curStep)
				{
					case 1024:
						funnyWindowMoving(1040, 760);
						curTiming = 1;
					case 1152, 1664:
						curTiming = 2;
					case 1280:
						resetWindow();
						curTiming = 0;
						PlayStateChangeables.scrollSpeed = 10;
					case 1527:
						PlayStateChangeables.scrollSpeed = 1;
					case 1536:
						windowVal = 1;
						funnyWindowMoving(740, 460);
					case 1792:
						curTiming = 3;
					case 1920:
						curTiming = 4;
					case 2048:
						windowVal = 2;
						funnyWindowMoving(340, 60);
						curTiming = 5;
					case 2303:
						resetWindow();
					case 2304, 2309, 2314:
						jumpscare(0.2, false, 2);
					case 2319:
						jumpscare(1.2, false, 2);
				}
			}
	

		if (curSong == 'Honorbound')
			{
				switch (curStep)
				{
					case 1264:
						songIsWeird = true;
						camZooming = false;
						tweenCam(1.3, 1);
					case 1280:
						soldierShake = true;
						curTiming = 1;
					case 1536:
						songIsWeird = false;
						soldierShake = false;
						camZooming = true;
						curTiming = 0;
						tweenCam(0.9, 1);
				}
			}

		if (curSong == 'You Cant Run')
		{
			switch (curStep)
		    {
				case 80:
					seethe = true;
					mald = true;
				case 127, 328, 1288:
					if (FlxG.save.data.flash)
					    FlxG.camera.flash(FlxColor.RED, 1);
					funkyShake(0.06, 0.3);
				case 527:
					heya = true;
					curTiming = 1;
					seethe = false;
					overlayRed.alpha = 0;
					remove(boyfriend);
					sfmBG.visible = true;
					dad.visible = false;
					sfmDemo.visible = true;
					boyfriend = new Boyfriend(770, 450, "bf-sfm");
					add(boyfriend);
				case 784:
					heya = false;
					curTiming = 0;
					seethe = true;
					remove(boyfriend);
					sfmBG.visible = false;
					dad.visible = true;
					sfmDemo.visible = false;
					boyfriend = new Boyfriend(970, 450, SONG.player1);
					add(boyfriend);
				case 1160:
					funkyShake(0.06, 0.7);
			}
		}

		/*if (curSong == 'Infiltrator')
			{
				if (clok.contains(curStep))
					{
						if (!cum)
						{
							FlxTween.tween(camHUD, {alpha: 0},2, 
								{
								
									ease: FlxEase.cubeInOut,
								});
							cum = true;
						}
						else
						{
							FlxTween.tween(camHUD, {alpha: 100},2, 
								{
									ease: FlxEase.cubeInOut,
								});
							cum = false;
						}
					}		
			}*/


		if (health > maxHealthReal)
		{
			health = maxHealthReal;
		}

		// the ending cutscenes are weird so we need this -tob
		if (stupidAHHHH && !inCutscene)
		{
			switch (curSong)
			{
				case 'Clinicaltrial':
					switch (fairness)
					{
						case 0:
							if (health >= maxHealth + 0.1)
								health += -0.01;
					    case 1:
							if (health >= maxHealth + 1)
								health += -0.01;
					}
				case 'Inferno':
					if (burnShit)						
					    health += -0.01;
					else if (!burnShit)
					    health += -0.02;
				case 'Honorbound':
					if (health >= 0.1)
					    health += -0.005;
				default:
					trace("uhhh wrong song dummy"); // <--- if youve got this on any other song you basically lag out the game on how many traces there gonna be
			}
		}

		if (isMonoDead) 
		{
			vocals.volume = 0;
			FlxG.resetState();
		}

		#if windows
		if (executeModchart && luaModchart != null)
		{
			luaModchart.setVar('curStep',curStep);
			luaModchart.executeState('stepHit',[curStep]);
		}
		#end

		if (maniaChanged) //may change to beat hit if too laggy
		{
			var frameN:Array<String> = ['purple', 'blue', 'green', 'red'];
			switch (mania)
			{
				case 1: 
					frameN = ['purple', 'green', 'red', 'yellow', 'blue', 'dark'];
				case 2: 
					frameN = ['purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'black', 'dark'];
				case 3: 
					frameN = ['purple', 'blue', 'white', 'green', 'red'];
				case 4: 
					frameN = ['purple', 'green', 'red', 'white', 'yellow', 'blue', 'dark'];
				case 5: 
					frameN = ['purple', 'blue', 'green', 'red', 'yellow', 'violet', 'black', 'dark'];
				case 6: 
					frameN = ['white'];
				case 7: 
					frameN = ['purple', 'red'];
				case 8: 
					frameN = ['purple', 'white', 'red'];
				case 9: 
					frameN = ['purple', 'blue', 'green', 'red', 'orange', 'black', 'yellow', 'violet', 'black', 'dark'];
	
			}
			notes.forEachAlive(function(daNote:Note) //so the animation changes but then it doesnt work lol
			{
				daNote.animation.play(frameN[daNote.noteData] + 'Scroll');
				if (daNote.isSustainNote && daNote.prevNote != null)
					{
						daNote.animation.play(frameN[daNote.noteData] + 'holdend');
				
						if (daNote.prevNote.isSustainNote)
						{
							daNote.prevNote.animation.play(frameN[daNote.prevNote.noteData] + 'hold');
							//prevNote.updateHitbox();
						}
					}
			});
			
		}

		// yes this updates every step. <--- ok and
		// yes this is bad
		// but i'm doing it to update misses and accuracy
		#if windows
		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;

		// Updating Discord Rich Presence (with Time Left)
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "Acc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC,true,  songLength - Conductor.songPosition);
		#end

	}


	// thank you fnf vs dave and bambi!!!!!
	function funnyJump(e:FlxTimer = null):Void
		{
			iconP2.animation.play("heavy", true);
			funkyIcon.animation.play(SONG.player2, true, false, 1);
			funnyX = -5;
			funnyY = -5;
			what = true;
		}
	function jumpscare(duration:Float, chance:Bool = false, type:Int = 1) 
		{
			switch (type){
				case 1:{
			if (chance)
			{
				if (FlxG.random.bool(50))
					{
						if (FlxG.random.bool(50))
							{
								jumpScare.visible = true;
								jumpScare.alpha = 100;
							}
						else
							{
								jumpScare2.visible = true;
								jumpScare2.alpha = 100;
							}
						camHUD.shake(0.05, duration, function()
						{
							jumpScare.alpha = 0;
							jumpScare2.alpha = 0;
						});
					}
			}
			else
			{
				if (FlxG.random.bool(50))
					{
						jumpScare.visible = true;
						jumpScare.alpha = 100;
					}
				else
					{
						jumpScare2.visible = true;
						jumpScare2.alpha = 100;
					}
				camHUD.shake(0.05, duration, function()
				{
					jumpScare.alpha = 0;
					jumpScare2.alpha = 0;
				});
			}
		    }
			case 2:
				{
					jumpScare.visible = true;
					jumpScare.alpha = 100;
					camHUD.shake(0.05, duration, function()
					{
						jumpScare.alpha = 0;
					});
				}
		    }
		}
	override function beatHit()
	{
		super.beatHit();

		if (generatedMusic)
		{
			notes.sort(FlxSort.byY, (PlayStateChangeables.useDownscroll ? FlxSort.ASCENDING : FlxSort.DESCENDING));
		}

		#if windows
		if (executeModchart && luaModchart != null)
		{
			luaModchart.setVar('curBeat',curBeat);
			luaModchart.executeState('beatHit',[curBeat]);
		}
		#end

		if (curBeat % 2 == 0 && moveWindow)
	    {
			switch (windowVal)
				{
					case 0:
						Lib.application.window.move(FlxG.random.int(100, 200), FlxG.random.int(100, 200));
					case 1:
						Lib.application.window.move(FlxG.random.int(100, 500), FlxG.random.int(100, 500));
					case 2:
						Lib.application.window.move(FlxG.random.int(100, 750), FlxG.random.int(100, 750));
				}
		}

		switch (curSong)
		{
			case 'Monochrome':
				switch (curBeat) 
				{
					case 28:
						FlxTween.tween(healthBar, {alpha: 0.4}, 3, {ease: FlxEase.linear});
						FlxTween.tween(healthBarBG, {alpha: 0.4}, 3, {ease: FlxEase.linear});
						FlxTween.tween(scoreTxt, {alpha: 0.4}, 3, {ease: FlxEase.linear});
						FlxTween.tween(iconP1, {alpha: 1}, 3, {ease: FlxEase.linear});
						FlxTween.tween(iconP2, {alpha: 1}, 3, {ease: FlxEase.linear});
						for (i in playerStrums) 
						{
							FlxTween.tween(i, {alpha: 0.7}, 3, {ease: FlxEase.linear});
						}
					case 392:
						dad.debugMode = true;
						dad.playAnim('spawn', true, true);
						dad.animation.finishCallback = function (name:String) {
							dad.visible = false;
							blakShit.visible = true;
						}
						FlxTween.tween(healthBar, {alpha: 0}, 1, {ease: FlxEase.linear});
						FlxTween.tween(healthBarBG, {alpha: 0}, 1, {ease: FlxEase.linear});
						FlxTween.tween(scoreTxt, {alpha: 0}, 1, {ease: FlxEase.linear});
						FlxTween.tween(iconP1, {alpha: 0}, 1, {ease: FlxEase.linear});
						FlxTween.tween(iconP2, {alpha: 0}, 1, {ease: FlxEase.linear});
						for (i in playerStrums) 
						{
							FlxTween.tween(i, {alpha: 0}, 1, {ease: FlxEase.linear});
						}
				}
		}


		if (SONG.notes[Math.floor(curStep / 16)] != null)
		{
			if (curBeat % 25 == 0 && !inCutscene)
			{
				switch (curSong)
				{
					case 'Skill Issue':
						addText(1.2);
					default:
						addText();
				}
				
			}

			if (SONG.notes[Math.floor(curStep / 16)].changeBPM)
			{
				Conductor.changeBPM(SONG.notes[Math.floor(curStep / 16)].bpm);
				FlxG.log.add('CHANGED BPM!');
			}
			// else
			// Conductor.changeBPM(SONG.bpm);

			//SONG.notes[Math.floor(curStep / 16)].mustHitSection
			// Dad doesnt interupt his own notes
			// dad.animation.curAnim.finished && 
			// dad.animation.curAnim.curFrame >= 5

			if (curBeat % 2 == 0)
				{
					switch (swaggyOptim)
					{
						case 1:
							{
								//if (SONG.notes[Math.floor(curStep / 16)].mustHitSection)
									//{
											switch (curTiming)
											{
												case 0:
													dad.playAnim('idle');
													dad2.playAnim('idle');
												case 1:
													dad.playAnim('idle-beam');
													dad2.playAnim('idle');
												case 2:
													dad.playAnim('idle-alt');
													dad2.playAnim('idle');
											}
									//}
							}
						case 2:
							{
								dad.dance();
								dad2.dance();
							}
						case 3:
							{
								if (SONG.notes[Math.floor(curStep / 16)].mustHitSection)
									{
										switch (curTiming)
										{
											case 0:
												dad.playAnim('idle');
											case 1:
												dad.playAnim('idle-alt');
										}
									}
							}
						case 5:
							{
								switch (curTiming)
								{
									case 0:
										dad.playAnim('idle');
									case 1:
										sfmDemo.playAnim('idle');
								}
							}
						default:
							{
								if (dad.animation.curAnim.name != null && !dad.animation.curAnim.name.startsWith("sing"))
									{
										if (!dad.animation.curAnim.name.startsWith('shit') && !dad.animation.curAnim.name.startsWith('spawn'))
											dad.playAnim('idle');
									}
								else if (dad.animation.curAnim.name != null && !dad.curCharacter.startsWith('gf') && !dad.animation.curAnim.name.startsWith("sing"))
									{
										if (!dad.animation.curAnim.name.startsWith('shit') && !dad.animation.curAnim.name.startsWith('spawn'))
											dad.playAnim('idle');
									}
							}
		
					}
				}
	    }
		// FlxG.log.add('change bpm' + SONG.notes[Std.int(curStep / 16)].changeBPM);
		wiggleShit.update(Conductor.crochet);

		if (FlxG.save.data.camzoom)
		{
			// mmmmmmmm poop
			if (poopThing)
			{
				FlxG.camera.zoom += 0.05;
				camHUD.zoom += 0.065;
			}
	
			// makes this shit cum fuck crap shit cum fuck crap shit cum fuck crap shit cum fuck crap shit cum fuck crap go away when poopThing is active
			if (camZooming && FlxG.camera.zoom < 1.35 && curBeat % 4 == 0 && !poopThing)
			{
				FlxG.camera.zoom += 0.015;
				camHUD.zoom += 0.03;
			}
	
		}

		iconP1.setGraphicSize(Std.int(iconP1.width + 30));
		iconP2.setGraphicSize(Std.int(iconP2.width + 30));
			
		iconP1.updateHitbox();
		iconP2.updateHitbox();

		if (curBeat % gfSpeed == 0)
		{
			gf.dance();
		}

		if (!boyfriend.animation.curAnim.name.startsWith("sing") && !bfDodging && !boyfriend.animation.curAnim.name.endsWith('hit'))
			{
				boyfriend.playAnim('idle');
			}
		


		switch (curStage)
		{
			case 'issue', 'issue-two', 'issue-three':
				bottomBoppers.animation.play('lol', true);
			case 'intel':
				healthBarBG.animation.play('idle', true);
		}
	}
	var curLight:Int = 0; //why do you exist
}