package glfw;

@:allow(glfw)
class VideoMode {
	public final width:Int;
	public final height:Int;
	public final redBits:Int;
	public final greenBits:Int;
	public final blueBits:Int;
	public final refreshRate:Int;

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
