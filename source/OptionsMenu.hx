package;

import Controls.KeyboardScheme;
import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

class OptionsMenu extends MusicBeatState
{
	public static var instance:OptionsMenu;

	var selector:FlxText;
	var curSelected:Int = 0;

	var curSpeed:Float = 0;

	var controlsStrings:Array<String> = [];

	private var grpControls:FlxTypedGroup<Alphabet>;
	var versionShit:FlxText;

	public var acceptInput:Bool = true;

	public var fasterSpeed:Bool = false;
	
	override function create()
	{
		curSpeed = FlxG.save.data.curSpeed;
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		controlsStrings = CoolUtil.coolStringFile("Keybinds"
		+ "\nGhost Tapping " + (FlxG.save.data.newInput ? "on" : "off") 
		+ "\nDownscroll " + (FlxG.save.data.downscroll ? 'on' : 'off') 
		+ "\nRating Mode " + (FlxG.save.data.accuracyDisplay ? "Kade" : "Psych")
		+ "\nHide Hud " + (FlxG.save.data.hideHud ? "on" : "off")
		+ "\nScroll Speed " + curSpeed
		+ "\nBotplay " + (FlxG.save.data.botPlay ? "on" : "off")
		+ "\nNote Offset " + FlxG.save.data.offset
		);
		
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


		versionShit = new FlxText(5, FlxG.height - 18, 0, "", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (acceptInput){
			if (controls.BACK){
				fasterSpeed = false;
				FlxG.save.data.curSpeed = curSpeed;
				FlxG.switchState(new MainMenuState());
			}
			if (controls.UP_P)
				changeSelection(-1);
			if (controls.DOWN_P)
				changeSelection(1);

			if (FlxG.keys.justPressed.SHIFT){
				fasterSpeed = !fasterSpeed;
			}

			if (curSelected == 5){
				versionShit.text = "0 = Song Dependent, Controls: Left Or Right, Press Shift To Go Faster, Press Shift Again To Go Slower, R To Reset";
			}else if (curSelected == 7){
				versionShit.text = "Controls: Left Or Right, Press Shift To Go Faster, Press Shift Again To Go Slower, R To Reset";
			}else{
				versionShit.text = "";
			}

			if (controls.RIGHT_P && !fasterSpeed && curSelected == 5){
				if (curSpeed > 10){
					curSpeed = 10;
				}
				if (curSpeed != 10){
					curSpeed += 0.1;
				}
				FlxG.save.data.curSpeed = curSpeed;
				grpControls.remove(grpControls.members[curSelected]);
				var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Scroll Speed " + FlxG.save.data.curSpeed, true, false);
				ctrl.isMenuItem = true;
				ctrl.targetY = curSelected - 5;
				grpControls.add(ctrl);
			}else if (controls.RIGHT && fasterSpeed && curSelected == 5){
				if (curSpeed > 10){
					curSpeed = 10;
				}
				if (curSpeed != 10){
					curSpeed += 0.1;
				}
				FlxG.save.data.curSpeed = curSpeed;
				grpControls.remove(grpControls.members[curSelected]);
				var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Scroll Speed " + FlxG.save.data.curSpeed, true, false);
				ctrl.isMenuItem = true;
				ctrl.targetY = curSelected - 5;
				grpControls.add(ctrl);
			}

			if (controls.LEFT_P && !fasterSpeed && curSelected == 5){
				if (curSpeed < 0){
					curSpeed = 0;
				}
				if (curSpeed != 0){
					curSpeed -= 0.1;
				}
				FlxG.save.data.curSpeed = curSpeed;
				grpControls.remove(grpControls.members[curSelected]);
				var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Scroll Speed " + FlxG.save.data.curSpeed, true, false);
				ctrl.isMenuItem = true;
				ctrl.targetY = curSelected - 5;
				grpControls.add(ctrl);
			}else if (controls.LEFT && fasterSpeed && curSelected == 5){
				if (curSpeed < 0){
					curSpeed = 0;
				}
				if (curSpeed != 0){
					curSpeed -= 0.1;
				}
				FlxG.save.data.curSpeed = curSpeed;
				grpControls.remove(grpControls.members[curSelected]);
				var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Scroll Speed " + FlxG.save.data.curSpeed, true, false);
				ctrl.isMenuItem = true;
				ctrl.targetY = curSelected - 5;
				grpControls.add(ctrl);
			}
			
			if (controls.RIGHT_R && !fasterSpeed && curSelected == 7){
				if (curSpeed > 9999){
					FlxG.save.data.offset = 9999;
				}
				if (curSpeed != 9999){
					FlxG.save.data.offset++;
				}
				grpControls.remove(grpControls.members[curSelected]);
				var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Note Offset " + FlxG.save.data.offset, true, false);
				ctrl.isMenuItem = true;
				ctrl.targetY = curSelected - 7;
				grpControls.add(ctrl);
			}else if (controls.RIGHT && fasterSpeed && curSelected == 7){
				if (curSpeed > 9999){
					FlxG.save.data.offset = 9999;
				}
				if (curSpeed != 9999){
					FlxG.save.data.offset++;
				}
				grpControls.remove(grpControls.members[curSelected]);
				var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Note Offset " + FlxG.save.data.offset, true, false);
				ctrl.isMenuItem = true;
				ctrl.targetY = curSelected - 7;
				grpControls.add(ctrl);
			}

			if (controls.LEFT_R && !fasterSpeed && curSelected == 7){
				if (curSpeed < -9999){
					FlxG.save.data.offset = -9999;
				}
				if (curSpeed != -9999){
					FlxG.save.data.offset--;
				}
				grpControls.remove(grpControls.members[curSelected]);
				var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Note Offset " + FlxG.save.data.offset, true, false);
				ctrl.isMenuItem = true;
				ctrl.targetY = curSelected - 7;
				grpControls.add(ctrl);
			}else if (controls.LEFT && fasterSpeed && curSelected == 7){
				if (curSpeed < -9999){
					FlxG.save.data.offset = -9999;
				}
				if (curSpeed != -9999){
					FlxG.save.data.offset--;
				}
				grpControls.remove(grpControls.members[curSelected]);
				var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Note Offset " + FlxG.save.data.offset, true, false);
				ctrl.isMenuItem = true;
				ctrl.targetY = curSelected - 7;
				grpControls.add(ctrl);
			}

			if (FlxG.keys.justPressed.R && curSelected == 5){
				curSpeed = 0;
				FlxG.save.data.curSpeed = curSpeed;
				grpControls.remove(grpControls.members[curSelected]);
				var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Scroll Speed " + FlxG.save.data.curSpeed, true, false);
				ctrl.isMenuItem = true;
				ctrl.targetY = curSelected - 5;
				grpControls.add(ctrl);
			}

			if (FlxG.keys.justPressed.R && curSelected == 7){
				FlxG.save.data.offset = 0;
				grpControls.remove(grpControls.members[curSelected]);
				var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Note Offset " + FlxG.save.data.offset, true, false);
				ctrl.isMenuItem = true;
				ctrl.targetY = curSelected - 7;
				grpControls.add(ctrl);
			}
	

			if (controls.ACCEPT && curSelected != 5 && curSelected != 7)
			{
				if (curSelected != 0 && curSelected != 5 && curSelected != 7)
					grpControls.remove(grpControls.members[curSelected]);
				switch(curSelected)
				{
					case 0:
						FlxG.switchState(new OptionsKeybindsMenu());		
					case 1:
						FlxG.save.data.newInput = !FlxG.save.data.newInput;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Ghost Tapping " + (FlxG.save.data.newInput ? "on" : "off") , true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 1;
						grpControls.add(ctrl);
					case 2:
						FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Downscroll " + (FlxG.save.data.downscroll ? 'on' : 'off') , true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 2;
						grpControls.add(ctrl);
					case 3:
						FlxG.save.data.accuracyDisplay = !FlxG.save.data.accuracyDisplay;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Rating Mode " + (FlxG.save.data.accuracyDisplay ? "Kade" : "Psych"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 3;
						grpControls.add(ctrl);
					case 4:
						FlxG.save.data.hideHud = !FlxG.save.data.hideHud;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Hide Hud " + (FlxG.save.data.hideHud ? "on" : "off"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 4;
						grpControls.add(ctrl);
					case 6:
						FlxG.save.data.botPlay = !FlxG.save.data.botPlay;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Botplay " + (FlxG.save.data.botPlay ? "on" : "off"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 6;
						grpControls.add(ctrl);
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
