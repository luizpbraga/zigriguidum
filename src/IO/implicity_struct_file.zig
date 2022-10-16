const expect = @import("std").testing.expect;
//
const ex = @import("struct_module.zig");
//
test "implicit struct file" {
    const v = ex{ .a = 1, .b = 2 };
    try expect(v.sum() == 3);
}
