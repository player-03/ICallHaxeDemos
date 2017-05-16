package com.player03.demo.hierarchy;

import com.player03.demo.hierarchy.object.BasicText;
import com.player03.demo.hierarchy.object.LabeledCircle;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;

/**
 * @author Joseph Cloutier
 */
class MovingContainer extends Sprite {
	private static inline var WIDTH:Float = 400;
	private static inline var HEIGHT:Float = 300;
	private static inline var RADIUS:Float = 50;
	private static inline var FRAME_WIDTH:Float = 40;
	
	private var positionText:BasicText;
	
	public function new() {
		super();
		
		graphics.beginFill(0xDD9933);
		graphics.drawRect(-FRAME_WIDTH, -FRAME_WIDTH,
			WIDTH + 2 * FRAME_WIDTH, HEIGHT + 2 * FRAME_WIDTH);
		graphics.beginFill(0xEEEEEE);
		graphics.drawRect(0, 0, WIDTH, HEIGHT);
		graphics.endFill();
		
		/*graphics.lineStyle(1);
		graphics.moveTo(-FRAME_WIDTH, 0);
		graphics.lineTo(WIDTH + FRAME_WIDTH, 0);
		graphics.moveTo(0, -FRAME_WIDTH);
		graphics.lineTo(0, HEIGHT + FRAME_WIDTH);*/
		
		positionText = new BasicText(16);
		positionText.x = -FRAME_WIDTH;
		positionText.y = -FRAME_WIDTH;
		addChild(positionText);
		
		x = FRAME_WIDTH;
		y = FRAME_WIDTH;
		
		updatePositionText();
		
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	private function onMouseDown(e:MouseEvent):Void {
		if(e.target == this) {
			if(e.localX >= 0 && e.localX <= WIDTH
					&& e.localY >= 0 && e.localY <= HEIGHT) {
				var circle:LabeledCircle = new LabeledCircle(RADIUS, 25);
				circle.x = e.localX;
				circle.y = e.localY;
				circle.label = "x=" + Std.int(circle.x) + "\ny=" + Std.int(circle.y);
				circle.removeOnClick();
				addChild(circle);
			} else {
				startDrag(false, new Rectangle(FRAME_WIDTH, FRAME_WIDTH,
					stage.stageWidth - WIDTH - FRAME_WIDTH * 2,
					stage.stageHeight - HEIGHT - FRAME_WIDTH * 2));
				positionText.visible = false;
			}
		}
	}
	
	private function onMouseUp(e:MouseEvent):Void {
		stopDrag();
		
		if(!positionText.visible) {
			positionText.visible = true;
			updatePositionText();
		}
	}
	
	private function updatePositionText():Void {
		var x:Int = Std.int(this.x) - FRAME_WIDTH;
		var y:Int = Std.int(this.y) - FRAME_WIDTH;
		
		positionText.text = 'x=$x\ny=$y';
	}
}
