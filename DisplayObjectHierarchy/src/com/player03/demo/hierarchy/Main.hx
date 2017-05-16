package com.player03.demo.hierarchy;

import openfl.display.Sprite;

class Main extends Sprite {
	public function new() {
		super();
		
		#if xAndY
			addChild(new XAndY());
		#elseif addAndRemove
			addChild(new AddAndRemove());
		#elseif movingContainer
			addChild(new MovingContainer());
		#end
	}
}
