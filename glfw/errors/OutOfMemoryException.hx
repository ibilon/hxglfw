package glfw.errors;

/**
	A memory allocation failed.
**/
@:allow(glfw)
class OutOfMemoryException extends Exception {
	function new(message:String) {
		super(message);
	}
}
