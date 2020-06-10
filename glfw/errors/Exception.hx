package glfw.errors;

/**
	Base exception class of GLFW.

	Thrown when no specific exception from `glfw.errors` matches.
**/
@:allow(glfw)
class Exception {
	/** A UTF-8 encoded string describing the error. **/
	public final message:String;

	function new(message:String) {
		this.message = message;
	}

	function toString():String {
		return message;
	}
}
