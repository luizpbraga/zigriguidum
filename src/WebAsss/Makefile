
all: wasm 
	node ./index.js

wasm:
	zig build-lib math.zig -target wasm32-freestanding -dynamic

