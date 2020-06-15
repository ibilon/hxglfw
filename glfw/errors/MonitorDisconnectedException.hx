package glfw.errors;

/**
	The monitor was disconnected exception.

	Thrown when using a `Monitor` after if was disconnected.
**/
@:allow(glfw)
class MonitorDisconnectedException extends Exception {
	/** The monitor that was incorrectly used. **/
	public var monitor(default, null):Monitor;

	function new(monitor:Monitor) {
		super("The monitor was disconnected");

		this.monitor = monitor;
	}
}
