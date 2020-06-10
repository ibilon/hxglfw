package glfw;

import cpp.UInt8;

/**
	Image data.

	Used by `Window.setIcon`.

	This describes a single 2D image with 32-bit pixels, little-endian, non-premultiplied RGBA, i.e. eight bits per channel with the red channel first.
	They are arranged canonically as packed sequential rows, starting from the top-left corner.
**/
class Image {
	/** The width, in pixels, of this image. **/
	public var width:Int;

	/** The height, in pixels, of this image. **/
	public var height:Int;

	/** The pixel data of this image, arranged left-to-right, top-to-bottom. **/
	public var pixels:Array<UInt8>;

	/**
		Construct a new image.

		@param width The width, in pixels, of the image.
		@param height The height, in pixels, of the image.
		@param pixels The pixel data of the image, arranged left-to-right, top-to-bottom.
	**/
	public function new(width:Int, height:Int, pixels:Array<UInt8>) {
		this.width = width;
		this.height = height;
		this.pixels = pixels;
	}
}
