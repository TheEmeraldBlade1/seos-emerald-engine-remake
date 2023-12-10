package;

import openfl.display.BlendMode;
import openfl.display.BitmapData;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;

using StringTools;

class NoteSplash extends FlxSprite{

  //  public static var splashPath:String = FlxAtlasFrames.fromSparrow('assets/images/noteSplashes.png', 'assets/images/noteSplashes.xml');

    public function new(x:Float, y:Float, note:Int){

        super(x, y);
        
        var noteColor:String = "purple";
        switch(note){
            case 1:
                noteColor = "blue";
            case 2:
                noteColor = "green";
            case 3:
                noteColor = "red";
        }

        frames = Paths.getSparrowAtlas('noteSplashes');
        antialiasing = true;
        animation.addByPrefix("splash", "note impact " + FlxG.random.int(1, 2) + " " + noteColor, 24 + FlxG.random.int(-3, 4), false);
        animation.finishCallback = function(n){ kill(); }
        animation.play("splash");

        /*switch(PlayState.curStage){
            case "school" | "schoolEvil":
                frames = FlxAtlasFrames.fromSparrow('assets/images/weeb/pixelUI/noteSplashes-pixel.png', 'assets/images/weeb/pixelUI/noteSplashes-pixel.xml');
        }*/

        alpha = 0.6;

        switch(PlayState.curStage){
          /*  case "school" | "schoolEvil":
                setGraphicSize(Std.int(width * PlayState.daPixelZoom));
                antialiasing = false;
                updateHitbox();
                offset.set(width * -0.1, height * -0.1);
                var angles = [0, 90, 180, 270];
                angle = angles[FlxG.random.int(0, 3)];
                //alpha = 0.8;*/

            default:
                updateHitbox();
                offset.set(width * 0.3, height * 0.3);
                angle = FlxG.random.int(0, 359);

        }

        //blend = BlendMode.SCREEN;

    }

}