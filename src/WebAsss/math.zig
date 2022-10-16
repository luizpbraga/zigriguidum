export fn add(a: i32, b: i32) i32 {
    return a + b;
}
export fn sqr(n: i32) i32 {
    return n * n;
}

export fn fib(n: i32) i32 {
    return if (n <= 1) n else fib(n - 1) + fib(n - 2);
}

export fn rand() i32 {
    var rand_init = std.rand.DefaultPrng.init(42);
    var r = rand_init.random().int(i32);
    return r;
}

const std = @import("std");

pub fn main() void {}
