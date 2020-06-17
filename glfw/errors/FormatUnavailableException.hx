package glfw.errors;

/**
	The requested format is not supported or available.

	Throw during window creation if the requested pixel format is not supported, and when querying the clipboard if the contents of the clipboard could not be converted to the requested format.
**/
@:allow(glfw)
class FormatUnavailableException extends Exception {
	function new(message:String) {
		super(message);
	}
}
