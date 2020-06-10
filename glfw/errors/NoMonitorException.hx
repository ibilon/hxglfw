package glfw.errors;

/**
	Cannot find a monitor exception.

	Thrown by `GLFW.primaryMonitor` if no monitor is available.
**/
@:allow(glfw)
class NoMonitorException extends Exception {
	function new() {
		super("Cannot find a monitor");
	}
}
