package glfw.errors;

@:allow(glfw)
class Exception {
	public final message:String;

	function new(message:String) {
		this.message = message;
	}

	function toString():String {
		return message;
	}
}
