package glfw;

/**
	A video mode.

	Returned by `Monitor.currentVideoMode` and `Monitor.videoModes`.
**/
@:allow(glfw)
class VideoMode {
	/** The width, in screen coordinates, of the video mode. **/
	public var width(default, null):Int;

	/** The height, in screen coordinates, of the video mode. **/
	public var height(default, null):Int;

	/** The bit depth of the red channel of the video mode. **/
	public var redBits(default, null):Int;

	/** The bit depth of the green channel of the video mode. **/
	public var greenBits(default, null):Int;

	/** The bit depth of the blue channel of the video mode. **/
	public var blueBits(default, null):Int;

	/** The refresh rate, in Hz, of the video mode. **/
	public var refreshRate(default, null):Int;

	function new(width:Int, height:Int, redBits:Int, greenBits:Int, blueBits:Int, refreshRate:Int) {
		this.width = width;
		this.height = height;
		this.redBits = redBits;
		this.greenBits = greenBits;
		this.blueBits = blueBits;
		this.refreshRate = refreshRate;
	}

	function toString():String {
		return '{ width => $width, height => $height, redBits => $redBits, greenBits => $greenBits, blueBits => $blueBits, refreshRate => $refreshRate }';
	}
}
