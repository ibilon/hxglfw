package glfw.mouse;

/**
	Cursor mode for `Window.cursorMode`.
**/
enum abstract CursorMode(Int) {
	/**
		Normal cursor mode

		The regular arrow cursor (or another cursor set with `Window.cursor`) is used and cursor motion is not limited.

		This is the default mode.
	**/
	var Normal = 0x00034001;

	/**
		Hidden cursor mode.

		When you only wish the cursor to become hidden when it is over the window but still want it to behave normally.

		This mode puts no limit on the motion of the cursor.
	**/
	var Hidden = 0x00034002;

	/**
		Disabled cursor mode.

		This hides the cursor and lock it to the window.

		Used when you wish to implement mouse motion based camera controls or other input schemes that require unlimited mouse movement.
	**/
	var Disabled = 0x00034003;
}
