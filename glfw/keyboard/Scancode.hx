package glfw.keyboard;

/**
	Platform-specific scancode of a key.

	The scancode of a key is specific to that platform or sometimes even to that machine, but consistent over time, so scancodes are safe to save to disk.

	Scancodes are intended to allow users to bind keys that don't have a GLFW `Key` entry.
**/
abstract Scancode(Int) {}
