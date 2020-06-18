package glfw;

import cpp.Float32;
import cpp.UInt32;
import cpp.Star;
import glfw.keyboard.*;
import glfw.mouse.*;
import glfw.errors.*;

/**
	A window.

	To create a new window use `GLFW.createWindow`.

	Using the window after it was destroyed with `Window.destroy` or after the GLFW object was destroyed with `GLFW.destroy` will throw a `UseAfterDestroyException` exception.
**/
@:allow(glfw)
@:cppNamespaceCode('
	static bool find_window(GLFWwindow *window, unsigned int *index) {
		for (unsigned int i = 0; i < glfw::Window_obj::windows->length; ++i) {
			auto elem = glfw::Window_obj::windows->__get(i).StaticCast<glfw::Window>();

			if (elem->native == window) {
				*index = i;
				return true;
			}
		}

		return false;
	}

	static void char_callback(GLFWwindow *window, unsigned int codepoint) {
		unsigned int index;

		if (find_window(window, &index)) {
			auto elem = glfw::Window_obj::windows->__get(index).StaticCast<glfw::Window>();

			for (unsigned int j = 0; j < elem->onChar->length; ++j) {
				elem->onChar->__get(j)(codepoint);
			}
		}
	}

	static void char_mods_callback(GLFWwindow *window, unsigned int codepoint, int mods) {
		unsigned int index;

		if (find_window(window, &index)) {
			auto elem = glfw::Window_obj::windows->__get(index).StaticCast<glfw::Window>();

			for (unsigned int j = 0; j < elem->onCharModifiers->length; ++j) {
				elem->onCharModifiers->__get(j)(codepoint, mods);
			}
		}
	}

	static void close_callback(GLFWwindow *window) {
		unsigned int index;

		if (find_window(window, &index)) {
			auto elem = glfw::Window_obj::windows->__get(index).StaticCast<glfw::Window>();

			for (unsigned int j = 0; j < elem->onClose->length; ++j) {
				elem->onClose->__get(j)();
			}
		}
	}

	static void contentscale_callback(GLFWwindow *window, float x, float y) {
		unsigned int index;

		if (find_window(window, &index)) {
			auto elem = glfw::Window_obj::windows->__get(index).StaticCast<glfw::Window>();

			for (unsigned int j = 0; j < elem->onContentScaleChange->length; ++j) {
				elem->onContentScaleChange->__get(j)(x, y);
			}
		}
	}

	static void cursor_enter_callback(GLFWwindow *window, int entered) {
		unsigned int index;

		if (find_window(window, &index)) {
			auto elem = glfw::Window_obj::windows->__get(index).StaticCast<glfw::Window>();

			for (unsigned int j = 0; j < elem->onCursorHoverChange->length; ++j) {
				elem->onCursorHoverChange->__get(j)(entered == GLFW_TRUE);
			}
		}
	}

	static void cursor_pos_callback(GLFWwindow *window, double x, double y) {
		unsigned int index;

		if (find_window(window, &index)) {
			auto elem = glfw::Window_obj::windows->__get(index).StaticCast<glfw::Window>();

			for (unsigned int j = 0; j < elem->onCursorPositionChange->length; ++j) {
				elem->onCursorPositionChange->__get(j)(x, y);
			}
		}
	}

	static void drop_callback(GLFWwindow *window, int count, const char **paths) {
		unsigned int index;

		if (find_window(window, &index)) {
			auto elem = glfw::Window_obj::windows->__get(index).StaticCast<glfw::Window>();

			for (unsigned int j = 0; j < elem->onPathDrop->length; ++j) {
				Array<String> haxe_paths = Array_obj<String>::__new();

				for (unsigned int k = 0; k < count; ++k) {
					cpp::Pointer<char> ptr = paths[index];
					haxe_paths->push(String(ptr->ptr));
				}

				elem->onPathDrop->__get(j)(haxe_paths);
			}
		}
	}

	static void focus_callback(GLFWwindow *window, int focused) {
		unsigned int index;

		if (find_window(window, &index)) {
			auto elem = glfw::Window_obj::windows->__get(index).StaticCast<glfw::Window>();

			for (unsigned int j = 0; j < elem->onFocusChange->length; ++j) {
				elem->onFocusChange->__get(j)(focused == GLFW_TRUE);
			}
		}
	}

	static void iconify_callback(GLFWwindow *window, int iconified) {
		unsigned int index;

		if (find_window(window, &index)) {
			auto elem = glfw::Window_obj::windows->__get(index).StaticCast<glfw::Window>();

			for (unsigned int j = 0; j < elem->onIconifyChange->length; ++j) {
				elem->onIconifyChange->__get(j)(iconified == GLFW_TRUE);
			}
		}
	}

	static void key_callback(GLFWwindow *window, int key, int scancode, int action, int mods) {
		unsigned int index;

		if (find_window(window, &index)) {
			auto elem = glfw::Window_obj::windows->__get(index).StaticCast<glfw::Window>();

			for (unsigned int j = 0; j < elem->onKey->length; ++j) {
				elem->onKey->__get(j)(key, scancode, action, mods);
			}
		}
	}

	static void maximize_callback(GLFWwindow *window, int maximized) {
		unsigned int index;

		if (find_window(window, &index)) {
			auto elem = glfw::Window_obj::windows->__get(index).StaticCast<glfw::Window>();

			for (unsigned int j = 0; j < elem->onMaximizeChange->length; ++j) {
				elem->onMaximizeChange->__get(j)(maximized == GLFW_TRUE);
			}
		}
	}

	static void mouse_button_callback(GLFWwindow *window, int button, int action, int mods) {
		unsigned int index;

		if (find_window(window, &index)) {
			auto elem = glfw::Window_obj::windows->__get(index).StaticCast<glfw::Window>();

			for (unsigned int j = 0; j < elem->onMouseButton->length; ++j) {
				elem->onMouseButton->__get(j)(button, action == GLFW_PRESS, mods);
			}
		}
	}

	static void pos_callback(GLFWwindow *window, int x, int y) {
		unsigned int index;

		if (find_window(window, &index)) {
			auto elem = glfw::Window_obj::windows->__get(index).StaticCast<glfw::Window>();

			for (unsigned int j = 0; j < elem->onPositionChange->length; ++j) {
				elem->onPositionChange->__get(j)(x, y);
			}
		}
	}

	static void refresh_callback(GLFWwindow *window) {
		unsigned int index;

		if (find_window(window, &index)) {
			auto elem = glfw::Window_obj::windows->__get(index).StaticCast<glfw::Window>();

			for (unsigned int j = 0; j < elem->onRefresh->length; ++j) {
				elem->onRefresh->__get(j)();
			}
		}
	}

	static void scroll_callback(GLFWwindow *window, double x, double y) {
		unsigned int index;

		if (find_window(window, &index)) {
			auto elem = glfw::Window_obj::windows->__get(index).StaticCast<glfw::Window>();

			for (unsigned int j = 0; j < elem->onMouseScroll->length; ++j) {
				elem->onMouseScroll->__get(j)(x, y);
			}
		}
	}

	static void size_callback(GLFWwindow *window, int width, int height) {
		unsigned int index;

		if (find_window(window, &index)) {
			auto elem = glfw::Window_obj::windows->__get(index).StaticCast<glfw::Window>();

			for (unsigned int j = 0; j < elem->onSizeChange->length; ++j) {
				elem->onSizeChange->__get(j)(width, height);
			}
		}
	}
')
@:headerClassCode('
	GLFWwindow *native;
')
@:headerInclude('./glfw.h')
class Window {
	static var windows:Array<Window> = [];

	/**
		Whether the fullscreen window will automatically iconify and restore the previous video mode on input focus loss.

		This is ignored for windowed mode windows.

		**Thread safety:** This variable must only be used from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var autoIconify(get, set):Bool;

	/**
		The content scale of the window.

		The content scale is the ratio between the current DPI and the platform's default DPI.
		This is especially important for text and any UI elements.
		If the pixel dimensions of your UI scaled by this look appropriate on your machine then it should appear at a reasonable size on other machines regardless of their DPI and scaling settings.
		This relies on the system DPI and scaling settings being somewhat correct.

		On systems where each monitors can have its own content scale, the window content scale will depend on which monitor the system considers the window to be on.

		**Thread safety:** This variable must only be used from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var contentScale(get, never):{x:Float, y:Float};

	/**
		The cursor of the window.

		This is the cursor image to be used when the cursor is over the content area of the window.

		Set this to `null` (the default value) to return to the system cursor.

		It will only be visible if the `Window.cursorMode` is `CursorMode.Normal`.

		On some platforms, the set cursor may not be visible unless the window also has input focus.

		**Thread safety:** This variable must only be used from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var cursor(default, set):Null<Cursor>;

	/**
		The mode of the cursor, default to `CursorMode.Normal`.

		See `CursorMode` for more details about the available modes.

		**Thread safety:** This variable must only be used from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var cursorMode(get, set):CursorMode;

	/**
		The horizontal position of the cursor, in screen coordinates, relative to the upper-left corner of the content area of the window.

		If the cursor is disabled (`Window.cursorMode` is `CursorMode.Disabled`) then the cursor position is unbounded and limited only by the minimum and maximum values of a `Float`.

		The coordinate can be converted to their integer equivalents with the `Math.floor` function.
		Casting directly to an integer type works for positive coordinates, but fails for negative ones.

		**Thread safety:** This variable must only be used from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var cursorPositionX(get, set):Float;

	/**
		The vertical position of the cursor, in screen coordinates, relative to the upper-left corner of the content area of the window.

		If the cursor is disabled (`Window.cursorMode` is `CursorMode.Disabled`) then the cursor position is unbounded and limited only by the minimum and maximum values of a `Float`.

		The coordinate can be converted to their integer equivalents with the `Math.floor` function.
		Casting directly to an integer type works for positive coordinates, but fails for negative ones.

		**Thread safety:** This variable must only be used from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var cursorPositionY(get, set):Float;

	/**
		Whether the windowed mode window will have window decorations such as a border, a close widget, etc. An undecorated window will not be resizable by the user but will still allow the user to generate close events on some platforms.

		This is ignored for fullscreen windows.

		**Thread safety:** This variable must only be used from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var decorated(get, set):Bool;

	/**
		Whether the windowed mode window will be floating above other regular windows, also called topmost or always-on-top. This is intended primarily for debugging purposes and cannot be used to implement proper fullscreen windows.

		This is ignored for fullscreen windows.

		**Thread safety:** This variable must only be used from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var floating(get, set):Bool;

	/**
		The current input focus state.

		**Thread safety:** This variable must only be used from the main thread.

		@see `Window.focus`
		@see `Window.requestAttention`

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var focused(get, never):Bool;

	/**
		Whether the window will be given input focus when `Window.show` is called.

		**Thread safety:** This variable must only be used from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var focusOnShow(get, set):Bool;

	/**
		The size of the frame of the window.

		This is the size, in screen coordinates, of each edge of the frame of the window.
		This size includes the title bar, if the window has one.

		Because this function retrieves the size of each window frame edge and not the offset along a particular coordinate axis, the retrieved values will always be zero or positive.

		**Thread safety:** This variable must only be used from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var frameSize(get, never):{
		left:Int,
		top:Int,
		right:Int,
		bottom:Int
	};

	/**
		Whether sticky keys are enabled.

		When sticky keys mode is enabled, the pollable state of a key will remain `KeyState.Press` until the state of that key is polled with `Window.getKeyState`. Once it has been polled, if a key release event had been processed in the meantime, the state will reset to `KeyState.Release`, otherwise it will remain `KeyState.Press`.

		**Thread safety:** This variable must only be used from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var keysSticky(get, set):Bool;

	/**
		Whether caps lock and num lock key modifiers are set for key events.

		When this input mode is enabled, any callback that receives `Modifiers` state will have the `Modifiers.capsLock` set to `true` set if Caps Lock was on when the event occurred and the `Modifiers.numLock` set to `true` if Num Lock was on.

		**Thread safety:** This variable must only be used from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var lockKeyModifiers(get, set):Bool;

	/**
		The current maximization state.

		**Thread safety:** This variable must only be used from the main thread.

		@see `Window.maximize`
		@see `Window.restore`

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var maximized(get, never):Bool;

	/**
		Whether sticky mouse buttons are enabled.

		If true a mouse button press will ensure that `Window.getMouseButton` returns `true` the next time it is called even if the mouse button had been released before the call.
		This is useful when you are only interested in whether mouse buttons have been pressed but not when or in which order.

		**Thread safety:** This variable must only be used from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var mouseButtonsSticky(get, set):Bool;

	/**
		The callbacks to be called when a Unicode character is input.

		The character callback is intended for Unicode text input. As it deals with characters, it is keyboard layout dependent, whereas the key callback is not. Characters do not map 1:1 to physical keys, as a key may produce zero, one or more characters. If you want to know whether a specific physical key was pressed or released, see the `Window.onKey` callback instead.

		The character callback behaves as system text input normally does and will not be called if modifier keys are held down that would prevent normal text input on that platform, for example a Super (Command) key on macOS or Alt key on Windows. For that use `Window.onCharModifiers`.

		Arguments:

		* `codePoint` The Unicode code point of the character.

		To add a callback push a function to this array.
	**/
	public var onChar:Array<(codePoint:UInt) -> Void>;

	/**
		The callbacks to be called when a Unicode character is input regardless of what modifier keys are used.

		The character with modifiers callback is intended for implementing custom Unicode character input. For regular Unicode text input, see the `Window.onChar` callback. Like the character callback, the character with modifiers callback deals with characters and is keyboard layout dependent. Characters do not map 1:1 to physical keys, as a key may produce zero, one or more characters. If you want to know whether a specific physical key was pressed or released, see the `Window.onKey` callback instead.

		Arguments:

		* `codePoint` The Unicode code point of the character.
		* `modifiers` The modifier keys status.

		To add a callback push a function to this array.
	**/
	@:deprecated("Scheduled for removal in GLFW version 4.0")
	public var onCharModifiers:Array<(codePoint:UInt, modifiers:Modifiers) -> Void> = [];

	/**
		The callbacks to be called when the window is closed.

		It is called when the user attempts to close the window, for example by clicking the close widget in the title bar.

		The close flag is set before this callback is called, but you can modify it at any time with `Window.shouldClose`.

		The close callback is not triggered by `Window.destroy`.

		On MacOS selecting Quit from the application menu will trigger the close callback for all windows.

		To add a callback push a function to this array.
	**/
	public var onClose:Array<() -> Void>;

	/**
		The callbacks to be called when the window's content scale change.

		Arguments:

		* `x` The new x-axis content scale of the window.
		* `y` The new y-axis content scale of the window.

		To add a callback push a function to this array.

		@see `Window.contentScale`
	**/
	public var onContentScaleChange:Array<(x:Float, y:Float) -> Void>;

	/**
		The callbacks to be called when the window's cursor enter or leave the window's content area.

		Arguments:

		* `inside` True if the cursor is over the window's content area.

		To add a callback push a function to this array.
	**/
	public var onCursorHoverChange:Array<(inside:Bool) -> Void>;

	/**
		The callbacks to be called when the window's cursor change position.

		Arguments:

		* `x` The new cursor x-coordinate, relative to the left edge of the content area.
		* `y` The new cursor y-coordinate, relative to the left edge of the content area.

		To add a callback push a function to this array.
	**/
	public var onCursorPositionChange:Array<(x:Float, y:Float) -> Void>;

	/**
		The callbacks to be called when the window gains or loses input focus.

		Arguments:

		* `focused` True if the window was given input focus, false if it lost it.

		To add a callback push a function to this array.
	**/
	public var onFocusChange:Array<(focused:Bool) -> Void>;

	/**
		The callbacks to be called when the window is iconified or restored.

		Arguments:

		* `iconified` True if the window was iconified, false if it was restored.

		To add a callback push a function to this array.
	**/
	public var onIconifyChange:Array<(iconified:Bool) -> Void>;

	/**
		The callbacks to be called when a key is pressed, repeated or released.

		This deals with physical keys, with layout independent `Key` tokens named after their values in the standard US keyboard layout.
		If you want to input text, use the `Window.onChar` callback instead.

		When a window loses input focus, it will generate synthetic key release events for all pressed keys.
		You can tell these events from user-generated events by the fact that the synthetic ones are generated after the focus loss event has been processed, i.e. after the window focus callback has been called.

		The scancode of a key is specific to that platform or sometimes even to that machine. Scancodes are intended to allow users to bind keys that don't have a GLFW key token. Such keys have key set to `Key.Unknown`, their state is not saved and so it cannot be queried with `Window.getKeyState`.

		Sometimes GLFW needs to generate synthetic key events, in which case the scancode may be zero.

		Arguments:

		* `key` The keyboard key that was pressed or released.
		* `scancode` The system-specific scancode of the key.
		* `state` The state of the key.
		* `modifiers` The modifier keys status.
	**/
	public var onKey:Array<(key:Key, scancode:Scancode, state:KeyState, modifiers:Modifiers) -> Void>;

	/**
		The callbacks to be called when the window is maximized or restored.

		Arguments:

		* `maximized` True if the window was maximized, false if it was restored.

		To add a callback push a function to this array.
	**/
	public var onMaximizeChange:Array<(maximized:Bool) -> Void>;

	/**
		The callbacks to be called when a mouse button is pressed or released.

		When a window loses input focus, it will generate synthetic mouse button release events for all pressed mouse buttons.
		You can tell these events from user-generated events by the fact that the synthetic ones are generated after the focus loss event has been processed, i.e. after the `Window.onFocusChange` have been called.

		Arguments:

		* `button` The button that was pressed or released.
		* `pressed` True if the button was pressed, false if released.
		* `modifiers` The modifier keys status.

		To add a callback push a function to this array.
	**/
	public var onMouseButton:Array<(button:MouseButton, pressed:Bool, modifiers:Modifiers) -> Void>;

	/**
		The callbacks to be called when a scrolling device is used, such as a mouse wheel or scrolling area of a touchpad.

		Arguments:

		* `x` The scroll offset along the x-axis.
		* `y` The scroll offset along the y-axis.

		To add a callback push a function to this array.
	**/
	public var onMouseScroll:Array<(x:Float, y:Float) -> Void>;

	/**
		The callbacks to be called when one or more dragged paths are dropped on the window.

		Arguments:

		* `paths` The array of UTF-8 encoded file and/or directory path names.

		To add a callback push a function to this array.
	**/
	public var onPathDrop:Array<(paths:Array<String>) -> Void>;

	/**
		The callbacks to be called when the window is moved.

		Arguments:

		* `x` The new x-coordinate, in screen coordinates, of the upper-left corner of the content area of the window.
		* `y` The new y-coordinate, in screen coordinates, of the upper-left corner of the content area of the window.

		To add a callback push a function to this array.
	**/
	public var onPositionChange:Array<(x:Int, y:Int) -> Void>;

	/**
		The callbacks to be called when the content area of the window needs to be redrawn, for example if the window has been exposed after having been covered by another window.

		On compositing window systems such as Aero, Compiz, Aqua or Wayland, where the window contents are saved off-screen, this callback may be called only very infrequently or never at all.

		To add a callback push a function to this array.
	**/
	public var onRefresh:Array<() -> Void>;

	/**
		The callbacks to be called when the window is resized.

		Arguments:

		* `width` The new width, in screen coordinates, of the window.
		* `height` The new height, in screen coordinates, of the window.

		To add a callback push a function to this array.
	**/
	public var onSizeChange:Array<(width:Int, height:Int) -> Void>;

	/**
		The opacity of the whole window, including any decorations.

		The opacity (or alpha) value is a positive finite number between zero and one, where zero is fully transparent and one is fully opaque.
		If the system does not support whole window transparency, this is always one.

		The initial opacity value for newly created windows is one.

		**Thread safety:** This variable must only be used from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var opacity(get, set):Float;

	var parent:GLFW;

	/**
		Whether raw mouse motion is enabled.

		Raw mouse motion is closer to the actual motion of the mouse across a surface.
		It is not affected by the scaling and acceleration applied to the motion of the desktop cursor.
		That processing is suitable for a cursor while raw motion is better for controlling for example a 3D camera.
		Because of this, raw mouse motion is only provided when the cursor is disabled.

		Setting this to `true` if `Window.rawMouseMotionSupported` is `false` will leave it to `false`.

		**Thread safety:** This variable must only be used from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var rawMouseMotion(get, set):Bool;

	/**
		Whether raw mouse motion is supported on the current system.

		This status does not change after GLFW has been initialized so you only need to check this once.

		**Thread safety:** This variable must only be used from the main thread.

		@see `Window.rawMouseMotion`

		@throws UseAfterDestroyException
	**/
	public var rawMouseMotionSupported(get, never):Bool;

	/**
		Whether the windowed mode window will be resizable by the user. The window will still be resizable using the `Window.setSize` function.

		This is ignored for fullscreen and undecorated windows.

		**Thread safety:** This variable must only be used from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var resizable(get, set):Bool;

	/**
		The close flag of the window.

		Setting this can be used to override the user's attempt to close the window, or to signal that it should be closed.

		**Thread safety:** This variable may be used from any thread. Access is not synchronized.

		@throws UseAfterDestroyException
	**/
	public var shouldClose(get, set):Bool;

	/**
		The title of the window.

		**Thread safety:** This variable must only be used from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var title(default, set):String;

	/**
		The current visibility state.

		**Thread safety:** This variable must only be used from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var visible(get, never):Bool;

	function get_autoIconify():Bool {
		validate();

		return untyped __cpp__('glfwGetWindowAttrib(native, GLFW_AUTO_ICONIFY)');
	}

	function set_autoIconify(value:Bool):Bool {
		validate();

		untyped __cpp__('glfwSetWindowAttrib(native, GLFW_AUTO_ICONIFY, value ? GLFW_TRUE : GLFW_FALSE)');

		return value;
	}

	function get_contentScale():{x:Float, y:Float} {
		validate();

		var x:Float32 = 0.0;
		var y:Float32 = 0.0;

		untyped __cpp__('glfwGetWindowContentScale(native, &x, &y)');

		return {
			x: x,
			y: y,
		};
	}

	function set_cursor(value:Null<Cursor>):Null<Cursor> {
		validate();

		untyped __cpp__('glfwSetCursor(native, hx::IsNull(value) ? nullptr : value->native)');

		return cursor = value;
	}

	function get_cursorMode():CursorMode {
		validate();

		return untyped __cpp__('glfwGetInputMode(native, GLFW_CURSOR)');
	}

	function set_cursorMode(value:CursorMode):CursorMode {
		validate();

		untyped __cpp__('glfwSetInputMode(native, GLFW_CURSOR, value)');

		return value;
	}

	function get_cursorPositionX():Float {
		validate();

		var position = 0.0;
		untyped __cpp__('glfwGetCursorPos(native, &position, nullptr)');
		return position;
	}

	function set_cursorPositionX(value:Float):Float {
		validate();

		untyped __cpp__('
			double y;
			glfwGetCursorPos(native, nullptr, &y);
			glfwSetCursorPos(native, value, y);
		');

		return value;
	}

	function get_cursorPositionY():Float {
		validate();

		var position = 0.0;
		untyped __cpp__('glfwGetCursorPos(native, nullptr, &position)');
		return position;
	}

	function set_cursorPositionY(value:Float):Float {
		validate();

		untyped __cpp__('
			double x;
			glfwGetCursorPos(native, &x, nullptr);
			glfwSetCursorPos(native, x, value);
		');

		return value;
	}

	function get_decorated():Bool {
		validate();

		return untyped __cpp__('glfwGetWindowAttrib(native, GLFW_DECORATED)');
	}

	function set_decorated(value:Bool):Bool {
		validate();

		untyped __cpp__('glfwSetWindowAttrib(native, GLFW_DECORATED, value ? GLFW_TRUE : GLFW_FALSE)');

		return value;
	}

	function get_floating():Bool {
		validate();

		return untyped __cpp__('glfwGetWindowAttrib(native, GLFW_FLOATING)');
	}

	function set_floating(value:Bool):Bool {
		validate();

		untyped __cpp__('glfwSetWindowAttrib(native, GLFW_FLOATING, value ? GLFW_TRUE : GLFW_FALSE)');

		return value;
	}

	function get_focused():Bool {
		validate();

		return untyped __cpp__('glfwGetWindowAttrib(native, GLFW_FOCUSED)');
	}

	function get_focusOnShow():Bool {
		validate();

		return untyped __cpp__('glfwGetWindowAttrib(native, GLFW_FOCUS_ON_SHOW)');
	}

	function set_focusOnShow(value:Bool):Bool {
		validate();

		untyped __cpp__('glfwSetWindowAttrib(native, GLFW_FOCUS_ON_SHOW, value ? GLFW_TRUE : GLFW_FALSE)');

		return value;
	}

	function get_frameSize():{
		left:Int,
		top:Int,
		right:Int,
		bottom:Int
	} {
		validate();

		var left = 0;
		var top = 0;
		var right = 0;
		var bottom = 0;

		untyped __cpp__('glfwGetWindowFrameSize(native, &left, &top, &right, &bottom)');

		return {
			left: left,
			top: top,
			right: right,
			bottom: bottom,
		};
	}

	function get_keysSticky():Bool {
		validate();

		return untyped __cpp__('glfwGetInputMode(native, GLFW_STICKY_KEYS) == GLFW_TRUE');
	}

	function set_keysSticky(value:Bool):Bool {
		validate();

		untyped __cpp__('glfwSetInputMode(native, GLFW_STICKY_KEYS, value ? GLFW_TRUE : GLFW_FALSE)');
		return value;
	}

	function get_lockKeyModifiers():Bool {
		validate();

		return untyped __cpp__('glfwGetInputMode(native, GLFW_STICKY_KEYS) == GLFW_TRUE');
	}

	function set_lockKeyModifiers(value:Bool):Bool {
		validate();

		untyped __cpp__('glfwSetInputMode(native, GLFW_STICKY_KEYS, value ? GLFW_TRUE : GLFW_FALSE)');
		return value;
	}

	function get_maximized():Bool {
		validate();

		return untyped __cpp__('glfwGetWindowAttrib(native, GLFW_MAXIMIZED)');
	}

	function get_mouseButtonsSticky():Bool {
		validate();

		return untyped __cpp__('glfwGetInputMode(native, GLFW_STICKY_MOUSE_BUTTONS) == GLFW_TRUE');
	}

	function set_mouseButtonsSticky(value:Bool):Bool {
		validate();

		untyped __cpp__('glfwSetInputMode(native, GLFW_STICKY_MOUSE_BUTTONS, value ? GLFW_TRUE : GLFW_FALSE)');
		return value;
	}

	function get_opacity():Float {
		validate();

		return untyped __cpp__('glfwGetWindowOpacity(native)');
	}

	function set_opacity(value:Float):Float {
		validate();

		untyped __cpp__('glfwSetWindowOpacity(native, (float)value)');

		return value;
	}

	function get_rawMouseMotion():Bool {
		validate();

		return untyped __cpp__('glfwGetInputMode(native, GLFW_RAW_MOUSE_MOTION) == GLFW_TRUE');
	}

	function set_rawMouseMotion(value:Bool):Bool {
		validate();

		if (!rawMouseMotionSupported) {
			return false;
		}

		untyped __cpp__('glfwSetInputMode(native, GLFW_RAW_MOUSE_MOTION, value ? GLFW_TRUE : GLFW_FALSE)');
		return value;
	}

	function get_rawMouseMotionSupported():Bool {
		validate();

		return untyped __cpp__('glfwRawMouseMotionSupported() == GLFW_TRUE');
	}

	function get_resizable():Bool {
		validate();

		return untyped __cpp__('glfwGetWindowAttrib(native, GLFW_RESIZABLE)');
	}

	function set_resizable(value:Bool):Bool {
		validate();

		untyped __cpp__('glfwSetWindowAttrib(native, GLFW_RESIZABLE, value ? GLFW_TRUE : GLFW_FALSE)');

		return value;
	}

	function get_shouldClose():Bool {
		validate();

		return untyped __cpp__('glfwWindowShouldClose(native)');
	}

	function set_shouldClose(value:Bool):Bool {
		validate();

		untyped __cpp__('glfwSetWindowShouldClose(native, value)');

		return value;
	}

	function set_title(value:String):String {
		validate();

		untyped __cpp__('glfwSetWindowTitle(native, value)');

		return title = value;
	}

	function get_visible():Bool {
		validate();

		return untyped __cpp__('glfwGetWindowAttrib(native, GLFW_VISIBLE)');
	}

	function new(parent:GLFW, options:WindowOptions) {
		@:bypassAccessor this.cursor = null;
		this.onChar = [];
		this.onClose = [];
		this.onContentScaleChange = [];
		this.onCursorHoverChange = [];
		this.onCursorPositionChange = [];
		this.onFocusChange = [];
		this.onIconifyChange = [];
		this.onKey = [];
		this.onMaximizeChange = [];
		this.onMouseButton = [];
		this.onMouseScroll = [];
		this.onPathDrop = [];
		this.onPositionChange = [];
		this.onRefresh = [];
		this.onSizeChange = [];
		this.parent = parent;
		@:bypassAccessor this.title = options.title;

		windows.push(this);

		final resetVisible = options.visible == null || options.visible;

		if (options.openCentered != null && options.openCentered && options.monitor == null) {
			options.visible = false;
		}

		untyped __cpp__('
			glfwDefaultWindowHints();
			glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
			glfwWindowHint(GLFW_RED_BITS, GLFW_DONT_CARE);
			glfwWindowHint(GLFW_GREEN_BITS, GLFW_DONT_CARE);
			glfwWindowHint(GLFW_BLUE_BITS, GLFW_DONT_CARE);

			if (!hx::IsNull(options->autoIconify)) {
				glfwWindowHint(GLFW_AUTO_ICONIFY, options->autoIconify ? GLFW_TRUE : GLFW_FALSE);
			}

			if (!hx::IsNull(options->centerCursor)) {
				glfwWindowHint(GLFW_CENTER_CURSOR, options->centerCursor ? GLFW_TRUE : GLFW_FALSE);
			}

			if (!hx::IsNull(options->decorated)) {
				glfwWindowHint(GLFW_DECORATED, options->decorated ? GLFW_TRUE : GLFW_FALSE);
			}

			if (!hx::IsNull(options->floating)) {
				glfwWindowHint(GLFW_FLOATING, options->floating ? GLFW_TRUE : GLFW_FALSE);
			}

			if (!hx::IsNull(options->focused)) {
				glfwWindowHint(GLFW_FOCUSED, options->focused ? GLFW_TRUE : GLFW_FALSE);
			}

			if (!hx::IsNull(options->focusOnShow)) {
				glfwWindowHint(GLFW_FOCUS_ON_SHOW, options->focusOnShow ? GLFW_TRUE : GLFW_FALSE);
			}

			if (!hx::IsNull(options->maximized)) {
				glfwWindowHint(GLFW_MAXIMIZED, options->maximized ? GLFW_TRUE : GLFW_FALSE);
			}

			if (!hx::IsNull(options->resizable)) {
				glfwWindowHint(GLFW_RESIZABLE, options->resizable ? GLFW_TRUE : GLFW_FALSE);
			}

			if (!hx::IsNull(options->visible)) {
				glfwWindowHint(GLFW_VISIBLE, options->visible ? GLFW_TRUE : GLFW_FALSE);
			}

			native = glfwCreateWindow(options->width, options->height, options->title, hx::IsNull(options->monitor) ? nullptr : options->monitor->native, nullptr);

			glfwSetCharCallback(native, char_callback);
			glfwSetCharModsCallback(native, char_mods_callback);
			glfwSetCursorEnterCallback(native, cursor_enter_callback);
			glfwSetCursorPosCallback(native, cursor_pos_callback);
			glfwSetDropCallback(native, drop_callback);
			glfwSetKeyCallback(native, key_callback);
			glfwSetMouseButtonCallback(native, mouse_button_callback);
			glfwSetScrollCallback(native, scroll_callback);
			glfwSetWindowCloseCallback(native, close_callback);
			glfwSetWindowContentScaleCallback(native, contentscale_callback);
			glfwSetWindowFocusCallback(native, focus_callback);
			glfwSetWindowIconifyCallback(native, iconify_callback);
			glfwSetWindowMaximizeCallback(native, maximize_callback);
			glfwSetWindowPosCallback(native, pos_callback);
			glfwSetWindowRefreshCallback(native, refresh_callback);
			glfwSetWindowSizeCallback(native, size_callback);
		');

		if (options.openCentered != null && options.openCentered && options.monitor == null) {
			final area = parent.primaryMonitor.workarea;
			final size = getSize();

			setPosition(Std.int((area.width - size.width) / 2), Std.int((area.height - size.height) / 2));

			if (resetVisible) {
				show();
			}
		}

		if (options.cursor != null) {
			cursor = options.cursor;
		}

		if (options.cursorMode != null) {
			cursorMode = options.cursorMode;
		}

		if (options.keysSticky != null) {
			keysSticky = options.keysSticky;
		}

		if (options.lockKeyModifiers != null) {
			lockKeyModifiers = options.lockKeyModifiers;
		}

		if (options.mouseButtonsSticky != null) {
			mouseButtonsSticky = options.mouseButtonsSticky;
		}

		if (options.opacity != null) {
			opacity = options.opacity;
		}
	}

	/**
		Destroys the window.

		On calling this function, no further callbacks will be called for that window.

		Using the object after this will throw a `UseAfterDestroyException` exception.

		**Reentrancy:** This function must not be called from a callback.

		**Thread safety:** This function must only be called from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public function destroy():Void {
		validate();

		untyped __cpp__('
			glfwDestroyWindow(native);
			native = nullptr;
		');

		windows.remove(this);
	}

	/**
		Brings the window to front and sets input focus.

		The window should already be visible and not iconified.

		By default, both windowed and fullscreen mode windows are focused when initially created.

		Also by default, windowed mode windows are focused when shown with `Window.show`. Set `WindowOptions.focusOnShow` or `Window.focusOnShow` to disable this behavior.

		__Do not use this function__ to steal focus from other applications unless you are certain that is what the user wants. Focus stealing can be extremely disruptive.

		For a less disruptive way of getting the user's attention, see  `Window.requestAttention`.

		On wayland it is not possible for an application to bring its windows to front, this function will always throw an exception.

		**Thread safety:** This function must only be called from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public function focus():Void {
		validate();

		untyped __cpp__('glfwFocusWindow(native)');
	}

	/**
		Returns the monitor that the window uses for fullscreen mode.

		**Thread safety:** This function must only be called from the main thread.

		@throws NotFullscreenException if the window is in windowed mode.
		@throws UseAfterDestroyException
	**/
	public function getFullscreenMonitor():Monitor {
		validate();

		untyped __cpp__('GLFWmonitor *native_monitor = glfwGetWindowMonitor(native)');

		for (m in parent.monitors) {
			if (untyped __cpp__('m->native == native_monitor')) {
				return m;
			}
		}

		throw new NotFullscreenException(this);
	}

	/**
		Get a key state.

		This returns the last state reported for the specified key to the window.
		The returned state is one of `KeyState.Press` or `KeyState.Release`.
		The higher-level action `KeyState.Repeat` is only reported to the `Window.onKey` callback.

		This function only returns cached key event state. It does not poll the system for the current physical state of the key.

		Whenever you poll state, you risk missing the state change you are looking for. If a pressed key is released again before you poll its state, you will have missed the key press. The recommended solution for this is to use a `Window.onKey` callback, but there is also the `Window.keysSticky` input mode.

		If the `Window.keysSticky` input mode is set to `true`, this function returns `KeyState.Press` the first time you call it for a key that was pressed, even if that key has already been released.

		The key functions deal with physical keys, with key tokens named after their use on the standard US keyboard layout.
		If you want to input text, use the Unicode `Window.onChar` callback instead.

		**Do not** use this function to implement text input.

		**Thread safety:** This function must only be called from the main thread.

		@param key The desired keyboard key. `Key.Unknown` is not a valid key for this function.

		@return The state of the key.

		@throws UseAfterDestroyException
	**/
	public function getKeyState(key:Key):KeyState {
		validate();

		return untyped __cpp__('glfwGetKey(native, key)');
	}

	/**
		Returns the last reported state of a mouse button.

		If `Window.mouseButtonSticky` is true, this function returns `true` the first time you call it for a mouse button that was pressed, even if that mouse button has already been released.

		**Thread safety:** This function must only be called from the main thread.

		@param button The mouse button to get.

		@return True if the `button` is pressed, false otherwise.

		@throws UseAfterDestroyException
	**/
	public function getMouseButton(button:MouseButton):Bool {
		validate();

		return untyped __cpp__('glfwGetMouseButton(native, button) == GLFW_PRESS');
	}

	/**
		Retrieves the position of the content area of the window.

		This function retrieves the position, in screen coordinates, of the upper-left corner of the content area of window.

		On wayland there is no way for an application to retrieve the global position of its windows, this function will always throw an exception.

		**Thread safety:** This function must only be called from the main thread.

		@see `Window.setPosition`

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public function getPosition():{x:Int, y:Int} {
		validate();

		var x = 0;
		var y = 0;

		untyped __cpp__('glfwGetWindowPos(native, &x, &y)');

		return {
			x: x,
			y: y,
		};
	}

	/**
		Retrieves the size, in screen coordinates, of the content area of the window.

		**Thread safety:** This function must only be called from the main thread.

		@see `Window.setSize`

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public function getSize():{width:Int, height:Int} {
		validate();

		var width = 0;
		var height = 0;

		untyped __cpp__('glfwGetWindowSize(native, &width, &height)');

		return {
			width: width,
			height: height,
		};
	}

	/**
		Hides the window.

		This function hides the window if it was previously visible.
		If the window is already hidden or is in fullscreen mode, this function does nothing.

		**Thread safety:** This function must only be called from the main thread.

		@see `Window.show`

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public function hide():Void {
		validate();

		untyped __cpp__('glfwHideWindow(native)');
	}

	/**
		Iconifies the window.

		This function iconifies (minimizes) the specified window if it was previously restored.
		If the window is already iconified, this function does nothing.

		If the window is a fullscreen window, the original monitor resolution is restored until the window is restored.

		On wayland once a window is iconified, `Window.restore` won’t be able to restore it.
		This is a design decision of the xdg-shell protocol.

		**Thread safety:** This function must only be called from the main thread.

		@see `Window.restore`

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public function iconify():Void {
		validate();

		untyped __cpp__('glfwIconifyWindow(native)');
	}

	/**
		Maximizes the window.

		This function maximizes the window if it was previously not maximized.
		If the window is already maximized, this function does nothing.

		If the specified window is a fullscreen window, this function does nothing.

		**Thread safety:** This function must only be called from the main thread.

		@see `Window.restore`

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public function maximize():Void {
		validate();

		untyped __cpp__('glfwMaximizeWindow(native)');
	}

	/**
		Obtain the native handle of the window.

		On Windows `windowsHWND` will contain the `HWND` of the window, all other fields will be empty.

		On MacOS `macNSWindow` will contain the `NSWindow` of the window, all other fields will be empty.

		On Linux X11 `linuxX11Display` will contain `Display` used by GLFW and `linuxX11Window` the `Window` of the window, all other fields will be empty.

		**Thread safety:** This function may be called from any thread. Access is not synchronized.

		@throws UseAfterDestroyException
	**/
	public function nativeHandle():{
		windowsHWND:Star<cpp.Void>,
		macNSWindow:Star<cpp.Void>,
		linuxX11Display:Star<cpp.Void>,
		linuxX11Window:UInt32
	} {
		validate();

		var windowsHWND:Star<cpp.Void> = cast 0;
		var macNSWindow:Star<cpp.Void> = cast 0;
		var linuxX11Display:Star<cpp.Void> = cast 0;
		var linuxX11Window:UInt32 = 0;

		untyped __cpp__('
			#ifdef GLFW_EXPOSE_NATIVE_WIN32
			windowsHWND = glfwGetWin32Window(native);
			#endif

			#ifdef GLFW_EXPOSE_NATIVE_COCOA
			macNSWindow = glfwGetCocoaWindow(native);
			#endif

			#ifdef GLFW_EXPOSE_NATIVE_X11
			linuxX11Display = glfwGetX11Display();
			linuxX11Window = glfwGetX11Window(native);
			#endif
		');

		return {
			windowsHWND: windowsHWND,
			macNSWindow: macNSWindow,
			linuxX11Display: linuxX11Display,
			linuxX11Window: linuxX11Window,
		}
	}

	/**
		Requests user attention to the window.

		On platforms where this is not supported, attention is requested to the  application as a whole.

		Once the user has given attention, usually by focusing the window or application, the system will end the request automatically.

		On MacOS attention is requested to the application as a whole, not the specific window.

		**Thread safety:** This function must only be called from the main thread.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public function requestAttention():Void {
		validate();

		untyped __cpp__('glfwRequestWindowAttention(native)');
	}

	/**
		Restores the window.

		This function restores the window if it was previously iconified (minimized) or maximized.
		If the window is already restored, this function does nothing.

		If the window is a fullscreen window, the resolution chosen for the window is restored on the selected monitor.

		**Thread safety:** This function must only be called from the main thread.

		@see `Window.iconify`
		@see `Window.maximize`

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public function restore():Void {
		validate();

		untyped __cpp__('glfwRestoreWindow(native)');
	}

	/**
		Sets the required aspect ratio of the content area of the window.

		If the window is fullscreen, the aspect ratio only takes effect once it is made windowed.

		If the window is not resizable, this function does nothing.

		The aspect ratio is specified as a numerator and a denominator and both values must be greater than zero. For example, the common 16:9 aspect ratio is specified as 16 and 9, respectively.

		The aspect ratio is applied immediately to a windowed mode window and may cause it to be resized.

		If you set size limits and an aspect ratio that conflict, the results are undefined.

		On wayland the aspect ratio will not be applied until the window is actually resized, either by the user or by the compositor.

		**Thread safety:** This function must only be called from the main thread.

		@param numerator The numerator of the desired aspect ratio.
		@param denominator The denominator of the desired aspect ratio.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public function setAspectRatio(numerator:Int, denominator:Int):Void {
		validate();

		untyped __cpp__('glfwSetWindowAspectRatio(native, numerator, denominator)');
	}

	/**
		Sets the monitor that the window uses for fullscreen mode or, if `monitor` is `null`, makes it windowed mode.

		When setting a monitor, this function updates the width, height and refresh rate of the desired video mode and switches to the video mode closest to it.

		The window position is ignored when setting a monitor.

		When `monitor` is `null`, the position `x` and `y`, `width` and `height` are used to place the window content area.
		The refresh rate `refreshRate` is ignored when no monitor is specified.

		If you only wish to update the resolution of a fullscreen window or the size of a windowed mode window, see `Window.setSize`.

		When a window transitions from full screen to windowed mode, this function restores any previous window settings such as whether it is decorated, floating, resizable, has size or aspect ratio limits, etc.

		On wayland the desired window position is ignored, as there is no way for an application to set this property.

		On wayland setting the window to fullscreen will not attempt to change the mode, no matter what the requested size or refresh rate.

		**Thread safety:** This function must only be called from the main thread.

		@param monitor The desired monitor, or `null` to set windowed mode.
		@param x The desired x-coordinate of the upper-left corner of the content area.
		@param y The desired y-coordinate of the upper-left corner of the content area.
		@param width The desired with, in screen coordinates, of the content area or video mode.
		@param height The desired height, in screen coordinates, of the content area or video mode.
		@param refreshRate Optional, the desired refresh rate, in Hz, of the video mode.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public function setFullscreenMonitor(monitor:Null<Monitor>, x:Int, y:Int, width:Int, height:Int, ?refreshRate:Int):Void {
		validate();

		untyped __cpp__('glfwSetWindowMonitor(native, hx::IsNull(monitor) ? nullptr : monitor->native, x, y, width, height, hx::IsNull(refreshRate) ? GLFW_DONT_CARE : (int)refreshRate)');
	}

	/**
		Sets the icon of the window.

		If passed several candidate images, those of or closest to the sizes desired by the system are selected.

		If an empty array is passed, the window reverts to its default icon.

		The pixels are 32-bit, little-endian, non-premultiplied RGBA, i.e. eight bits per channel with the red channel first. They are arranged canonically as packed sequential rows, starting from the top-left corner.

		The desired image sizes varies depending on platform and system settings.
		The selected images will be rescaled as needed.
		Good sizes include 16x16, 32x32 and 48x48.

		On MacOS the GLFW window has no icon, as it is not a document window, so this function does nothing. The dock icon will be the same as the application bundle's icon. For more information on bundles, see the [Bundle Programming Guide](https://developer.apple.com/library/mac/documentation/CoreFoundation/Conceptual/CFBundles/) in the Mac Developer Library.

		On wayland there is no existing protocol to change an icon, the window will thus inherit the one defined in the application's desktop file. This function will always throw an exception.

		**Thread safety:** This function must only be called from the main thread.

		@param icons The images to create the icon from, or an empty array to revert to the default window icon.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public function setIcon(icons:Array<Image>):Void {
		validate();

		untyped __cpp__('
			GLFWimage *images = (GLFWimage*)malloc(sizeof(*images) * icons->length);
			unsigned char **pixels = (unsigned char**)malloc(sizeof(*pixels) * icons->length);

			for (unsigned int i = 0; i < icons->length; ++i) {
				auto elem = icons->__get(i).StaticCast<glfw::Image>();

				pixels[i] = (unsigned char*)malloc(sizeof(**pixels) * elem->pixels->length);

				for (unsigned int j = 0; j < elem->pixels->length; ++j) {
					pixels[i][j] = elem->pixels->__get(j);
				}

				images[i] = (GLFWimage){
					width: elem->width,
					height: elem->height,
					pixels: pixels[i],
				};
			}

			glfwSetWindowIcon(native, icons->length, images);

			for (unsigned int i = 0; i < icons->length; ++i) {
				free(pixels[i]);
			}

			free(pixels);
			free(images);
		');

	}

	/**
		Sets the position, in screen coordinates, of the upper-left corner of the content area of the windowed mode window.

		If the window is a fullscreen window, this function does nothing.

		__Do not use this function__ to move an already visible window unless you have very good reasons for doing so, as it will confuse and annoy the user.

		The window manager may put limits on what positions are allowed. GLFW cannot and should not override these limits.

		On wayland there is no way for an application to set the global position of its windows, this function will always throw an exception.

		**Thread safety:** This function must only be called from the main thread.

		@param x The x-coordinate of the upper-left corner of the content area.
		@param y The y-coordinate of the upper-left corner of the content area.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public function setPosition(x:Int, y:Int):Void {
		validate();

		untyped __cpp__('glfwSetWindowPos(native, x, y)');
	}

	/**
		Sets the size, in screen coordinates, of the content area of the window.

		For fullscreen windows, this function updates the resolution of its desired video mode and switches to the video mode closest to it.

		If you wish to update the refresh rate of the desired video mode in addition to its resolution, see `Window.setFullscreenMonitor`.

		The window manager may put limits on what sizes are allowed. GLFW cannot and should not override these limits.

		On wayland a fullscreen window will not attempt to change the mode, no matter what the requested size.

		**Thread safety:** This function must only be called from the main thread.

		@param width The desired width, in screen coordinates, of the window content area.
		@param height The desired height, in screen coordinates, of the window content area.

		@see `Window.getSize`

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public function setSize(width:Int, height:Int):Void {
		validate();

		untyped __cpp__('glfwSetWindowSize(native, width, height)');
	}

	/**
		Sets the size limits of the content area of the window.

		If the window is fullscreen, the size limits only take effect once it is made windowed.

		If the window is not resizable, this function does nothing.

		The size limits are applied immediately to a windowed mode window and may cause it to be resized.

		The maximum dimensions must be greater than or equal to the minimum dimensions and all must be greater than or equal to zero.

		If you set size limits and an aspect ratio that conflict, the results are undefined.

		On wayland the size limits will not be applied until the window is actually resized, either by the user or by the compositor.

		**Thread safety:** This function must only be called from the main thread.

		@param minWidth The minimum width, in screen coordinates, of the content area.
		@param minHeight The minimum height, in screen coordinates, of the content area.
		@param maxWidth The maximum width, in screen coordinates, of the content area.
		@param maxHeight The maximum height, in screen coordinates, of the content area.

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public function setSizeLimits(minWidth:Int, minHeight:Int, maxWidth:Int, maxHeight:Int):Void {
		validate();

		untyped __cpp__('glfwSetWindowSizeLimits(native, minWidth, minHeight, maxWidth, maxHeight)');
	}

	/**
		Makes the window visible if it was previously hidden.

		If the window is already visible or is in full screen mode, this function does nothing.

		By default, windowed mode windows are focused when shown, set `WindowOptions.focusOnShow` or `Window.focusOnShow` to change this behavior.

		**Thread safety:** This function must only be called from the main thread.

		@see `Window.hide`

		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public function show():Void {
		validate();

		untyped __cpp__('glfwShowWindow(native)');
	}

	/**
		@throws UseAfterDestroyException
	**/
	function validate() {
		if (untyped __cpp__('native == nullptr')) {
			throw new UseAfterDestroyException();
		}

		GLFW.validate();
	}
}
