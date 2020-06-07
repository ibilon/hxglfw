package glfw;

import glfw.errors.UseAfterDestroyException;

@:allow(glfw)
@:cppNamespaceCode('
	static void close_callback(GLFWwindow *window) {
		for (unsigned int i = 0; i < glfw::Window_obj::windows->length; ++i) {
			auto elem = glfw::Window_obj::windows->__get(i).StaticCast<glfw::Window>();

			if (elem->native == window) {
				for (unsigned int j = 0; j < elem->onClose->length; ++j) {
					elem->onClose->__get(j)();
				}
			}
		}
	}

	static void contentscale_callback(GLFWwindow *window, float x, float y) {
		for (unsigned int i = 0; i < glfw::Window_obj::windows->length; ++i) {
			auto elem = glfw::Window_obj::windows->__get(i).StaticCast<glfw::Window>();

			if (elem->native == window) {
				for (unsigned int j = 0; j < elem->onContentScaleChange->length; ++j) {
					elem->onContentScaleChange->__get(j)(x, y);
				}
			}
		}
	}

	static void focus_callback(GLFWwindow *window, int focused) {
		for (unsigned int i = 0; i < glfw::Window_obj::windows->length; ++i) {
			auto elem = glfw::Window_obj::windows->__get(i).StaticCast<glfw::Window>();

			if (elem->native == window) {
				for (unsigned int j = 0; j < elem->onFocusChange->length; ++j) {
					elem->onFocusChange->__get(j)(focused == GLFW_TRUE);
				}
			}
		}
	}

	static void iconify_callback(GLFWwindow *window, int iconified) {
		for (unsigned int i = 0; i < glfw::Window_obj::windows->length; ++i) {
			auto elem = glfw::Window_obj::windows->__get(i).StaticCast<glfw::Window>();

			if (elem->native == window) {
				for (unsigned int j = 0; j < elem->onIconifyChange->length; ++j) {
					elem->onIconifyChange->__get(j)(iconified == GLFW_TRUE);
				}
			}
		}
	}

	static void maximize_callback(GLFWwindow *window, int maximized) {
		for (unsigned int i = 0; i < glfw::Window_obj::windows->length; ++i) {
			auto elem = glfw::Window_obj::windows->__get(i).StaticCast<glfw::Window>();

			if (elem->native == window) {
				for (unsigned int j = 0; j < elem->onMaximizeChange->length; ++j) {
					elem->onMaximizeChange->__get(j)(maximized == GLFW_TRUE);
				}
			}
		}
	}

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

	static void refresh_callback(GLFWwindow *window) {
		for (unsigned int i = 0; i < glfw::Window_obj::windows->length; ++i) {
			auto elem = glfw::Window_obj::windows->__get(i).StaticCast<glfw::Window>();

			if (elem->native == window) {
				for (unsigned int j = 0; j < elem->onRefresh->length; ++j) {
					elem->onRefresh->__get(j)();
				}
			}
		}
	}

	static void size_callback(GLFWwindow *window, int width, int height) {
		for (unsigned int i = 0; i < glfw::Window_obj::windows->length; ++i) {
			auto elem = glfw::Window_obj::windows->__get(i).StaticCast<glfw::Window>();

			if (elem->native == window) {
				for (unsigned int j = 0; j < elem->onSizeChange->length; ++j) {
					elem->onSizeChange->__get(j)(width, height);
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

	public var onClose:Array<() -> Void>;

	public var onContentScaleChange:Array<(x:Float, y:Float) -> Void>;

	public var onFocusChange:Array<(focused:Bool) -> Void>;

	public var onIconifyChange:Array<(iconified:Bool) -> Void>;

	public var onMaximizeChange:Array<(maximized:Bool) -> Void>;

	public var onPositionChange:Array<(x:Int, y:Int) -> Void>;

	public var onRefresh:Array<() -> Void>;

	public var onSizeChange:Array<(width:Int, height:Int) -> Void>;

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
		this.onClose = [];
		this.onContentScaleChange = [];
		this.onFocusChange = [];
		this.onIconifyChange = [];
		this.onMaximizeChange = [];
		this.onPositionChange = [];
		this.onRefresh = [];
		this.onSizeChange = [];
		this.parent = parent;
		@:bypassAccessor this.title = options.title;

		// glfwWindowHint(int hint, int value); // used internally by createWindow
		// glfwWindowHintString(int hint, const char * value); // used internally by createWindow
		// glfwCreateWindow(int width, int height, const char * title, GLFWmonitor * monitor, GLFWwindow * share);

		windows.push(this);

		untyped __cpp__('
			native = glfwCreateWindow(options->width, options->height, options->title, nullptr, nullptr);

			glfwSetWindowCloseCallback(native, close_callback);
			glfwSetWindowContentScaleCallback(native, contentscale_callback);
			glfwSetWindowFocusCallback(native, focus_callback);
			glfwSetWindowIconifyCallback(native, iconify_callback);
			glfwSetWindowMaximizeCallback(native, maximize_callback);
			glfwSetWindowPosCallback(native, pos_callback);
			glfwSetWindowRefreshCallback(native, refresh_callback);
			glfwSetWindowSizeCallback(native, size_callback);
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
