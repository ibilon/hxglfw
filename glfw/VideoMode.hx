package glfw;

@:allow(glfw)
class VideoMode {
	public var width(default, null):Int;
	public var height(default, null):Int;
	public var redBits(default, null):Int;
	public var greenBits(default, null):Int;
	public var blueBits(default, null):Int;
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
