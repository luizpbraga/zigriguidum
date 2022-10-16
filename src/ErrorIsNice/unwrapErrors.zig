//
const std = @import("std");
const print = std.debug.print;
//
const Err = error{ Err1, Err2 };

fn foo(i: u8) Err!u8 {
    return if (i < 5) 5 else error.Err1;
}

pub fn main() !void {
    const w1 = try foo(1);
    const w2 = foo(1) catch |e| return e;
    print("{d} {d}\n", .{ w1, w2 });

    const w3 = foo(1) catch |e| {
        print("We have the error {any}\n", .{e});
        return;
    };
    const w4 = foo(10) catch |e| blk: {
        print("We have the error {any}\n", .{e});
        break :blk 0;
    };
    print("w3={d} w4={d}\n", .{ w3, w4 });

    var w5: error{NotFive}!u8 = 5; // error.NotFive;

    if (w5) |val| {
        if (val != 5) unreachable;
        print("w5 = {d}\n", .{val});
    } else |err| {
        _ = err catch {};
        unreachable;
        //return err; // valid
    }

    var w6: ?i32 = null orelse 1;
    try std.testing.expect(w6.? == 1);
}
