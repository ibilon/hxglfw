package glfw.errors;

@:allow(glfw)
class UseAfterDestroyException extends Exception {
	function new() {
		super("Object was used after being destroyed");
	}
}
