const std = @import("std");

fn fact(n: u64) u64 {
    return if (n == 1) n else n * fact(n - 1);
}

pub fn main() void {
    @setEvalBranchQuota(1000); // minimum loop quota for backwards branches
    std.debug.print("res: {d}", .{comptime factorial(10)}); // arbitrary Compile Time Function Evaluation
}
