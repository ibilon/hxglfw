package glfw.errors;

/**
	Error during initialization exception.

	Thrown by `GLFW.new` if there was an error.
**/
@:allow(glfw)
class InitializationException extends Exception {
	function new() {
		super("Error during initialization");
	}
}
