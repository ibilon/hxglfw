package glfw.errors;

@:allow(glfw)
class NotFullscreenException extends Exception {
	public final window:Window;

	function new(window:Window) {
		super("Window isn't in fullscreen mode");

		this.window = window;
	}
}
