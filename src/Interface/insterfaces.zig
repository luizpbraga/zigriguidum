//
// This ain't dynamic Dispatch
//
const std = @import("std");
const print = std.debug.print;
//
// Implementation 1:
//      A lot of memory used and still not possible to add a custom method
//      to the interface;
//      use of TagUnions;
//
const Triangulo = union(enum) {
    Equilatero: struct {
        l: f64,
        fn area(this: @This()) f64 {
            return @sqrt(@as(f64, 3)) * this.l * this.l / 4.0;
        }
    },

    Retangulo: struct {
        c1: f64,
        c2: f64,
        h: f64,
        fn area(this: @This()) f64 {
            return this.c1 * this.c2 / 2.0;
        }
    },

    fn area(this: @This()) f64 {
        return switch (this) {
            .Retangulo => |this| this.area(),
            .Equilatero => |this| this.area(),
        };
    }
};

const Foo = union(enum) {
    um: struct {
        a: i32,
        b: i32,
        fn bar(this: @This()) i32 {
            return this.a + this.b;
        }
    },

    dois: struct {
        a: i32,
        b: i32,
        fn bar(this: @This()) i32 {
            return 2 * (this.a + this.b);
        }
    },

    fn bar(this: @This()) i32 {
        return switch (this) {
            .um => |um| um.bar(),
            .dois => |dois| dois.bar(),
        };
    }
};

pub fn main() !void {
    const s: Foo = .{ .um = .{ .a = 1.0, .b = 3.0 } };
    const t: Triangulo = .{ .Equilatero = .{ .l = 32 } };

    print("{d:.5}\n", .{t.area()});
    print("{d}\n", .{s.bar()});
}
