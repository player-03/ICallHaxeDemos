package com.player03.demo.hierarchy.object;

import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * A simple display object, labeled for convenience.
 */
class LabeledCircle extends Sprite {
	public static inline var DEFAULT_RADIUS:Float = 50;
	
	public var label(get, set):String;
	private var textField:TextField;
	
	public function new(?radius:Float = DEFAULT_RADIUS, ?label:String, ?fontSize:Int) {
		super();
		
		var r:Int = Std.int(Math.random() * 0x80) + 0x80;
		var g:Int = Std.int(Math.random() * 0x80) + 0x80;
		var b:Int = Std.int(Math.random() * 0x80) + 0x80;
		graphics.beginFill(r << 16 | g << 8 | b);
		graphics.lineStyle(3, 0x000000);
		graphics.drawCircle(0, 0, radius);
		
		textField = new BasicText(
			fontSize != null ? fontSize : Std.int(radius * 0.75));
		addChild(textField);
		
		if(label != null) {
			this.label = label;
		}
	}
	
	private inline function get_label():String {
		return textField.text;
	}
	private function set_label(value:String):String {
		textField.text = value;
		
		textField.x = -textField.textWidth / 2;
		textField.y = -textField.textHeight / 2;
		
		return value;
	}
	
	public function removeOnClick():Void {
		addEventListener(MouseEvent.CLICK, remove);
	}
	
	private function remove(e:MouseEvent):Void {
		parent.removeChild(this);
	}
}
