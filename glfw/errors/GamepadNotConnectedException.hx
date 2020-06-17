package glfw.errors;

/**
	The gamepad is not connected exception.

	Thrown when using a gamepad not connected.

	You can check connection status with `Gamepad.connected`, or get all the connected gamepads with `GLFW.getConnectedGamepads`.
**/
@:allow(glfw)
class GamepadNotConnectedException extends Exception {
	/** The gamepad that was incorrectly used. **/
	public var gamepad(default, null):Gamepad;

	function new(gamepad:Gamepad) {
		this.gamepad = gamepad;
		super("Gamepad is not connected");
	}
}
