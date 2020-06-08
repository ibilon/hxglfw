package glfw;

import cpp.Float32;
import cpp.NativeString;
import glfw.errors.MonitorDisconnectedException;
import haxe.ds.ReadOnlyArray;

@:allow(glfw)
@:headerInclude('./glfw.h')
@:headerClassCode('
    GLFWmonitor *native;
')
class Monitor {
	var connected:Bool;

	var parent:GLFW;

	public var contentScale(get, never):{x:Float, y:Float};

	public var currentVideoMode(get, never):VideoMode;

	public var name(get, never):String;

	public var physicalSize(get, never):{width:Int, height:Int};

	public var position(get, never):{x:Int, y:Int};

	public var videoModes(get, never):ReadOnlyArray<VideoMode>;

	public var workarea(get, never):{
		x:Int,
		y:Int,
		width:Int,
		height:Int
	};

	function get_contentScale():{x:Float, y:Float} {
		validate();

		var x:Float32 = 0.0;
		var y:Float32 = 0.0;

		untyped __cpp__('glfwGetMonitorContentScale(native, &x, &y)');

		return {
			x: x,
			y: y,
		};
	}

	function get_currentVideoMode():VideoMode {
		validate();

		untyped __cpp__('
			const GLFWvidmode *mode = glfwGetVideoMode(native);
			return glfw::VideoMode_obj::__alloc(HX_CTX, mode->width, mode->height, mode->redBits, mode->greenBits, mode->blueBits, mode->refreshRate);
		');

		throw "unreachable";
	}

	function get_name():String {
		validate();

		return NativeString.fromPointer(untyped __cpp__('glfwGetMonitorName(native)'));
	}

	function get_physicalSize():{width:Int, height:Int} {
		validate();

		var width = 0;
		var height = 0;

		untyped __cpp__('glfwGetMonitorPhysicalSize(native, &width, &height)');

		return {
			width: width,
			height: height,
		};
	}

	function get_position():{x:Int, y:Int} {
		validate();

		var x = 0;
		var y = 0;

		untyped __cpp__('glfwGetMonitorPos(native, &x, &y)');

		return {
			x: x,
			y: y,
		};
	}

	function get_videoModes():ReadOnlyArray<VideoMode> {
		validate();

		var modes = [];

		untyped __cpp__('
			int count;
			const GLFWvidmode *native_modes = glfwGetVideoModes(native, &count);

			for (unsigned int i = 0; i < count; ++i) {
				const GLFWvidmode *mode = native_modes + i;
				modes->push(glfw::VideoMode_obj::__alloc(HX_CTX, mode->width, mode->height, mode->redBits, mode->greenBits, mode->blueBits, mode->refreshRate));
			}
		');

		return modes;
	}

	function get_workarea():{
		x:Int,
		y:Int,
		width:Int,
		height:Int
	} {
		validate();

		var x = 0;
		var y = 0;
		var width = 0;
		var height = 0;

		untyped __cpp__('glfwGetMonitorWorkarea(native, &x, &y, &width, &height)');

		return {
			x: x,
			y: y,
			width: width,
			height: height,
		};
	}

	function new(parent:GLFW) {
		this.parent = parent;
		this.connected = true;
	}

	inline function validate() {
		if (!connected) {
			throw new MonitorDisconnectedException();
		}

		parent.validate();
	}
}
