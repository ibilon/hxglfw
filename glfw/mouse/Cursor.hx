package glfw.mouse;

import glfw.errors.*;

/**
	A cursor, to be set in `Window.cursor`.

	To create a new cursor use `GLFW.createStandardCursor` or `GLFW.createCursor`.

	Using the cursor after it was destroyed with `Cursor.destroy` or after the GLFW object was destroyed with `GLFW.destroy` will throw a `UseAfterDestroyException` exception.
**/
@:allow(glfw)
@:headerClassCode('
	GLFWcursor *native;
')
@:headerInclude('./../glfw.h')
class Cursor {
	var parent:GLFW;

	function new(parent:GLFW) {
		this.parent = parent;
	}

	/**
		Destroys the cursor.

		If the specified cursor is current for any window, that window will be reverted to the default cursor. This does not affect the cursor mode.

		Using the object after this will throw a `UseAfterDestroyException` exception.
	**/
	public function destroy():Void {
		validate();

		untyped __cpp__('
			glfwDestroyCursor(native);
			native = nullptr;
		');
	}

	function validate():Void {
		if (untyped __cpp__('native == nullptr')) {
			throw new UseAfterDestroyException();
		}

		parent.validate();
	}
}
