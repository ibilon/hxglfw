package glfw;

import glfw.errors.UseAfterDestroyException;

@:allow(glfw)
@:cppNamespaceCode('
	static void pos_callback(GLFWwindow *window, int x, int y) {
		for (unsigned int i = 0; i < glfw::Window_obj::windows->length; ++i) {
			auto elem = glfw::Window_obj::windows->__get(i).StaticCast<glfw::Window>();

			if (elem->native == window) {
				for (unsigned int j = 0; j < elem->onPositionChange->length; ++j) {
					elem->onPositionChange->__get(j)(x, y);
				}
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

	var destroyed:Bool;

	var parent:GLFW;

	public var onPositionChange:Array<(x:Int, y:Int) -> Void>;

	public var shouldClose(get, set):Bool;

	public var title(default, set):String;

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

	function new(parent:GLFW, options:WindowOptions) {
		this.destroyed = false;
		this.onPositionChange = [];
		this.parent = parent;
		@:bypassAccessor this.title = options.title;

		// glfwWindowHint(int hint, int value); // used internally by createWindow
		// glfwWindowHintString(int hint, const char * value); // used internally by createWindow
		// glfwCreateWindow(int width, int height, const char * title, GLFWmonitor * monitor, GLFWwindow * share);

		windows.push(this);

		untyped __cpp__('
			native = glfwCreateWindow(options->width, options->height, options->title, nullptr, nullptr);
			glfwSetWindowPosCallback(native, pos_callback);
		');
	}

	public function destroy():Void {
		validate();

		untyped __cpp__('glfwDestroyWindow(native)');
		destroyed = true;

		windows.remove(this);
	}

	function validate() {
		if (destroyed) {
			throw new UseAfterDestroyException();
		}

		parent.validate();
	}
}
