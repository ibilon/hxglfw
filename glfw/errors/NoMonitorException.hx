package glfw.errors;

@:allow(glfw)
class NoMonitorException extends Exception {
	function new() {
		super("Cannot find a monitor");
	}
}
