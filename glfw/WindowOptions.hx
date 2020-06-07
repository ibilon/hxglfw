package glfw;

@:structInit
class WindowOptions {
	public var title:String;
	public var width:Int;
	public var height:Int;
	@:optional public var monitor:Null<Monitor>;
	@:optional public var share:Null<Window>;
}
