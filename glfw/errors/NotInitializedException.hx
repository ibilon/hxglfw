package glfw.errors;

/**
	GLFW has not been initialized.

	Thrown when a GLFW function was called that must not be called unless the library is created.
**/
@:allow(glfw)
class NotInitializedException extends Exception {
	function new(message:String) {
		super(message);
	}
}
