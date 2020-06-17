package glfw;

import cpp.Pointer;
import glfw.errors.*;
import glfw.mouse.*;
import haxe.ds.ReadOnlyArray;

/**
	Main entry point to the GLFW library

	You must only instance it once at a time.

	Calling `GLFW.destroy` will invalidate the instance and all the resources associated.
	Using the object, or objects created thought it, after the destruction will throw a `UseAfterDestroyException` exception.
**/
@:allow(glfw)
@:build(glfw.GLFWBuilder.build())
@:cppNamespaceCode('
	static GLFW_obj *singleton = nullptr;

	static void error_callback(int code, const char *message) {
		glfw::GLFW_obj::errorCallback(code, message);
	}

	static void gamepad_callback(int id, int event) {
		singleton->_onGamepadChange(id, event == GLFW_CONNECTED);
	}

	static void monitor_callback(GLFWmonitor *monitor, int status) {
		singleton->updateMonitor(monitor, status == GLFW_CONNECTED);
	}
')
@:headerInclude('./glfw.h')
class GLFW {
	/**
		Called from `glfwSetErrorCallback`.
	**/
	static function errorCallback(code:Int, message:String):Void {
		// TODO switch on code to dispatch better errors
		throw new Exception(message);
	}

	static function validate():Void {
		if (untyped __cpp__('singleton == nullptr')) {
			throw new UseAfterDestroyException();
		}
	}

	/** The version of the native GLFW library used. Can be called without having a `GLFW` instance. **/
	public static var version(get, never):{major:Int, minor:Int, patch:Int};

	static function get_version():{major:Int, minor:Int, patch:Int} {
		var major = 0;
		var minor = 0;
		var patch = 0;

		untyped __cpp__('glfwGetVersion(&major, &minor, &patch)');

		return {
			major: major,
			minor: minor,
			patch: patch,
		};
	}

	/**
		Array of possible gamepads.

		This is a set of 15 preallocated `Gamepad` instances, the gamepads are not necessarily connected, check with `Gamepad.connected` or use `GLFW.getConnectedGamepads` to only get the gamepads that are connected.

		Use `GLFW.onGamepadChange` or `Gamepad.onStatusChange` to be notified of gamepad connections and disconnections.
	**/
	public var gamepads(default, null):ReadOnlyArray<Gamepad>;

	var _monitors:Array<Monitor>;

	/**
		The currently connected monitors.

		The primary monitor is always first in the array.

		The `Monitor` instances are only valid until the instance is destroyed or the monitor gets disconnected.
	**/
	public var monitors(get, never):ReadOnlyArray<Monitor>;

	/**
		The callbacks to be called when a gamepad is connected or disconnected from the system.

		Disconnecting then reconnecting the same physical gamepad is not guaranteed to map to the same `Gamepad` object.

		Arguments:

		* `gamepad` The gamepad that was connected or disconnected.
		* `connected` True if the gamepad was connected, false if disconnected.

		To add a callback push a function to this array.
	**/
	public var onGamepadChange:Array<(gamepad:Gamepad, connected:Bool) -> Void>;

	/**
		The callbacks to be called when a monitor is connected to or disconnected from the system.

		Arguments:

		* `monitor` The monitor that was connected or disconnected.
		* `connected` True if the monitor was connected, false if disconnected.

		If the monitor was disconnected the `Monitor` instance is valid until the callback returns.

		Disconnecting then connecting back a monitor will not reuse the old `Monitor` object.

		To add a callback push a function to this array.
	**/
	public var onMonitorChange:Array<(monitor:Monitor, connected:Bool) -> Void>;

	/**
		The primary monitor, usually the monitor where elements like the task bar or global menu bar are located.

		This is equalivalent to `monitors[0]`.

		If no monitor is available then accessing this will throw a `NoMonitorException` exception.
	**/
	public var primaryMonitor(get, never):Monitor;

	inline function get_monitors():ReadOnlyArray<Monitor> {
		validate();

		return _monitors;
	}

	inline function get_primaryMonitor():Monitor {
		validate();

		if (_monitors.length == 0) {
			throw new NoMonitorException();
		}

		return _monitors[0];
	}

	/**
		Create a new instance of GLFW.

		Only one instance must be valid at a time.
		Trying to create a second one will throw a `AlreadyInitializedException` exception.
	**/
	public function new() {
		if (untyped __cpp__('singleton != nullptr')) {
			throw new AlreadyInitializedException();
		}

		untyped __cpp__('
			glfwSetErrorCallback(error_callback);
			glfwInitHint(GLFW_JOYSTICK_HAT_BUTTONS, GLFW_FALSE);
		');

		if (untyped __cpp__('glfwInit()') == 0) {
			// TODO error callback might make this not needed
			throw new InitializationException();
		}

		untyped __cpp__('singleton = this');

		this._monitors = [];
		this.onGamepadChange = [];
		this.onMonitorChange = [];
		this.gamepads = [for (i in 0...16) new Gamepad(i)];

		untyped __cpp__('
			int count;
			GLFWmonitor **raw_monitors = glfwGetMonitors(&count);

			for (unsigned int i = 0; i < count; ++i) {
				glfw::Monitor monitor = glfw::Monitor_obj::__alloc(HX_CTX);
				monitor->native = raw_monitors[i];
				_monitors->push(monitor);
			}

			glfwSetJoystickCallback(gamepad_callback);
			glfwSetMonitorCallback(monitor_callback);
		');

	}

	/**
		Creates a new custom cursor image that can be set for a window with `Window.cursor`.

		The cursor can be destroyed `Cursor.destroy`, any remaining cursors are destroyed by `GLFW.destroy`.

		The cursor hotspot is specified in pixels, relative to the upper-left corner of the cursor image. Like all other coordinate systems in GLFW, the X-axis points to the right and the Y-axis points down.

		@param image The desired cursor image.
		@param x The desired x-coordinate, in pixels, of the cursor hotspot.
		@param y The desired y-coordinate, in pixels, of the cursor hotspot.

		@return The created cursor.
	**/
	public function createCursor(image:Image, x:Int, y:Int):Cursor {
		var cursor = new Cursor();

		untyped __cpp__('
			unsigned char *pixels = (unsigned char*)malloc(sizeof(*pixels) * image->pixels->length);

			for (unsigned int i = 0; i < image->pixels->length; ++i) {
				pixels[i] = image->pixels->__get(i);
			}

			GLFWimage native_image = {
				width: image->width,
				height: image->height,
				pixels: pixels,
			};

			cursor->native = glfwCreateCursor(&native_image, x, y);

			free(pixels);
		');

		return cursor;
	}

	/**
		Creates a cursor with a standard shape, that can be set for a window with `Window.cursor`.

		The images for these cursors come from the system cursor theme and their exact appearance will vary between platforms.

		Most of these shapes are guaranteed to exist on every supported platform but a few may not be present. See the table below for details.

		Cursor shape                   | Windows | macOS   | X11       | Wayland
		------------------------------ | ------- | ------- | --------- | -------
		`CursorMode.Arrow`             | Yes     | Yes     | Yes       | Yes
		`CursorMode.IBeam`             | Yes     | Yes     | Yes       | Yes
		`CursorMode.Crosshair`         | Yes     | Yes     | Yes       | Yes
		`CursorMode.PointingHand`      | Yes     | Yes     | Yes       | Yes
		`CursorMode.ResizeEW`          | Yes     | Yes     | Yes       | Yes
		`CursorMode.ResizeNS`          | Yes     | Yes     | Yes       | Yes
		`CursorMode.ResizeNWSE`        | Yes     | Yes (1) | Maybe (2) | Maybe (2)
		`CursorMode.ResizeNESW`        | Yes     | Yes (1) | Maybe (2) | Maybe (2)
		`CursorMode.ResizeAll`         | Yes     | Yes     | Yes       | Yes
		`CursorMode.NotAllowed`        | Yes     | Yes     | Maybe (2) | Maybe (2)

		(1) This uses a private system API and may fail in the future.

		(2) This uses a newer standard that not all cursor themes support.

		@param shape One of the standard shapes in `CursorShape`.

		@return The created cursor.
	**/
	public function createStandardCursor(shape:CursorShape):Cursor {
		var cursor = new Cursor();

		untyped __cpp__('cursor->native = glfwCreateStandardCursor(shape)');

		return cursor;
	}

	/**
		Create a window with the options `options`.

		To create a fullscreen window, you need to specify the monitor the window will cover in `WindowOptions.monitor`. If no monitor is specified, the window will be windowed mode.
		Unless you have a way for the user to choose a specific monitor, it is recommended that you pick the primary monitor using `primaryMonitor`.
		You can get information on the available monitors in the `monitors` array.

		For fullscreen windows, the specified size becomes the resolution of the window's _desired video mode_.  As long as a fullscreen window is not iconified, the supported video mode most closely matching the desired video mode is set for the specified monitor.

		Once you have created the window, you can switch it between windowed and fullscreen mode with `Window.setFullscreenMonitor`.

		By default, newly created windows use the placement recommended by the window system.
		To create the window at a specific position, make it initially invisible using `WindowOptions.visible`, set its position with `Window.setPosition` and then show it with `Window.show`.

		As long as at least one fullscreen window is not iconified, the screensaver is prohibited from starting.

		Window systems put limits on window sizes.
		Very large or very small window dimensions may be overridden by the window system on creation.  Check the actual size with `Window.getSize` after creation.

		Window creation will fail if the Microsoft GDI software OpenGL implementation is the only one available.

		On MacOS the window has no icon, as it is not a document window, but the dock icon will be the same as the application bundle's icon.
		For more information on bundles, see the [Bundle Programming Guide](https://developer.apple.com/library/mac/documentation/CoreFoundation/Conceptual/CFBundles/) in the Mac Developer Library.

		On X11 some window managers will not respect the placement of initially hidden windows.

		On X11 due to the asynchronous nature of X11, it may take a moment for a window to reach its requested state. This means you may not be able to query the final size, position or other attributes directly after window creation.

		On wayland a fullscreen window will not attempt to change the mode, no matter what the requested size or refresh rate.

		On wayland screensaver inhibition requires the idle-inhibit protocol to be implemented in the user's compositor.

		@param options The options used to create the window.
		@return The created window.
	**/
	public function createWindow(options:WindowOptions):Window {
		validate();

		return new Window(this, options);
	}

	/**
		Destroy this instance.

		This function destroys all remaining windows and cursors and frees any other allocated resources.
		Once this function is called, you must again create a new instance of `GLFW`.

		This function should be called before the application exits.

		Using the object, or objects created thought it, after the destruction will throw a `UseAfterDestroyException` exception.
	**/
	public function destroy():Void {
		validate();

		untyped __cpp__('
			glfwTerminate();
			singleton = nullptr;
		');
	}

	function findMonitor(ptr:Pointer<cpp.Void>):Null<Monitor> {
		for (m in _monitors) {
			if (untyped __cpp__('m->native == (GLFWmonitor*)((void*)ptr)')) {
				return m;
			}
		}

		return null;
	}

	/**
		Get the connected gamepads.

		This is a subset from `GLFW.gamepads` implemented with:
		```haxe
		return gamepads.filter(g -> g.connected);
		```
	**/
	public function getConnectedGamepads():Array<Gamepad> {
		return gamepads.filter(g -> g.connected);
	}

	function _onGamepadChange(id:Int, connected:Bool):Void {
		if (id > 15) {
			return;
		}

		final gamepad = gamepads[id];

		for (fn in onGamepadChange) {
			fn(gamepad, connected);
		}

		for (fn in gamepad.onStatusChange) {
			fn(connected);
		}
	}

	/**
		Processes all pending events.

		This function processes only those events that are already in the event queue and then returns immediately.  Processing events will cause the window and input callbacks associated with those events to be called.

		On some platforms, a window move, resize or menu operation will cause event processing to block.  This is due to how event processing is designed on those platforms.
		You can use the `Window.onRefresh` callback to redraw the contents of your window when necessary during such operations.

		Do not assume that callbacks you set will _only_ be called in response to event processing functions like this one. While it is necessary to poll for events, window systems that require GLFW to register callbacks of its own can pass events to GLFW in response to many window system function calls. GLFW will pass those events on to the application callbacks before returning.
	**/
	public function pollEvents():Void {
		validate();

		untyped __cpp__('glfwPollEvents();');

		for (gamepad in gamepads) {
			gamepad.update();
		}
	}

	/**
		Adds the specified SDL_GameControllerDB gamepad mappings.

		This parses the specified ASCII encoded string and updates the internal list with any gamepad mappings it finds.

		This string may contain either a single gamepad mapping or many mappings separated by newlines.

		The parser supports the full format of the `gamecontrollerdb.txt` source file including empty lines and comments.

		If there is already a gamepad mapping for a given GUID in the internal list, it will be replaced by the one passed to this function.

		If the library is terminated and re-initialized the internal list will revert to the built-in default.

		@param patch The string containing the gamepad mappings patch.
	**/
	public function updateGamepadMappings(patch:String):Void {
		untyped __cpp__('glfwUpdateGamepadMappings(patch)');
	}

	/**
		Called from `glfwSetMonitorCallback`.
	**/
	function updateMonitor(raw:Pointer<cpp.Void>, connected:Bool):Void {
		var monitor = findMonitor(raw);

		if (monitor == null) {
			monitor = new Monitor();
			untyped __cpp__('monitor->native = (GLFWmonitor*)((void*)raw)');
		}

		if (connected) {
			_monitors.push(monitor);
		} else {
			_monitors.remove(monitor);
		}

		for (fn in onMonitorChange) {
			fn(monitor, connected);
		}

		if (!connected) {
			untyped __cpp__('monitor->native = nullptr');
		}

		// Move the primary monitor to the start of the array.
		var primary = switch (findMonitor(untyped __cpp__('glfwGetPrimaryMonitor()'))) {
			case null: throw "assert false";
			case value: (value : Monitor);
		}

		_monitors.remove(primary);
		_monitors.unshift(primary);
	}
}
