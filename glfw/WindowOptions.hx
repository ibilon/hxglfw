package glfw;

@:structInit
class WindowOptions {
	public var title:String;
	public var width:Int;
	public var height:Int;
	@:optional public var monitor:Null<Monitor>;
	@:optional public var share:Null<Window>;
	@:optional public var openCentered:Null<Bool>;
	@:optional public var autoIconify:Null<Bool>;
	@:optional public var decorated:Null<Bool>;
	@:optional public var floating:Null<Bool>;
	@:optional public var focusOnShow:Null<Bool>;
	@:optional public var resizable:Null<Bool>;
}
