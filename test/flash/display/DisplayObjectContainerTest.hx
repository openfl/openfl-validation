package flash.display;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.geom.Point;
import flash.Lib;
import massive.munit.Assert;


class DisplayObjectContainerTest {
	
	
	@Test public function testChildren () {
		
		var sprite:DisplayObjectContainer = new Sprite ();
		
		var bitmap:DisplayObject = new Bitmap (new BitmapData (100, 100));
		bitmap.name = "hello";
		
		sprite.addChild (bitmap);
		
		Assert.areEqual (1, sprite.numChildren);
		Assert.isTrue (sprite.contains (bitmap));
		
		Assert.areSame (bitmap, sprite.getChildAt (0));
		Assert.areSame (bitmap, sprite.getChildByName ("hello"));
		Assert.areEqual (0, sprite.getChildIndex (bitmap));
		
		// Native getObjectsUnderPoint() method doesn't work unless the object is renderable
		
		Lib.current.stage.addChild (sprite);
		var objects = sprite.getObjectsUnderPoint (new Point (1, 1));
		Assert.areEqual (1, objects.length);
		Assert.areSame (bitmap, objects[0]);
		Lib.current.stage.removeChild (sprite);
		
		var bitmap2 = new Bitmap (new BitmapData (100, 100));
		
		sprite.addChild (bitmap2);
		sprite.setChildIndex (bitmap2, 0);
		
		Assert.areEqual (0, sprite.getChildIndex (bitmap2));
		
		sprite.swapChildren (bitmap, bitmap2);
		
		Assert.areEqual (1, sprite.getChildIndex (bitmap2));
		
		sprite.swapChildrenAt (0, 1);
		
		Assert.areEqual (0, sprite.getChildIndex (bitmap2));
		
		sprite.removeChild (bitmap);
		
		Assert.areEqual (1, sprite.numChildren);
		Assert.isFalse (sprite.contains (bitmap));
		
		sprite.removeChildAt (0);
		
		Assert.areEqual (0, sprite.numChildren);
		Assert.isFalse (sprite.contains (bitmap2));
		
	}
	

}