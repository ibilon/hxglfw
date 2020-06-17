package glfw.keyboard;

/**
	Modifier keys state.
**/
abstract Modifiers(Int) {
	/** If true one or more Alt keys were held down. **/
	public var alts(get, never):Bool;

	/** If true the Caps Lock key is enabled. **/
	public var capsLock(get, never):Bool;

	/** If true one or more Control keys were held down. **/
	public var controls(get, never):Bool;

	/** If true the Num Lock key is enabled. **/
	public var numLock(get, never):Bool;

	/** If true one or more Shift keys were held down. **/
	public var shifts(get, never):Bool;

	/** If true one or more Super keys were held down. **/
	public var supers(get, never):Bool;

	function get_alts():Bool {
		return (this & 0x0004) > 0;
	}

	function get_capsLock():Bool {
		return (this & 0x0010) > 0;
	}

	function get_controls():Bool {
		return (this & 0x0002) > 0;
	}

	function get_numLock():Bool {
		return (this & 0x0020) > 0;
	}

	function get_shifts():Bool {
		return (this & 0x0001) > 0;
	}

	function get_supers():Bool {
		return (this & 0x0008) > 0;
	}
}
