package glfw;

import cpp.UInt8;

class Image {
	public var width:Int;
	public var height:Int;
	public var pixels:Array<UInt8>;

	public function new(width:Int, height:Int, pixels:Array<UInt8>) {
		this.width = width;
		this.height = height;
		this.pixels = pixels;
	}
}
