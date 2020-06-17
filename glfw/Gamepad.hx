package glfw;

import cpp.NativeString;
import glfw.errors.GamepadNotConnectedException;

/**
	A gamepad.

	To get a gamepad obtain it from `GLFW.gamepads` or `GLFW.getConnectedGamepad`.

	Using the gamepad if it is not `Gamepad.connected` will throw a `GamepadNotConnectedException` exception.

	Using the gamepad after the GLFW object was destroyed with `GLFW.destroy` will throw a `UseAfterDestroyException` exception.
**/
@:allow(glfw)
class Gamepad {
	/** Left joystick horizontal value, between -1.0 and 1.0 inclusive. **/
	public var axisLeftX(default, null):Float;

	/** Left joystick vertical value, between -1.0 and 1.0 inclusive. **/
	public var axisLeftY(default, null):Float;

	/** Right joystick horizontal value, between -1.0 and 1.0 inclusive. **/
	public var axisRightX(default, null):Float;

	/** Right joystick vertical value, between -1.0 and 1.0 inclusive. **/
	public var axisRightY(default, null):Float;

	/** Left trigger value, between -1.0 and 1.0 inclusive. **/
	public var axisLeftTrigger(default, null):Float;

	/** Right trigger value, between -1.0 and 1.0 inclusive. **/
	public var axisRightTrigger(default, null):Float;

	/** Whether the A button (XBox layout) is pressed. The playstation alias is `Gamepad.buttonCross`. **/
	public var buttonA(default, null):Bool;

	/** Whether the B button (XBox layout) is pressed. The playstation alias is `Gamepad.buttonCircle`. **/
	public var buttonB(default, null):Bool;

	/** Whether the X button (XBox layout) is pressed. The playstation alias is `Gamepad.buttonSquare`. **/
	public var buttonX(default, null):Bool;

	/** Whether the Y button (XBox layout) is pressed. The playstation alias is `Gamepad.buttonTriangle`. **/
	public var buttonY(default, null):Bool;

	/** Whether the cross button (Playstation layout) is pressed. The xbox version is `Gamepad.buttonA`. **/
	public var buttonCross(get, never):Bool;

	/** Whether the circle button (Playstation layout) is pressed. The xbox version is `Gamepad.buttonB`. **/
	public var buttonCircle(get, never):Bool;

	/** Whether the square button (Playstation layout) is pressed. The xbox version is `Gamepad.buttonX`. **/
	public var buttonSquare(get, never):Bool;

	/** Whether the triangle button (Playstation layout) is pressed. The xbox version is `Gamepad.buttonYs`. **/
	public var buttonTriangle(get, never):Bool;

	/** Whether the left bumper button is pressed. */
	public var buttonLeftBumper(default, null):Bool;

	/** Whether the right bumper button is pressed. */
	public var buttonRightBumper(default, null):Bool;

	/** Whether the back button is pressed. */
	public var buttonBack(default, null):Bool;

	/** Whether the start button is pressed. */
	public var buttonStart(default, null):Bool;

	/** Whether the guide button is pressed. */
	public var buttonGuide(default, null):Bool;

	/** Whether the left thumb button is pressed. */
	public var buttonLeftThumb(default, null):Bool;

	/** Whether the right thumb button is pressed. */
	public var buttonRightThumb(default, null):Bool;

	/** Whether the dpad up button is pressed. */
	public var buttonUp(default, null):Bool;

	/** Whether the dpad right button is pressed. */
	public var buttonRight(default, null):Bool;

	/** Whether the dpad down button is pressed. */
	public var buttonDown(default, null):Bool;

	/** Whether the dpad left button is pressed. */
	public var buttonLeft(default, null):Bool;

	/**
		Whether the gamepad is connected.

		**Thread safety:** This variable must only be used from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var connected(get, never):Bool;

	/**
		The SDL compatible GUID of the connected gamepad.

		The GUID uses the format introduced in SDL 2.0.5.
		This GUID tries to uniquely identify the make and model of a joystick but does not identify a specific unit, e.g. all wired Xbox 360 controllers will have the same GUID on that platform.

		The GUID for a unit may vary between platforms depending on what hardware information the platform specific APIs provide.

		**Thread safety:** This function must only be called from the main thread.

		@throws GamepadNotConnectedException
		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var guid(get, never):String;

	/**
		Whether the connected gamepad has a mapping.

		If the gamepad has no mapping the buttons and axes may be incorrectly mapped to the variables.

		You can patch the mapping database with `GLFW.updateGamepadMappings` using the gamepad `Gamepad.guid`.

		**Thread safety:** This function must only be called from the main thread.

		@throws GamepadNotConnectedException
		@throws UseAfterDestroyException
	**/
	public var hasMapping(get, never):Bool;

	/** The id of the gamepad, it is the index of the `GLFW.gamepads` array. **/
	public var id(default, null):Int;

	/**
		The name of the connected gamepad.

		**Thread safety:** This function must only be called from the main thread.

		@throws GamepadNotConnectedException
		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var name(get, never):String;

	/**
		The callbacks to be called when the gamepad is connected or disconnected from the system.

		Disconnecting then reconnecting the same physical gamepad is not guaranteed to map to the same `Gamepad` object.

		Arguments:

		* `connected` True if the gamepad was connected, false if disconnected.

		To add a callback push a function to this array.
	**/
	public var onStatusChange:Array<(connected:Bool) -> Void>;

	function get_buttonCross():Bool {
		return buttonA;
	}

	function get_buttonCircle():Bool {
		return buttonB;
	}

	function get_buttonSquare():Bool {
		return buttonX;
	}

	function get_buttonTriangle():Bool {
		return buttonY;
	}

	function get_connected():Bool {
		GLFW.validate(); // Don't throw if the gamepad is not connected here

		return untyped __cpp__('glfwJoystickPresent(id) == GLFW_TRUE');
	}

	function get_guid():String {
		validate();

		return NativeString.fromPointer(untyped __cpp__('glfwGetJoystickGUID(id)'));
	}

	function get_hasMapping():Bool {
		validate();

		return untyped __cpp__('glfwJoystickIsGamepad(id) == GLFW_TRUE');
	}

	function get_name():String {
		validate();

		if (hasMapping) {
			return NativeString.fromPointer(untyped __cpp__('glfwGetGamepadName(id)'));
		} else {
			return NativeString.fromPointer(untyped __cpp__('glfwGetJoystickName(id)'));
		}
	}

	function new(id:Int) {
		inline reset();
		this.id = id;
		this.onStatusChange = [];
	}

	function reset():Void {
		axisLeftX = 0.0;
		axisLeftY = 0.0;
		axisRightX = 0.0;
		axisRightY = 0.0;
		axisLeftTrigger = 0.0;
		axisRightTrigger = 0.0;
		buttonA = false;
		buttonB = false;
		buttonX = false;
		buttonY = false;
		buttonLeftBumper = false;
		buttonRightBumper = false;
		buttonBack = false;
		buttonStart = false;
		buttonGuide = false;
		buttonLeftThumb = false;
		buttonRightThumb = false;
		buttonUp = false;
		buttonRight = false;
		buttonDown = false;
		buttonLeft = false;
	}

	/**
		@throws PlatformErrorException
	**/
	function update():Void {
		if (!connected) {
			reset();
			return;
		}

		untyped __cpp__('
			GLFWgamepadstate state;

			if (glfwJoystickIsGamepad(id) == GLFW_TRUE) {
				glfwGetGamepadState(id, &state);
			} else {
				// Emulate glfwGetGamepadState.
				int axes_count;
				const float *axes = glfwGetJoystickAxes(id, &axes_count);

				for (unsigned int i = 0; i < axes_count && i < 6; ++i) {
					state.axes[i] = axes[i];
				}

				int buttons_count;
				const unsigned char *buttons = glfwGetJoystickButtons(id, &buttons_count);

				for (unsigned int i = 0; i < buttons_count && i < 11; ++i) {
					state.buttons[i] = buttons[i];
				}

				int hats_count;
				const unsigned char *hats = glfwGetJoystickHats(id, &hats_count);

				if (hats_count > 0) {
					state.buttons[11] = (hats[0] & GLFW_HAT_UP) > 0 ? GLFW_PRESS : GLFW_RELEASE;
					state.buttons[12] = (hats[0] & GLFW_HAT_RIGHT) > 0 ? GLFW_PRESS : GLFW_RELEASE;
					state.buttons[13] = (hats[0] & GLFW_HAT_DOWN) > 0 ? GLFW_PRESS : GLFW_RELEASE;
					state.buttons[14] = (hats[0] & GLFW_HAT_LEFT) > 0 ? GLFW_PRESS : GLFW_RELEASE;
				}
			}

			axisLeftX = state.axes[0];
			axisLeftY = state.axes[1];
			axisRightX = state.axes[2];
			axisRightY = state.axes[3];
			axisLeftTrigger = state.axes[4];
			axisRightTrigger = state.axes[5];
			buttonA = state.buttons[0] == GLFW_PRESS;
			buttonB = state.buttons[1] == GLFW_PRESS;
			buttonX = state.buttons[2] == GLFW_PRESS;
			buttonY = state.buttons[3] == GLFW_PRESS;
			buttonLeftBumper = state.buttons[4] == GLFW_PRESS;
			buttonRightBumper = state.buttons[5] == GLFW_PRESS;
			buttonBack = state.buttons[6] == GLFW_PRESS;
			buttonStart = state.buttons[7] == GLFW_PRESS;
			buttonGuide = state.buttons[8] == GLFW_PRESS;
			buttonLeftThumb = state.buttons[9] == GLFW_PRESS;
			buttonRightThumb = state.buttons[10] == GLFW_PRESS;
			buttonUp = state.buttons[11] == GLFW_PRESS;
			buttonRight = state.buttons[12] == GLFW_PRESS;
			buttonDown = state.buttons[13] == GLFW_PRESS;
			buttonLeft = state.buttons[14] == GLFW_PRESS;
		');

	}

	/**
		@throws GamepadNotConnectedException
		@throws UseAfterDestroyException
	**/
	function validate():Void {
		if (untyped __cpp__('glfwJoystickPresent(id) == GLFW_FALSE')) {
			throw new GamepadNotConnectedException(this);
		}

		GLFW.validate();
	}
}
