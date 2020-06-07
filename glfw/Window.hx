package glfw;

import glfw.errors.UseAfterDestroyException;

@:allow(glfw)
@:headerClassCode('
	GLFWwindow *native;
')
@:headerInclude('./glfw.h')
class Window {
	var destroyed:Bool;

	var parent:GLFW;

	public var shouldClose(get, set):Bool;

	public var title(default, set):String;

	function get_shouldClose():Bool {
		validate();

		return untyped __cpp__('glfwWindowShouldClose(native)'); // TODO int vs bool?
	}

	function set_shouldClose(value:Bool):Bool {
		validate();

		untyped __cpp__('glfwSetWindowShouldClose(native, value)'); // TODO int vs bool?

		return value;
	}

	function set_title(value:String):String {
		validate();

		untyped __cpp__('glfwSetWindowTitle(native, value)');

		return title = value;
	}

	function new(parent:GLFW, options:WindowOptions) {
		destroyed = false;
		this.parent = parent;
		@:bypassAccessor title = options.title;

		// glfwWindowHint(int hint, int value); // used internally by createWindow
		// glfwWindowHintString(int hint, const char * value); // used internally by createWindow
		// glfwCreateWindow(int width, int height, const char * title, GLFWmonitor * monitor, GLFWwindow * share);

		untyped __cpp__('native = glfwCreateWindow(options->width, options->height, options->title, nullptr, nullptr)');
	}

	public function destroy():Void {
		validate();

		untyped __cpp__('glfwDestroyWindow(native)');
		destroyed = true;
	}

	function validate() {
		if (destroyed) {
			throw new UseAfterDestroyException();
		}

		parent.validate();
	}
}
