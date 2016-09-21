package com.player03.advancedlayoutdemo;

import layout.area.Area;
import layout.Direction;
import layout.Layout;
import layout.Scale;
import openfl.display.LineScaleMode;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.display.Stage;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.geom.Rectangle;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

using layout.LayoutUtils;

/**
 * @author Joseph Cloutier
 */
class LayoutSimulator extends Sprite {
	/**
	 * The current layout when this simulator was created. The simulated
	 * layout exists within this.
	 */
	public var outer:Layout;
	/**
	 * The simulated layout. Can be resized by clicking and dragging.
	 */
	public var inner:Layout;
	
	private var pendingBounds:Rectangle;
	private var lastMouseX:Float;
	private var lastMouseY:Float;
	/**
	 * Either LEFT, RIGHT, or null.
	 */
	private var grabbedEdgeX:Null<Direction>;
	/**
	 * Either TOP, BOTTOM, or null.
	 */
	private var grabbedEdgeY:Null<Direction>;
	
	private var minimumWidth:Float;
	private var minimumHeight:Float;
	
	/**
	 * Displays the current dimensions of the inner layout.
	 */
	private var dimensions:TextField;
	
	/**
	 * Displays an outline around the inner layout.
	 */
	private var outline:Shape;
	
	public function new(layoutWidth:Float, layoutHeight:Float, ?minimumWidth:Float = 0, ?minimumHeight:Float = 0) {
		super();
		
		this.minimumWidth = minimumWidth;
		this.minimumHeight = minimumHeight;
		
		outer = Layout.currentLayout;
		
		inner = new Layout(new Area(
			(outer.bounds.width - layoutWidth) / 2,
			(outer.bounds.height - layoutHeight) / 2,
			layoutWidth,
			layoutHeight));
		
		outline = new Shape();
		inner.addCallback(drawOutline, true);
		addChild(outline);
		
		pendingBounds = new Rectangle(
			inner.bounds.x, inner.bounds.y,
			inner.bounds.width, inner.bounds.height);
		outer.addCallback(ensureFit, true);
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		addEventListener(Event.ADDED_TO_STAGE, startListening);
		addEventListener(Event.REMOVED_FROM_STAGE, stopListening);
	}
	
	private function startListening(e:Event):Void {
		stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
	private function stopListening(e:Event):Void {
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
	
	private function onMouseDown(e:MouseEvent):Void {
		var xOffset:Float = (mouseX - inner.bounds.centerX)
			/ (inner.bounds.width / 2);
		var yOffset:Float = (mouseY - inner.bounds.centerY)
			/ (inner.bounds.height / 2);
		
		if(Math.abs(xOffset) < 0.5 && Math.abs(yOffset) < 0.5) {
			if(Math.abs(xOffset) < Math.abs(yOffset)) {
				xOffset = 0;
			} else {
				yOffset = 0;
			}
		} else {
			if(Math.abs(xOffset) < 0.5) {
				xOffset = 0;
			}
			if(Math.abs(yOffset) < 0.5) {
				yOffset = 0;
			}
		}
		
		if(xOffset < 0) {
			grabbedEdgeX = LEFT;
		} else if(xOffset > 0) {
			grabbedEdgeX = RIGHT;
		} else {
			grabbedEdgeX = null;
		}
		if(yOffset < 0) {
			grabbedEdgeY = TOP;
		} else if(yOffset > 0) {
			grabbedEdgeY = BOTTOM;
		} else {
			grabbedEdgeY = null;
		}
		
		lastMouseX = mouseX;
		lastMouseY = mouseY;
	}
	private function onMouseMove(e:MouseEvent):Void {
		if(!e.buttonDown) {
			return;
		}
		
		switch(grabbedEdgeX) {
			case LEFT:
				pendingBounds.left += mouseX - lastMouseX;
				
				if(pendingBounds.left < outer.bounds.left) {
					pendingBounds.left = outer.bounds.left;
				} else if(pendingBounds.width < minimumWidth) {
					pendingBounds.left = pendingBounds.right - minimumWidth;
				}
			case RIGHT:
				pendingBounds.right += mouseX - lastMouseX;
				
				if(pendingBounds.right > outer.bounds.right) {
					pendingBounds.right = outer.bounds.right;
				} else if(pendingBounds.width < minimumWidth) {
					pendingBounds.right = pendingBounds.left + minimumWidth;
				}
			default:
		}
		
		switch(grabbedEdgeY) {
			case TOP:
				pendingBounds.top += mouseY - lastMouseY;
				
				if(pendingBounds.top < outer.bounds.top) {
					pendingBounds.top = outer.bounds.top;
				} else if(pendingBounds.height < minimumHeight) {
					pendingBounds.top = pendingBounds.bottom - minimumHeight;
				}
			case BOTTOM:
				pendingBounds.bottom += mouseY - lastMouseY;
				
				if(pendingBounds.bottom > outer.bounds.bottom) {
					pendingBounds.bottom = outer.bounds.bottom;
				} else if(pendingBounds.height < minimumHeight) {
					pendingBounds.bottom = pendingBounds.top + minimumHeight;
				}
			default:
		}
		
		lastMouseX = mouseX;
		lastMouseY = mouseY;
	}
	private function onEnterFrame(e:Event):Void {
		if(inner.bounds.x != pendingBounds.x
				|| inner.bounds.y != pendingBounds.y
				|| inner.bounds.width != pendingBounds.width
				|| inner.bounds.height != pendingBounds.height) {
			inner.bounds.setTo(
				pendingBounds.x, pendingBounds.y,
				pendingBounds.width, pendingBounds.height);
		}
	}
	
	private function drawOutline():Void {
		var bounds:Area = inner.bounds;
		
		outline.graphics.clear();
		outline.graphics.lineStyle(1, 0x000000);
		outline.graphics.drawRect(bounds.x, bounds.y, bounds.width + 1, bounds.height + 1);
		
		//Now some squares around the edge.
		var w:Float = 10 * outer.scale.average;
		var w2:Float = w / 2;
		
		outline.graphics.beginFill(0xFFFFFF);
		outline.graphics.drawRect(bounds.left - w2,    bounds.top - w2, w, w);
		outline.graphics.drawRect(bounds.centerX - w2, bounds.top - w2, w, w);
		outline.graphics.drawRect(bounds.right - w2,   bounds.top - w2, w, w);
		outline.graphics.drawRect(bounds.left - w2,    bounds.centerY - w2, w, w);
		outline.graphics.drawRect(bounds.right - w2,   bounds.centerY - w2, w, w);
		outline.graphics.drawRect(bounds.left - w2,    bounds.bottom - w2, w, w);
		outline.graphics.drawRect(bounds.centerX - w2, bounds.bottom - w2, w, w);
		outline.graphics.drawRect(bounds.right - w2,   bounds.bottom - w2, w, w);
	}
	
	private function ensureFit():Void {
		if(pendingBounds.left < outer.bounds.left) {
			pendingBounds.left = outer.bounds.left;
		}
		if(pendingBounds.right > outer.bounds.right) {
			pendingBounds.right = outer.bounds.right;
		}
		if(pendingBounds.top < outer.bounds.top) {
			pendingBounds.top = outer.bounds.top;
		}
		if(pendingBounds.bottom > outer.bounds.bottom) {
			pendingBounds.bottom = outer.bounds.bottom;
		}
	}
}
