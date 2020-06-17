package glfw.keyboard;

/**
	State of a key.
**/
enum abstract KeyState(Int) {
	/** The key is released. **/
	var Release = 0;

	/** The key is pressed. **/
	var Press = 1;

	/** The key was held down until it repeated. **/
	var Repeat = 2;
}
