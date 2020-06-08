package glfw;

import cpp.Float32;
import cpp.NativeString;
import glfw.errors.*;

/**TODO
	GLFWAPI int glfwGetWindowAttrib(GLFWwindow* window, int attrib);
	GLFWAPI void glfwSetWindowAttrib(GLFWwindow* window, int attrib, int value);

	typedef void (* GLFWdropfun)(GLFWwindow*,int,const char*[]);
	GLFWAPI GLFWdropfun glfwSetDropCallback(GLFWwindow* window, GLFWdropfun callback);
**/
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

	public var clipboardString(get, set):String;

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

	function get_clipboardString():String {
		validate();

		return NativeString.fromPointer(untyped __cpp__('glfwGetClipboardString(native)'));
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

	function set_clipboardString(value:String):String {
		validate();

		untyped __cpp__('glfwSetClipboardString(native, value)');

		return value;
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

		// TODO
		// glfwWindowHint(int hint, int value);
		// glfwWindowHintString(int hint, const char * value);
		// monitor and share parameter of glfwCreateWindow

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

	public function setAspectRatio(numerator:Int, denominator:Int):Void {
		validate();

		untyped __cpp__('glfwSetWindowAspectRatio(native, numerator, denominator)');
	}

	public function setFullscreenMonitor(monitor:Monitor, x:Int, y:Int, width:Int, height:Int, refreshRate:Int):Void {
		validate();

		untyped __cpp__('glfwSetWindowMonitor(native, monitor->native, x, y, width, height, refreshRate)');
	}

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

	public function setPosition(x:Int, y:Int):Void {
		validate();

		untyped __cpp__('glfwSetWindowPos(native, x, y)');
	}

	public function setSize(width:Int, height:Int):Void {
		validate();

		untyped __cpp__('glfwSetWindowSize(native, width, height)');
	}

	public function setSizeLimits(minWidth:Int, minHeight:Int, maxWidth:Int, maxHeight:Int):Void {
		validate();

		untyped __cpp__('glfwSetWindowSizeLimits(native, minWidth, minHeight, maxWidth, maxHeight)');
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
