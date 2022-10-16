//
const std = @import("std");
const print = std.debug.print;
const stdin = std.io.getStdIn();

const Op = enum {
    Add,
    Mult,
    Sub,
};

//
fn getLine() !i32 {
    var buff: [10]u8 = undefined;
    const size = try stdin.read(&buff);
    const line = std.mem.trim(u8, buff[0..size], "\n\r");
    return try std.fmt.parseInt(i32, line, 10);
}

fn getInput() !i32 {
    var buff: [10]u8 = undefined;
    return try std.fmt.parseInt(i32, std.mem.trim(u8, buff[0..try stdin.read(&buff)], "\n\r"), 10);
}

fn aplyOp(comptime ops: []const Op, inp: i32) i32 {
    var acc: i32 = 0;
    for (ops) |op| {
        switch (op) {
            .Add => acc += inp,
            .Sub => acc -= inp,
            .Mult => acc *= inp,
        }
    }
    return acc;
}

pub fn main() !void {
    const user_input = getLine() catch 0;
    const op = .{ .Add, .Mult, .Sub };
    print("{} {}\n", .{ user_input, aplyOp(&op, user_input) });
}
