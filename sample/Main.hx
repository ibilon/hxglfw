package sample;

import glfw.*;

class Main {
	static function main() {
		var glfw = new GLFW();

		for (monitor in glfw.monitors) {
			Sys.println('Monitor ${monitor.name}');
			Sys.println('\tPosition: ${monitor.position}');
			Sys.println('\tPhysical size: ${monitor.physicalSize}');
			Sys.println('\tContent scale: ${monitor.contentScale}');
			Sys.println('\tWorkarea: ${monitor.workarea}');
			Sys.println('\tVideo modes:');
			for (mode in monitor.videoModes) {
				Sys.println('\t\t${mode}');
			}
			Sys.println('\tCurrent video mode: ${monitor.currentVideoMode}');
		}

		var window = glfw.createWindow({
			title: "GLFW with Haxe",
			width: 800,
			height: 600,
		});

		while (!window.shouldClose) {
			glfw.pollEvents();
			// TODO close on esc
		}

		window.destroy();
		glfw.destroy();
	}
}
