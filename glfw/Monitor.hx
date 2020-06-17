package glfw;

import cpp.Float32;
import cpp.NativeString;
import glfw.errors.MonitorDisconnectedException;
import haxe.ds.ReadOnlyArray;

/**
	A monitor.

	Obtained from `GLFW.monitors` or `GLFW.primaryMonitor`.

	Once the monitor gets disconnected the object isn't valid anymore and its usage will throw a `MonitorDisconnectedException` exception.
	You can get notified of the disconnection with the `Monitor.onDisconnect` or `GLFW.onMonitorChange` callbacks.
	The object is valid until the end of the callback.

	Connecting the monitor again will not reuse the old `Monitor` object.

	If the `GLFW` instance associated with this monitor is destroyed then using it will throw a `UseAfterDestroyException` exception.
**/
@:allow(glfw)
@:headerInclude('./glfw.h')
@:headerClassCode('
    GLFWmonitor *native;
')
class Monitor {
	/**
		The content scale of this monitor.

		The content scale is the ratio between the current DPI and the platform's default DPI.
		This is especially important for text and any UI elements.
		If the pixel dimensions of your UI scaled by this look appropriate on your machine then it should appear at a reasonable size on other machines regardless of their DPI and scaling settings.
		This relies on the system DPI and scaling settings being somewhat correct.

		The content scale may depend on both the monitor resolution and pixel density and on user settings. It may be very different from the raw DPI calculated from the physical size and current resolution.

		**Thread safety:** This function must only be called from the main thread.

		@throws MonitorDisconnectedException
		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var contentScale(get, never):{x:Float, y:Float};

	/**
		The current mode of this monitor.

		If you have created a fullscreen window for that monitor, the return value will depend on whether that window is iconified.

		**Thread safety:** This function must only be called from the main thread.

		@throws MonitorDisconnectedException
		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var currentVideoMode(get, never):VideoMode;

	/**
		The name of this monitor.

		This is a human-readable name, encoded as UTF-8, of the specified monitor.
		The name typically reflects the make and model of the  monitor and is not guaranteed to be unique among the connected monitors.

		**Thread safety:** This function must only be called from the main thread.

		@throws MonitorDisconnectedException
		@throws UseAfterDestroyException
	**/
	public var name(get, never):String;

	/**
		The callbacks to be called when the monitor is disconnected from the system.

		The object is valid until the callback returns,
		using it afterwards will throw a `MonitorDisconnectedException` exception.

		Connecting the monitor again will not reuse the old `Monitor` object.

		To add a callback push a function to this array.
	**/
	public var onDisconnect:Array<() -> Void>;

	/**
		The physical size of the monitor.

		This is the size, in millimetres, of the display area of the monitor.

		Some systems do not provide accurate monitor size information, either because the monitor [EDID](https://en.wikipedia.org/wiki/Extended_display_identification_data) data is incorrect or because the driver does not report it accurately.

		**Thread safety:** This function must only be called from the main thread.

		@throws MonitorDisconnectedException
		@throws UseAfterDestroyException
	**/
	public var physicalSize(get, never):{width:Int, height:Int};

	/**
		The position of the monitor's viewport on the virtual screen.

		This is the position, in screen coordinates, of the upper-left corner of the monitor.

		**Thread safety:** This function must only be called from the main thread.

		@throws MonitorDisconnectedException
		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var position(get, never):{x:Int, y:Int};

	/**
		The available video modes of the monitor.

		This is an array of all video modes supported by the monitor.
		The returned array is sorted in ascending order, first by color bit depth (the sum of all channel depths) and then by resolution area (the product of width and height).

		**Thread safety:** This function must only be called from the main thread.

		@throws MonitorDisconnectedException
		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public var videoModes(get, never):ReadOnlyArray<VideoMode>;

	/**
		The work area of the monitor.

		This is the position, in screen coordinates, of the upper-left corner of the work area of the specified monitor along with the work area size in screen coordinates. The work area is defined as the area of the monitor not occluded by the operating system task bar where present. If no task bar exists then the work area is the monitor resolution in screen coordinates.

		**Thread safety:** This function must only be called from the main thread.

		@throws MonitorDisconnectedException
		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
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

	function new() {
		this.onDisconnect = [];
	}

	/**
		@throws MonitorDisconnectedException
		@throws UseAfterDestroyException
	**/
	inline function validate() {
		if (untyped __cpp__('native == nullptr')) {
			throw new MonitorDisconnectedException(this);
		}

		GLFW.validate();
	}
}
