//
const std = @import("std");
const print = std.debug.print;
//
pub fn main() !void {
    var i: usize = 0;
    while (i < 10) : (i += 1) {
        var rand_int = std.rand.DefaultPrng.init(i);
        const rn = rand_int.random().float(f32);
        print("{d}\n", .{rn});
    }
}
