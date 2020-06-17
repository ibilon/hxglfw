package glfw.errors;

/**
	A platform-specific error occurred that does not match any of the more specific categories.
**/
@:allow(glfw)
class PlatformErrorException extends Exception {
	function new(message:String) {
		super(message);
	}
}
