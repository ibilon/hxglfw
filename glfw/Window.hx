package glfw;

import cpp.Float32;
import glfw.errors.UseAfterDestroyException;

/* TODO
	public var aspectRatio(default, set):{numerator:Int, denominator:Int}; // TODO default value + that won't work if seting only one
	GLFWAPI void glfwSetWindowAspectRatio(GLFWwindow* window, int numer, int denom);

	public var icon(default, set):Image; // TODO why multiple?
	GLFWAPI void glfwSetWindowIcon(GLFWwindow* window, int count, const GLFWimage* images);

	// TODO set same as aspectratio
	public var position(get, set):{x:Int, y:Int};
	GLFWAPI void glfwGetWindowPos(GLFWwindow* window, int* xpos, int* ypos);
	GLFWAPI void glfwSetWindowPos(GLFWwindow* window, int xpos, int ypos);

	// TODO set same as aspect ratio
	public var size(get, set):{width:Int, height:Int};
	GLFWAPI void glfwGetWindowSize(GLFWwindow* window, int* width, int* height);
	GLFWAPI void glfwSetWindowSize(GLFWwindow* window, int width, int height);

	public var sizeLimits(default, set):{minWidth:Int, minHeight:Int, maxWidth:Int, maxHeight:Int}; // TODO same as aspectRatio
	GLFWAPI void glfwSetWindowSizeLimits(GLFWwindow* window, int minwidth, int minheight, int maxwidth, int maxheight);

 */
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

	public var contentScale(get, never):{x:Float, y:Float};

	var destroyed:Bool;

	public var frameSize(get, never):{
		left:Int,
		top:Int,
		right:Int,
		bottom:Int
	};

	public var onClose:Array<() -> Void>;

	public var onContentScaleChange:Array<(x:Float, y:Float) -> Void>;

	public var onFocusChange:Array<(focused:Bool) -> Void>;

	public var onIconifyChange:Array<(iconified:Bool) -> Void>;

	public var onMaximizeChange:Array<(maximized:Bool) -> Void>;

	public var onPositionChange:Array<(x:Int, y:Int) -> Void>;

	public var onRefresh:Array<() -> Void>;

	public var onSizeChange:Array<(width:Int, height:Int) -> Void>;

	public var opacity(get, set):Float;

	var parent:GLFW;

	public var shouldClose(get, set):Bool;

	public var title(default, set):String;

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

	function get_opacity():Float {
		validate();

		return untyped __cpp__('glfwGetWindowOpacity(native)');
	}

	function set_opacity(value:Float):Float {
		validate();

		untyped __cpp__('glfwSetWindowOpacity(native, (float)value)');

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

	public function focus():Void {
		validate();

		untyped __cpp__('glfwFocusWindow(native)');
	}

	public function hide():Void {
		validate();

		untyped __cpp__('glfwHideWindow(native)');
	}

	public function iconify():Void {
		validate();

		untyped __cpp__('glfwIconifyWindow(native)');
	}

	public function maximize():Void {
		validate();

		untyped __cpp__('glfwMaximizeWindow(native)');
	}

	public function requestAttention():Void {
		validate();

		untyped __cpp__('glfwRequestWindowAttention(native)');
	}

	public function restore():Void {
		validate();

		untyped __cpp__('glfwRestoreWindow(native)');
	}

	public function show():Void {
		validate();

		untyped __cpp__('glfwShowWindow(native)');
	}

	function validate() {
		if (destroyed) {
			throw new UseAfterDestroyException();
		}

		parent.validate();
	}
}
