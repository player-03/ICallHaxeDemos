package com.player03.demo.hierarchy;

import openfl.events.MouseEvent;
import openfl.display.Sprite;
import openfl.Lib;
import com.player03.demo.hierarchy.object.LabeledCircle;

class AddAndRemove extends Sprite {
	public function new() {
		super();
		
		Lib.current.stage.addEventListener(MouseEvent.CLICK, onClick);
	}
	
	private function onClick(e:MouseEvent):Void {
		if(e.target == stage) {
			var circle:LabeledCircle = new LabeledCircle();
			circle.x = e.stageX;
			circle.y = e.stageY;
			circle.removeOnClick();
			addChild(circle);
		}
		
		for(i in 0...numChildren) {
			var circle:LabeledCircle = cast getChildAt(i);
			circle.label = Std.string(i);
		}
	}
}
