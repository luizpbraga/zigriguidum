//
const std = @import("std");
const print = std.debug.print;
//

// Jesus Amado
const foo = struct {
    fn func(f: i32, g: i32) i32 {
        return f + g;
    }
}.func;

pub fn main() !void {
    print("{d}", .{foo(1, 2)});
}
