//
const std = @import("std");
const print = std.debug.print;
//
fn foo(s: []u8) void {
    _ = s;
}

pub fn main() !void {
    const g: u8 = 44; // using "const g: SomePossipleNonComptimeIntType = 44;" is ok
    var gp = &g;
    _ = gp; //error: variable of type '*const comptime_int' must be const or comptime

    var s = "this compiles".*;
    var s1 = "this compiles";
    var p = s1.*;

    foo(&s);
    foo(&p);
    //foo(&(&(s1.*)));

    print("s: {}, p: {}, s1: {}\n&s: {}, &p: {}, &s1: {}\ns1.*: {}, &(s1.*): {}", .{ @TypeOf(s), @TypeOf(p), @TypeOf(s1), @TypeOf(&s), @TypeOf(&p), @TypeOf(&s1), @TypeOf(s1.*), @TypeOf(&(s1.*)) });
}
