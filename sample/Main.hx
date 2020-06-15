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

		glfw.onMonitorChange.push((monitor, connected) -> {
			trace(monitor, monitor.name, connected);
		});

		for (gamepad in glfw.getConnectedGamepads()) {
			Sys.println('Gamepad ${gamepad.name}');
			Sys.println('\tID ${gamepad.id}');
			Sys.println('\tGUID ${gamepad.guid}');
			Sys.println('\tMapping ${gamepad.hasMapping}');
		}

		glfw.onGamepadChange.push((gamepad, connected) -> {
			if (connected) {
				trace('Gamepad ${gamepad.id} connected (${gamepad.name})');
			} else {
				trace('Gamepad ${gamepad.id} disconnected');
			}
		});

		var window = glfw.createWindow({
			title: "GLFW with Haxe",
			width: 800,
			height: 600,
		});

		window.cursor = glfw.createStandardCursor(NotAllowed);

		window.onPositionChange.push((x, y) -> trace('Moved to [$x, $y]'));

		while (!window.shouldClose) {
			glfw.pollEvents();
		}

		window.destroy();
		glfw.destroy();
	}
}
