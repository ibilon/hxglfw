# (WIP) hxglfw

![Build Status](https://github.com/ibilon/hxglfw/workflows/Main/badge.svg)

API Documentation: <https://ibilon.github.io/hxglfw/>

hxglfw is a work in progress haxe/hxcpp wrapper around glfw, this is not the c api.

Currently only tested on linux with X11.

Plans:

* Add mouse/keyboard/gamepad support

## Building

hxglfw requires building glfw, see <https://www.glfw.org/docs/latest/compile.html#compile_deps> for the required dependencies.

## Usage

Make sure to clone this repository with `--recursive`, or download the submodule with `git submodule update --init`.

A small example is available in `sample/`, compile it with `haxe sample.hxml` and run it with `./sample/build/Main-debug`.

## License

This library is [zlib licensed](https://github.com/ibilon/hxglfw/blob/LICENSE.md), the statically linked glfw is [zlib licensed](https://github.com/glfw/glfw/blob/master/LICENSE.md) including its documentation which is reused for this library.
