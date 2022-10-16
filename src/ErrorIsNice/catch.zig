//
const print = @import("std").debug.print;
const FileError = error{FileNotFound};

fn open(comptime T: type, s: T) FileError!T {
    return if (true) s else error.FileNotFound;
}

pub fn main() !void {
    var s = "ola".*;
    s[0] = 'O';
    print("{} {s} {s} {}", .{ 11, open([]const u8, "ola") catch unreachable, s, @TypeOf(s) });
}
