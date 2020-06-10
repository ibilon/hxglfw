package glfw.errors;

/**
	Window isn't in fullscreen mode exception.

	Thrown by `Window.getFullscreenMonitor` if the window isn't fullscreen.
**/
@:allow(glfw)
class NotFullscreenException extends Exception {
	/** The window throwing the exception. **/
	public final window:Window;

	function new(window:Window) {
		super("Window isn't in fullscreen mode");

		this.window = window;
	}
}
