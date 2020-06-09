package glfw;

import haxe.io.Path;
import haxe.macro.Context;
import haxe.macro.Expr;
import sys.FileSystem;

@:dox(hide)
@:noCompletion
class GLFWBuilder {
	public static macro function build():Array<Field> {
		var path = switch (Context.getType("glfw.GLFWBuilder")) {
			case TInst(_.get() => t, _):
				FileSystem.absolutePath(Path.join([Path.directory(Context.getPosInfos(t.pos).file), "..", "build"]));

			default:
				throw "can't find the glfw.GLFWBuilder type";
		}

		Context.getLocalClass().get().meta.add(":buildXml", [
			macro '
		<files id="haxe">
			<compilerflag value="-DGLFW_EXPOSE_NATIVE_WIN32" if="windows" />
			<compilerflag value="-DGLFW_EXPOSE_NATIVE_COCOA" if="mac" />
			<compilerflag value="-DGLFW_EXPOSE_NATIVE_X11" if="linux" />
		</files>
		<target id="haxe">
			<flag value="-L$path" />
			<lib name="-lglfw3" />
		</target>
		'
		], Context.currentPos());

		return Context.getBuildFields();
	}
}
