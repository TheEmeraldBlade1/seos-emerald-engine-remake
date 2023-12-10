package;

import Controls.KeyboardScheme;
import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.FlxInput;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

class OptionsKeybindsMenu extends MusicBeatState
{
	public static var instance:OptionsMenu;

	var timerCount:Float = 0;
	var maxTimerCounter:Float = 5;

	var selector:FlxText;
	var curSelected:Int = 0;

	var controlsStrings:Array<String> = [];

	private var grpControls:FlxTypedGroup<Alphabet>;

	public var acceptInput:Bool = true;
	public var setBind:Bool = false;

	var keyText:Array<String> = ["LEFT", "DOWN", "UP", "RIGHT"];
    var defaultKeys:Array<String> = ["A", "S", "W", "D", "R"];

	var keys:Array<String> = [FlxG.save.data.leftBind,
		FlxG.save.data.downBind,
		FlxG.save.data.upBind,
		FlxG.save.data.rightBind];
	
	override function create()
	{
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		controlsStrings = CoolUtil.coolStringFile("LEFT - " + FlxG.save.data.leftBind + "\nDOWN - " + FlxG.save.data.downBind + "\nUP - " + FlxG.save.data.upBind + "\nRIGHT - " + FlxG.save.data.rightBind);
		
		trace(controlsStrings);

		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...controlsStrings.length)
		{
				var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, controlsStrings[i], true, false);
				controlLabel.isMenuItem = true;
				controlLabel.targetY = i;
				grpControls.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		/*if (timerCounter > maxTimerCounter)
		timerCounter += elapsedTime;*/

		if (acceptInput){
			if (!setBind){
				if (controls.BACK){
					FlxG.switchState(new OptionsMenu());
				}
				if (controls.UP_P)
					changeSelection(-1);
				if (controls.DOWN_P)
					changeSelection(1);
			}

			if (FlxG.keys.justPressed.ENTER && !setBind)
			{
				grpControls.remove(grpControls.members[curSelected]);
				if (!setBind){
					setBind = true;
				}
			}
			else{
				if (FlxG.keys.justPressed.ANY && !FlxG.keys.justPressed.ENTER && !FlxG.keys.justPressed.ESCAPE && !FlxG.keys.justPressed.SPACE && !FlxG.keys.justPressed.LEFT && !FlxG.keys.justPressed.DOWN && !FlxG.keys.justPressed.UP && !FlxG.keys.justPressed.RIGHT && setBind){
					grpControls.remove(grpControls.members[curSelected]);
					switch(curSelected)
					{
						case 0:
							FlxG.save.data.leftBind = FlxG.keys.getIsDown()[0].ID.toString();
							var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "LEFT - " + FlxG.save.data.leftBind, true, false);
							ctrl.isMenuItem = true;
							ctrl.targetY = curSelected - 0;
							grpControls.add(ctrl);
							setBind = false;
						case 1:
							FlxG.save.data.downBind = FlxG.keys.getIsDown()[0].ID.toString();
							var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "DOWN - " + FlxG.save.data.downBind, true, false);
							ctrl.isMenuItem = true;
							ctrl.targetY = curSelected - 1;
							grpControls.add(ctrl);
							setBind = false;
						case 2:
							FlxG.save.data.upBind = FlxG.keys.getIsDown()[0].ID.toString();
							var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "UP - " + FlxG.save.data.upBind, true, false);
							ctrl.isMenuItem = true;
							ctrl.targetY = curSelected - 2;
							grpControls.add(ctrl);
							setBind = false;
						case 3:
							FlxG.save.data.rightBind = FlxG.keys.getIsDown()[0].ID.toString();
							var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "RIGHT - " + FlxG.save.data.rightBind, true, false);
							ctrl.isMenuItem = true;
							ctrl.targetY = curSelected - 3;
							grpControls.add(ctrl);
							setBind = false;
					}
				}
			}
		}
	}

	var isSettingControl:Bool = false;

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent('Fresh');
		#end
		
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}
