//
const std = @import("std");
const print = std.debug.print;

// rand
fn getRnf32() f32 {
    var rand_int = std.rand.DefaultPrng.init(0);
    return rand_int.random().float(f32);
}

const EmployeeError = error{
    WrongCredential,
};

const Employee = struct {
    name: []const u8,

    fn greet(this: @This()) void {
        print("Hi, my name is {s}\n", .{this.name});
    }
};

fn getEmployeeOpt() ?Employee {
    const num = @as(f64, getRnf32()); // random f32
    return if (num < 0.5) .{ .name = "David" } else null;
}

fn getEmployeeRes() EmployeeError!?Employee {
    const num = @as(f64, getRnf32()); // random f32
    return if (num < 0.5) .{ .name = "David" } else error.WrongCredential;
}

pub fn main() anyerror!void {
    const employee_opt = getEmployeeOpt();
    const employee_res = try getEmployeeRes();

    employee_opt.?.greet();
    employee_res.?.greet();

    // if (employee_opt) |employee| {
    //     employee.greet();
    // }
    // if (employee_res) |employee| {
    //     employee.greet();
    // }
}
