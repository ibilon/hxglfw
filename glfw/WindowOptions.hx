package glfw;

import glfw.mouse.*;

/**
	Options used to create a window in `GLFW.createWindow`.

	This should be created through a structure:
	```haxe
	glfw.createWindow({
		title: "The title",
		width: 800,
		height: 600,
	});
	```
**/
@:structInit
class WindowOptions {
	/** The initial, UTF-8 encoded window title. **/
	public var title:String;

	/** The desired width, in screen coordinates, of the window. This must be greater than zero. **/
	public var width:Int;

	/** The desired height, in screen coordinates, of the window. This must be greater than zero. **/
	public var height:Int;

	/** Optional, if present the monitor to use for fullscreen mode, else the window will be in windowed mode. **/
	@:optional public var monitor:Null<Monitor>;

	/**
		Optional, specifies whether the fullscreen window will automatically iconify and restore the previous video mode on input focus loss.

		This is ignored for windowed mode windows.

		Default value is true.
	**/
	@:optional public var autoIconify:Null<Bool>;

	/**
		Optional, specifies whether the cursor should be centered over the newly created fullscreen window.

		This is ignored for windowed mode windows.

		Default value is true.
	**/
	@:optional public var centerCursor:Null<Bool>;

	/**
		Optional, specifies the default cursor to be used by the newly created window.

		Defaults to the system cursor.
	**/
	@:optional public var cursor:Null<Cursor>;

	/**
		Optional, specifies the cursor mode to be used by the newly created window.

		Default valuse is `CursorMode.Normal`.
	**/
	@:optional public var cursorMode:Null<CursorMode>;

	/**
		Optional, specifies whether the windowed mode window will have window decorations such as a border, a close widget, etc. An undecorated window will not be resizable by the user but will still allow the user to generate close events on some platforms.

		This is ignored for fullscreen windows.

		Default value is true.
	**/
	@:optional public var decorated:Null<Bool>;

	/**
		Optional, specifies whether the windowed mode window will be floating above other regular windows, also called topmost or always-on-top. This is intended primarily for debugging purposes and cannot be used to implement proper fullscreen windows.

		This is ignored for fullscreen windows.

		Default value is false.
	**/
	@:optional public var floating:Null<Bool>;

	/**
		Optional, specifies whether the created window is given input focus.

		Default value is true.
	**/
	@:optional public var focused:Null<Bool>;

	/**
		Optional, specifies whether the window will be given input focus when `Window.show` is called.

		Default value is true.
	**/
	@:optional public var focusOnShow:Null<Bool>;

	/**
		Optional, specifies whether sticky keys are enabled for the newly created window.
	**/
	@:optional public var keysSticky:Null<Bool>;

	/**
		Optional, specifies whether caps lock and num lock key modifiers are set on key events for the newly created window.
	**/
	@:optional public var lockKeyModifiers:Null<Bool>;

	/**
		Optional, specifies whether the window is maximized.

		Default value is false.
	**/
	@:optional public var maximized:Null<Bool>;

	/**
		Optional, specifies whether sticky mouse buttons are enabled for the newly created window.
	**/
	@:optional public var mouseButtonsSticky:Null<Bool>;

	/**
		Optional, specifies the opacity of the newly created window.

		Default value is 1.0.
	**/
	@:optional public var opacity:Null<Float>;

	/**
		Optional, specifies whether the window will be opened at the center of the screen instead of the placement recommended by the window system.

		This is ignored for fullscreen windows.

		Default value is false.
	**/
	@:optional public var openCentered:Null<Bool>;

	/**
		Optional, specifies whether the windowed mode window will be resizable by the user. The window will still be resizable using the `Window.setSize` function.

		This is ignored for fullscreen and undecorated windows.

		Default value is true.
	**/
	@:optional public var resizable:Null<Bool>;

	/**
		Optional, specifies whether the window is visible.

		Default value is true.
	**/
	@:optional public var visible:Null<Bool>;
}
