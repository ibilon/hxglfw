package glfw;

/**
	A mouse button for `Window.getMouseButton` and `Window.onMouseButton`.
**/
enum abstract MouseButton(Int) {
	/** Left mouse button. **/
	var Left = 0;

	/** Right mouse button. **/
	var Right = 1;

	/** Middle mouse button. **/
	var Middle = 2;

	/** Mouse button 4. **/
	var Button4 = 3;

	/** Mouse button 5. **/
	var Button5 = 4;

	/** Mouse button 6. **/
	var Button6 = 5;

	/** Mouse button 7. **/
	var Button7 = 6;

	/** Mouse button 8. **/
	var Button8 = 7;
}
