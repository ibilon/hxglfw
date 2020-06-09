package glfw;

import cpp.Star;
import glfw.errors.*;
import haxe.ds.ReadOnlyArray;

@:allow(glfw)
@:build(glfw.GLFWBuilder.build())
@:cppNamespaceCode('
	static GLFW_obj *singleton = nullptr;

	static void error_callback(int code, const char *message) {
		glfw::GLFW_obj::errorCallback(code, message);
	}

	static void monitor_callback(GLFWmonitor *monitor, int status) {
		singleton->updateMonitor(monitor, status == GLFW_CONNECTED);
	}
')
@:headerInclude('./glfw.h')
class GLFW {
	static function errorCallback(code:Int, message:String):Void {
		// TODO switch on code to dispatch better errors
		throw new Exception(message);
	}

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

	public var onMonitorChange:Array<(monitor:Monitor, connected:Bool) -> Void>;

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
			throw new AlreadyInitializedException();
		}

		untyped __cpp__('glfwSetErrorCallback(error_callback)');

		if (untyped __cpp__('glfwInit()') == 0) {
			// TODO error callback might make this not needed
			throw new InitializationException();
		}

		untyped __cpp__('singleton = this');

		this._monitors = [];
		this.onMonitorChange = [];

		untyped __cpp__('
			int count;
			GLFWmonitor **raw_monitors = glfwGetMonitors(&count);

			for (unsigned int i = 0; i < count; ++i) {
				glfw::Monitor monitor = glfw::Monitor_obj::__alloc(HX_CTX, this);
				monitor->native = raw_monitors[i];
				_monitors->push(monitor);
			}

			glfwSetMonitorCallback(monitor_callback);
		');

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

	public function pollEvents():Void {
		validate();

		untyped __cpp__('glfwPollEvents();');
	}

	function updateMonitor(raw:Star<cpp.Void>, connected:Bool):Void {
		var monitor:Null<Monitor> = null;

		for (m in _monitors) {
			if (untyped __cpp__('m->native == (GLFWmonitor*)raw')) {
				monitor = m;
				break;
			}
		}

		if (monitor == null) {
			monitor = new Monitor(this);
			untyped __cpp__('monitor->native = (GLFWmonitor*)raw');
		}

		if (connected) {
			_monitors.push(monitor);
		} else {
			_monitors.remove(monitor);
		}

		for (fn in onMonitorChange) {
			fn(monitor, connected);
		}

		if (!connected) {
			monitor.valid = false;
		}
	}

	function validate() {
		if (untyped __cpp__('singleton != this')) {
			throw new UseAfterDestroyException();
		}
	}
}
