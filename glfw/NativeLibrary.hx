package glfw;

#if macro
import haxe.io.Path;
import haxe.macro.Context;
import haxe.macro.Expr;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
#end

@:noCompletion
class NativeLibrary {
	#if macro
	macro static function build():Expr {
		switch (Context.getType("glfw.NativeLibrary")) {
			case TInst(_.get() => t, _):
				final cwd = Sys.getCwd();

				// Library root path.
				final path = FileSystem.absolutePath(Path.join([Path.directory(Context.getPosInfos(t.pos).file), ".."]));

				// glfw-native current commit.
				Sys.setCwd(Path.join([path, "glfw-native"]));

				var process = new Process("git", ["rev-parse", "HEAD"]);

				if (process.exitCode() != 0) {
					Sys.stderr().write(process.stderr.readAll());
					process.close();
					Context.fatalError("Couldn't get the version of glfw", Context.currentPos());
				}

				final version = process.stdout.readLine();

				process.close();

				// Check current build.
				final hashPath = Path.join([path, "build", "hash.txt"]);

				if (FileSystem.exists(hashPath)) {
					final currentBuild = File.getContent(hashPath).split("\n")[0];

					if (currentBuild == version) {
						// Up-to-date, nothing to do.
						Sys.setCwd(cwd);
						return macro null;
					}
				}

				// Either doesn't exists or is not up-to-date, build.
				Sys.println("(Re)Building the glfw library ... (this only happens when the version changes)");

				final build = Path.join([path, "glfw-native", "build"]);
				FileSystem.createDirectory(build);
				Sys.setCwd(build);

				final process = new Process("cmake", [
					"..",
					"-DGLFW_BUILD_EXAMPLES=OFF",
					"-DGLFW_BUILD_TESTS=OFF",
					"-DGLFW_BUILD_DOCS=OFF",
					"-DGLFW_INSTALL=OFF"
				]);

				if (process.exitCode() != 0) {
					Sys.stderr().write(process.stderr.readAll());
					process.close();
					Context.fatalError("Couldn't build glfw", Context.currentPos());
				}

				process.close();

				final process = new Process("make", []);

				if (process.exitCode() != 0) {
					Sys.stderr().write(process.stderr.readAll());
					process.close();
					Context.fatalError("Couldn't build glfw", Context.currentPos());
				}

				process.close();

				Sys.setCwd(cwd);

				// Copy the generated library to the build folder and update the hash.
				FileSystem.createDirectory(Path.join([path, "build"]));
				// TODO windows/mac might use a different library name
				File.copy(Path.join([path, "glfw-native", "build", "src", "libglfw3.a"]), Path.join([path, "build", "libglfw3.a"]));
				File.saveContent(Path.join([path, "build", "hash.txt"]), version);

				// Clean up build
				Sys.command("rm", ["-r", build]); // TODO macos/windows

			default:
				throw "can't find the glfw.NativeLibrary type";
		}

		return macro null;
	}
	#end
}
