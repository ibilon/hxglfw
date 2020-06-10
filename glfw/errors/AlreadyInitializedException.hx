package glfw.errors;

/**
	GLFW was already initialized exception.

	Thrown when creating two live instances of `GLFW` at the same time.
	You must call `GLFW.destroy` on the first instance before creating the second.
**/
@:allow(glfw)
class AlreadyInitializedException extends Exception {
	function new() {
		super("GLFW is already initialized");
	}
}
