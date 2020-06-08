package glfw.errors;

@:allow(glfw)
class InitializationException extends Exception {
	function new() {
		super("Error during initialization");
	}
}
