package glfw.errors;

/**
	An internal error happened in the library code.

	Please report the bug to the [issue tracker](https://github.com/ibilon/hxglfw/issues).
**/
@:allow(glfw)
class InternalException extends Exception {
	function new(message:String) {
		super(message);
	}
}
