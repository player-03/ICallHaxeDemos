package com.player03.demo.hierarchy.object;

import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;


/**
 * @author Joseph Cloutier
 */
class BasicText extends TextField {
	public function new(?text:String, ?fontSize:Int) {
		super();
		
		var format:TextFormat = new TextFormat();
		format.font = "Quando-Regular";
		if(fontSize != null) {
			format.size = fontSize;
		}
		
		autoSize = TextFieldAutoSize.LEFT;
		
		defaultTextFormat = format;
		embedFonts = true;
		
		selectable = false;
		multiline = true;
		
		if(text != null) {
			this.text = text;
		}
	}
}
