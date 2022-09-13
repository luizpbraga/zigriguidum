// "https://zig.news/toxi/typepointer-cheatsheet-3ne2" {
const Cheatsheet = struct {
    /// single u8 value
    a: u8,
    /// single optional u8 value
    b: ?u8,
    /// array of 2 u8 values
    c: [2]u8,
    /// zero-terminated array of 2 u8 values
    d: [2:0]u8,
    /// slice of u8 values
    e: []u8,
    /// slice of optional u8 values
    f: []?u8,
    /// optional slice of u8 values
    g: ?[]u8,
    /// pointer to u8 value
    h: *u8,
    /// pointer to optional u8 value
    i: *?u8,
    /// optional pointer to u8 value
    j: ?*u8,
    /// pointer to immutable u8 value
    k: *const u8,
    /// pointer to immutable optional u8 value
    l: *const ?u8,
    /// optional pointer to immutable u8 value
    m: ?*const u8,
    /// pointer to multiple u8 values
    n: [*]u8,
    /// pointer to multiple zero-terminated u8 values
    o: [*:0]u8,
    /// array of 2 u8 pointers
    p: [2]*u8,
    /// pointer to array of 2 u8 values
    q: *[2]u8,
    /// pointer to zero-terminated array of 2 u8 values
    r: *[2:0]u8,
    /// pointer to immutable array of 2 u8 values
    s: *const [2]u8,
    /// pointer to slice of immutable u8 values
    t: *[]const u8,
    /// slice of pointers to u8 values
    u: []*u8,
    /// slice of pointers to immutable u8 values
    v: []*const u8,
    /// pointer to slice of pointers to immutable optional u8 values
    w: *[]*const ?u8,
};
//
const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;
//

// slice of *VARriable* u8
fn letmeseeit(v: []u8) void {
    for (v) |val| print("{d} ", .{val});
}

fn makeit5(v: []u8) void {
    for (v) |*val| val.* = 5;
}

fn constLetmeseeit(v: []const u8) void {
    for (v) |val| print("{d} ", .{val});
}

test "pointers\n" {
    var v = [_]u8{ 1, 2, 3, 4 };
    const const_v = [_]u8{ 1, 2, 3, 4 };

    // non-const
    letmeseeit(v[0..]);
    letmeseeit(&v);
    makeit5(&v);
    letmeseeit(v[0..]);

    // const
    // *const []u8 -> []const u8
    constLetmeseeit(&const_v);
    // const [4]u8 -> const []u8
    constLetmeseeit(const_v[0..]);
}

test "strings are pointers\n" {
    const str = "ola!";
    try expect(@TypeOf(str) == *const [4:0]u8);
    //const str2 = [4:0]u8{ 97, 98, 99, 100 };
    //try expect(str2 != "abcd");
}

test "vec of strings\n" {
    // []const u8 ...
    const words = [4][]const u8{ "Olá", ", ", "Mãe", "!" };
    for (words) |word| {
        print("{s}", .{word});
    }
    // *const [4:0]u8 :: A const pointer to an zero-terminated array of u8 with 4 dim;
    var t = [2]*const [4:0]u8{ "Ola ", "mae!" };
    _ = t;
    // []const u8 :: A slice of const u8
    var t2 = [4][]const u8{ "ola", ", ", "mae", "!" };
    _ = t2;
}

test "Pointer to array\n" {
    var t = [2]u8{ 1, 2 };
    var p: [*]u8 = &t; // pointer to MULTIPLES u8 values
    var s: *[2]u8 = &t; // pointer to Array of U8;
    _ = p;
    _ = s;
}
