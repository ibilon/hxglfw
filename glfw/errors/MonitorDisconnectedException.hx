package glfw.errors;

@:allow(glfw)
class MonitorDisconnectedException extends Exception {
	public final monitor:Monitor;

	function new(monitor:Monitor) {
		super("The monitor was disconnected");

		this.monitor = monitor;
	}
}
