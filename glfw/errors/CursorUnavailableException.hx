package glfw.errors;

/**
	The specified cursor shape is not available.

	Thrown either because the current system cursor theme does not provide it or because it is not available on the platform.

	This is a platform or system settings limitation, pick another `CursorShape` or create a custom cursor with `GLFW.createCursor`.
**/
@:allow(glfw)
class CursorUnavailableException extends Exception {
	function new(message:String) {
		super(message);
	}
}
