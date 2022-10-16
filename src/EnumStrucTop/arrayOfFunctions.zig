const std = @import("std");
var i: i32 = 0;

fn printFn() void {
    std.debug.print("i = {}\n", .{i});
}

fn incrementFn() void {
    i += 1;
}

fn incrementByFn(e: i32) void {
    i += e;
}

const fnEnum = enum {
    print,
    increment,

    //pub const Table = [@typeInfo(fnEnum).Enum.fields.len]*const fn () void{
    pub const Table = [_]*const fn () void{
        printFn,
        incrementFn,
    };
};

const fnEnum3 = enum {
    print,
    increment,
    incrementBy,
    pub const Table = .{ printFn, incrementFn, incrementByFn };
};

//const fnEnum2 = enum {
//print,
//increment,
//incremmentBy,

pub const TableFn = struct {
    print: *const fn () void = printFn,
    increment: *const fn () void = incrementFn,
    incrementBFnyFn: *const fn (i32) void = incrementByFn,
    //};
};

pub fn main() void {
    var input: fnEnum = .increment;
    fnEnum.Table[@enumToInt(input)]();
    input = .print;
    fnEnum.Table[@enumToInt(input)]();

    var input2: TableFn = .{};
    input2.print();

    comptime var input3: fnEnum3 = .print;
    fnEnum3.Table[@enumToInt(input3)]();
}
