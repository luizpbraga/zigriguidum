
const fs = require('fs');

const source = fs.readFileSync('math.wasm');

const typedArray = new Uint8Array(source);

WebAssembly.instantiate(typedArray, {}).then(result => {
  console.log(result.instance.exports.add(5,5));
  console.log(result.instance.exports.sqr(5));
  console.log(result.instance.exports.fib(5));
  console.log(result.instance.exports.rand());
});
