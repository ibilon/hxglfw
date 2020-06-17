package glfw.keyboard;

/**
	A key.

	If a valid `GLFW` instance exists you can convert a key to its scancode value with `key.scancode()` and get its name with `key.name()`,
	otherwise using these two functions will throw a `NotInitializedException` or `UseAfterDestroyException` exception.
**/
@:using(glfw.keyboard.Key.KeyUsings)
enum abstract Key(Int) {
	var Unknown = -1;
	var Space = 32;
	var Apostrophe = 39;
	var Comma = 44;
	var Minus = 45;
	var Period = 46;
	var Slash = 47;
	var Digit0 = 48;
	var Digit1 = 49;
	var Digit2 = 50;
	var Digit3 = 51;
	var Digit4 = 52;
	var Digit5 = 53;
	var Digit6 = 54;
	var Digit7 = 55;
	var Digit8 = 56;
	var Digit9 = 57;
	var Semicolon = 59;
	var Equal = 61;
	var A = 65;
	var B = 66;
	var C = 67;
	var D = 68;
	var E = 69;
	var F = 70;
	var G = 71;
	var H = 72;
	var I = 73;
	var J = 74;
	var K = 75;
	var L = 76;
	var M = 77;
	var N = 78;
	var O = 79;
	var P = 80;
	var Q = 81;
	var R = 82;
	var S = 83;
	var T = 84;
	var U = 85;
	var V = 86;
	var W = 87;
	var X = 88;
	var Y = 89;
	var Z = 90;
	var LeftBracket = 91;
	var Backslash = 92;
	var RightBracket = 93;
	var GraveAccent = 96;
	var World1 = 161;
	var World2 = 162;
	var Escape = 256;
	var Enter = 257;
	var Tab = 258;
	var Backspace = 259;
	var Insert = 260;
	var Delete = 261;
	var Right = 262;
	var Left = 263;
	var Down = 264;
	var Up = 265;
	var PageUp = 266;
	var PageDown = 267;
	var Home = 268;
	var End = 269;
	var CapsLock = 280;
	var ScrollLock = 281;
	var NumLock = 282;
	var PrintScreen = 283;
	var Pause = 284;
	var F1 = 290;
	var F2 = 291;
	var F3 = 292;
	var F4 = 293;
	var F5 = 294;
	var F6 = 295;
	var F7 = 296;
	var F8 = 297;
	var F9 = 298;
	var F10 = 299;
	var F11 = 300;
	var F12 = 301;
	var F13 = 302;
	var F14 = 303;
	var F15 = 304;
	var F16 = 305;
	var F17 = 306;
	var F18 = 307;
	var F19 = 308;
	var F20 = 309;
	var F21 = 310;
	var F22 = 311;
	var F23 = 312;
	var F24 = 313;
	var F25 = 314;
	var Numpad0 = 320;
	var Numpad1 = 321;
	var Numpad2 = 322;
	var Numpad3 = 323;
	var Numpad4 = 324;
	var Numpad5 = 325;
	var Numpad6 = 326;
	var Numpad7 = 327;
	var Numpad8 = 328;
	var Numpad9 = 329;
	var NumpadDecimal = 330;
	var NumpadDivide = 331;
	var NumpadMultiply = 332;
	var NumpadSubtract = 333;
	var NumpadAdd = 334;
	var NumpadEnter = 335;
	var NumpadEqual = 336;
	var LeftShift = 340;
	var LeftControl = 341;
	var LeftAlt = 342;
	var LeftSuper = 343;
	var RightShift = 344;
	var RightControl = 345;
	var RightAlt = 346;
	var RightSuper = 347;
	var Menu = 348;
}

@:dox(hide)
@:noCompletion
class KeyUsings {
	/**
		Onlys works for printable keys.

		**Thread safety:** This function must only be called from the main thread.

		@throws NotInitializedException
		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public static function name(key:Key):String {
		GLFW.validate();

		return untyped __cpp__('glfwGetKeyName(key, 0)');
	}

	/**
		**Thread safety:** This function may be called from any thread.

		@throws NotInitializedException
		@throws PlatformErrorException
		@throws UseAfterDestroyException
	**/
	public static function scancode(key:Key):Scancode {
		GLFW.validate();

		return untyped __cpp__('glfwGetKeyScancode(key)');
	}
}
