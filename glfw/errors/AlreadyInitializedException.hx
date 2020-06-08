package glfw.errors;

@:allow(glfw)
class AlreadyInitializedException extends Exception {
	function new() {
		super("GLFW is already initialized");
	}
}
