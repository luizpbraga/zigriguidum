//
const std = @import("std");
const c = @cImport(@cInclude("/home/luizpbraga/carray.h"));
//
pub fn main() !void {
    //
    var v: [6]c_int = .{ 1, 2, 3, 4, 5, 6 };
    // showarray(int* a, int len )
    c.showarray(&v, v.len);
}
