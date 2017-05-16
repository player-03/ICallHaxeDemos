package com.player03.demo.hierarchy;

import com.player03.demo.hierarchy.object.BasicText;
import openfl.Lib;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;

/**
 * @author Joseph Cloutier
 */
class XAndY extends Sprite {
	private static inline var FONT_SIZE:Int = 14;
	private static inline var INCREMENT:Int = 100;
	private static inline var DISTANCE_FROM_MOUSE:Int = 15;
	
	private var mouseText:BasicText;
	private var xIndicator:Shape;
	private var yIndicator:Shape;
	
	public function new() {
		super();
		
		addChild(new BasicText("x=0\ny=0", FONT_SIZE));
		
		graphics.lineStyle(1, 0x808080);
		
		for(x in 1...Math.ceil(Lib.current.stage.stageWidth / INCREMENT)) {
			graphics.moveTo(x * INCREMENT, 0);
			graphics.lineTo(x * INCREMENT, Lib.current.stage.stageHeight);
			
			var label:BasicText = new BasicText("x=" + (x * INCREMENT), FONT_SIZE);
			label.x = x * INCREMENT;
			addChild(label);
		}
		
		for(y in 1...Math.ceil(Lib.current.stage.stageHeight / INCREMENT)) {
			graphics.moveTo(0, y * INCREMENT);
			graphics.lineTo(Lib.current.stage.stageWidth, y * INCREMENT);
			
			var label:BasicText = new BasicText("y=" + (y * INCREMENT), FONT_SIZE);
			label.y = y * INCREMENT;
			addChild(label);
		}
		
		mouseText = new BasicText(FONT_SIZE + 4);
		mouseText.visible = false;
		addChild(mouseText);
		
		xIndicator = new Shape();
		xIndicator.graphics.lineStyle(1);
		xIndicator.graphics.lineTo(0, Lib.current.stage.stageHeight);
		xIndicator.visible = false;
		addChild(xIndicator);
		
		yIndicator = new Shape();
		yIndicator.graphics.lineStyle(1);
		yIndicator.graphics.lineTo(Lib.current.stage.stageWidth, 0);
		yIndicator.visible = false;
		addChild(yIndicator);
		
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onMouseMove(e:MouseEvent):Void {
		mouseText.visible = true;
		xIndicator.visible = true;
		yIndicator.visible = true;
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
	
	private function onEnterFrame(e:Event):Void {
		var mouseX:Int = Std.int(this.mouseX);
		var mouseY:Int = Std.int(this.mouseY);
		
		mouseText.text = 'x=$mouseX\ny=$mouseY';
		mouseText.x = mouseX + DISTANCE_FROM_MOUSE;
		mouseText.y = mouseY + DISTANCE_FROM_MOUSE;
		if(mouseText.x + mouseText.width > Lib.current.stage.stageWidth) {
			mouseText.x = mouseX - mouseText.width - DISTANCE_FROM_MOUSE;
		}
		if(mouseText.y + mouseText.height > Lib.current.stage.stageHeight) {
			mouseText.y = mouseY - mouseText.height - DISTANCE_FROM_MOUSE;
		}
		
		xIndicator.x = mouseX;
		yIndicator.y = mouseY;
	}
}
