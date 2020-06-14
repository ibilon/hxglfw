package glfw;

/**
	Cursor shape.

	Not all shapes are available on all platforms, see `GLFW.createStandardCursor` for more details.
**/
enum abstract CursorShape(Int) {
	/** The regular arrow cursor shape. **/
	var Arrow = 0x00036001;

	/** The text input I-beam cursor shape. **/
	var IBeam = 0x00036002;

	/** The crosshair cursor shape. **/
	var Crosshair = 0x00036003;

	/** The pointing hand cursor shape. **/
	var PointingHand = 0x00036004;

	/**
		The horizontal resize/move arrow shape.

		This is usually a horizontal double-headed arrow.
	**/
	var ResizeEW = 0x00036005;

	/**
		The vertical resize/move shape.

		This is usually a vertical double-headed arrow.
	**/
	var ResizeNS = 0x00036006;

	/**
		The top-left to bottom-right diagonal resize/move shape. This is usually a diagonal double-headed arrow.

		On MacOS this shape is provided by a private system API and may fail when used.

		On X11 and Wayland this shape is provided by a newer standard not supported by all cursor themes.
	**/
	var ResizeNWSE = 0x00036007;

	/**
		The top-right to bottom-left diagonal resize/move shape. This is usually a diagonal double-headed arrow.

		On MacOS this shape is provided by a private system API and may fail when used.

		On X11 and Wayland this shape is provided by a newer standard not supported by all cursor themes.
	**/
	var ResizeNESW = 0x00036008;

	/**
		The omni-directional resize cursor/move shape.

		This is usually either a combined horizontal and vertical double-headed arrow or a grabbing hand.
	**/
	var ResizeAll = 0x00036009;

	/**
		The operation-not-allowed shape. This is usually a circle with a diagonal line through it.

		On X11 and Wayland this shape is provided by a newer standard not supported by all cursor themes.
	**/
	var NotAllowed = 0x0003600A;
}
