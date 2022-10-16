//
const std = @import("std");
const print = std.debug.print;
//

fn List(comptime T: type) type {
    return struct {
        name: []const u8,
        val: T,
    };
}

pub fn main() !void {
    const s = List(u8){
        .name = "Lu",
        .val = 1,
    };
    const info = std.fmt.comptimePrint("{}", .{@typeInfo(List(u8))});

    inline for (@typeInfo(@TypeOf(s)).Struct.fields) |val| {
        _ = val;
    }

    std.debug.print("{s}", .{info});
}
