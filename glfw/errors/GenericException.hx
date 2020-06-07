package glfw.errors;

@:allow(glfw)
class GenericException {
	public final code:Int;
	public final message:String;

	function new(code:Int, message:String) {
		this.code = code;
		this.message = message;
	}
}
