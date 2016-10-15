package com.player03.advancedlayoutdemo;

import layout.area.Area;
import layout.area.StageArea;
import layout.Direction;
import layout.Layout;
import layout.Scale;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.LineScaleMode;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.display.Stage;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

using layout.LayoutCreator;

/**
 * @author Joseph Cloutier
 */
class Main extends Sprite {
	@:keep @:expose("layoutdemo.noScale")
	public static function noScale():Void {
		scale = NO_SCALE;
	}
	@:keep @:expose("layoutdemo.stretch")
	public static function stretch():Void {
		scale = STRETCH;
	}
	@:keep @:expose("layoutdemo.aspectRatio")
	public static function aspectRatio():Void {
		scale = ASPECT_RATIO;
	}
	@:keep @:expose("layoutdemo.aspectRatioWithCropping")
	public static function aspectRatioWithCropping():Void {
		scale = ASPECT_RATIO_WITH_CROPPING;
	}
	
	private static var scale:ScaleMode = ASPECT_RATIO;
	
	private var simulator:LayoutSimulator;
	
	public function new() {
		super();
		
		simulator = new LayoutSimulator(250, 200, 50, 40);
		Layout.currentLayout = simulator.inner;
		
		var background:Shape = new Shape();
		background.graphics.beginFill(0xFFFF66);
		background.graphics.drawRect(0, 0, 250, 200);
		background.fillWidth();
		background.fillHeight();
		background.alignTopLeft();
		addChild(background);
		
		var ball:Bitmap = new Bitmap(Assets.getBitmapData("img/Ball.png"));
		ball.simpleWidth(95);
		ball.simpleHeight(95);
		ball.center();
		addChild(ball);
		
		var title:Bitmap = new Bitmap(Assets.getBitmapData("img/GameTitle.png"));
		title.simpleWidth(203);
		title.simpleHeight(50);
		title.centerX();
		title.alignTop(10);
		addChild(title);
		
		var dontPlay:Bitmap = new Bitmap(Assets.getBitmapData("img/DontPlay.png"));
		dontPlay.simpleWidth(116);
		dontPlay.simpleHeight(30);
		dontPlay.centerX();
		dontPlay.alignBottom(15);
		addChild(dontPlay);
		
		var play:Bitmap = new Bitmap(Assets.getBitmapData("img/Play.png"));
		play.simpleWidth(51);
		play.simpleHeight(30);
		play.aboveCenter(dontPlay, 10);
		addChild(play);
		
		var mute:Bitmap = new Bitmap(Assets.getBitmapData("img/Mute.png"));
		mute.simpleWidth(20);
		mute.simpleHeight(26);
		mute.alignBottomRight(6);
		addChild(mute);
		
		addChild(simulator);
		
		switch(scale) {
			case NO_SCALE:
				simulator.inner.scale.noScale();
			case STRETCH:
				simulator.inner.scale.stretch();
			case ASPECT_RATIO:
				//This is the default.
				//simulator.inner.scale.aspectRatio();
			case ASPECT_RATIO_WITH_CROPPING:
				simulator.inner.scale.aspectRatioWithCropping();
		}
		
		Layout.currentLayout = null;
	}
}

private enum ScaleMode {
	NO_SCALE;
	STRETCH;
	ASPECT_RATIO;
	ASPECT_RATIO_WITH_CROPPING;
}
