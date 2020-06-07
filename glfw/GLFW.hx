package glfw;

import glfw.errors.*;
import haxe.ds.ReadOnlyArray;

// TODO expose native for windows, linux, mac
@:allow(glfw)
@:buildXml('
<target id="haxe">
	<flag value="-L../../build/" />
	<lib name="-lglfw3" />
</target>
')
@:cppNamespaceCode('
	static GLFW_obj *singleton = nullptr;
')
@:headerInclude('./glfw.h')
class GLFW {
	public static var version(get, never):{major:Int, minor:Int, patch:Int};

	static function get_version():{major:Int, minor:Int, patch:Int} {
		var major = 0;
		var minor = 0;
		var patch = 0;

		untyped __cpp__('glfwGetVersion(&major, &minor, &patch)');

		return {
			major: major,
			minor: minor,
			patch: patch,
		};
	}

	var _monitors:Array<Monitor>;

	public var monitors(get, never):ReadOnlyArray<Monitor>;

	public var primaryMonitor(get, never):Monitor;

	inline function get_monitors():ReadOnlyArray<Monitor> {
		validate();

		return _monitors;
	}

	inline function get_primaryMonitor():Monitor {
		validate();

		if (_monitors.length == 0) {
			throw new NoMonitorException();
		}

		return _monitors[0];
	}

	public function new() {
		if (untyped __cpp__('singleton != nullptr')) {
			throw new AlreadyInitException();
		}

		// TODO: Check if can be use internally to throw haxe error.
		// glfwSetErrorCallback(GLFWerrorfun callback);

		if (untyped __cpp__('glfwInit()') == 0) {
			throw new InitException();
		}

		untyped __cpp__('singleton = this');

		_monitors = [];
		inline onMonitorChange();

		// TODO call onMonitorChange + allow register of callbacks
		// glfwSetMonitorCallback();
	}

	public function createWindow(options:WindowOptions):Window {
		validate();

		return new Window(this, options);
	}

	public function destroy():Void {
		validate();

		untyped __cpp__('
			glfwTerminate();
			singleton = nullptr;
		');
	}

	function onMonitorChange() {
		// TODO Keep monitors that didn't change.
		for (monitor in _monitors) {
			monitor.connected = false;
		}

		_monitors = [];

		untyped __cpp__('
			int count;
			GLFWmonitor **raw_monitors = glfwGetMonitors(&count);

			for (unsigned int i = 0; i < count; ++i) {
				glfw::Monitor monitor = glfw::Monitor_obj::__alloc(HX_CTX, this);
				monitor->native = raw_monitors[i];
				_monitors->push(monitor);
			}
		');

	}

	public function pollEvents():Void {
		validate();

		untyped __cpp__('glfwPollEvents();');
	}

	function validate() {
		if (untyped __cpp__('singleton != this')) {
			throw new UseAfterDestroyException();
		}
	}
}
