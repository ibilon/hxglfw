package glfw.errors;

/**
	Object was used after being destroyed exception.

	Thrown by using `GLFW` and `Window` after they have been destroyed by `GLFW.destroy` and `Window.destroy`.

	If the `GLFW` object was destroyed all associated resources are destroyed: all `Monitor` and all `Window`.
**/
@:allow(glfw)
class UseAfterDestroyException extends Exception {
	function new() {
		super("Object was used after being destroyed");
	}
}
