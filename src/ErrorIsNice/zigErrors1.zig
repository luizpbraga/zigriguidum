//
const std = @import("std");
const print = std.debug.print;
//
const SomeErrorType = error{
    Myerror,
};

const E1 = error{err1};
const E2 = error{err2};
const E = E1 || E2;

fn barfoo(i: i32) E!void {
    if (i < 0) {
        return E.err1;
    } else if (i > 0 and i < 10) {
        return E.err2;
    }
}

//fn foo(i: i32) SomeErrorType!i32 {
fn foo(i: i32) anyerror!i32 {
    return if (i > 0) 2 * i else error.Myerror;
}

//fn bar(i: i32) anyerror!i32 {
fn bar(i: i32) !i32 {
    return if (i > 0) 2 * i else error.MyMathEror;
}

// U can create a errorSet
fn foobar(i: i32) error{Myerr}!void {
    return if (i < 0) error.Myerr;
}

//pub fn main() anyerror!void {
pub fn main() !void {
    try barfoo(5);
    const x = try foo(-10);
    _ = x;
    const y = try bar(-10);
    _ = y;
    try foobar(-10);
}
