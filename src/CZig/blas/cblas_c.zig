// zig run main_c.zig -lc -lcblas
const std = @import("std");
const c = @cImport({
    @cInclude("stdio.h");
    @cInclude("stdlib.h");
    @cInclude("cblas.h");
});
//
pub fn main() !void {
    // Using cblas:
    var Layout: c.CBLAS_LAYOUT = c.CblasColMajor;
    var transa: c.CBLAS_TRANSPOSE = c.CblasNoTrans;
    const m: c.CBLAS_INT = 4;
    const n: c.CBLAS_INT = 4;
    var lda: c.CBLAS_INT = 4;
    var incx: c.CBLAS_INT = 1;
    var incy: c.CBLAS_INT = 1;
    var alpha: f64 = 1;
    var beta: f64 = 0;
    var a: [m * m]f64 = .{ 1, 2, 3, 4, 1, 1, 1, 1, 3, 4, 5, 6, 5, 6, 7, 8 };
    var x: [n]f64 = .{ 1, 2, 1, 1 };
    var y: [n]f64 = .{ 0, 0, 0, 0 };

    _ = c.cblas_dgemv(Layout, transa, m, n, alpha, &a, lda, &x, incx, beta, &y, incy);

    for (y) |i, val| {
        _ = c.printf("y%d = %f\n", i, val);
    }
}
test "basic" {
    const s = "hello";
    const add: i32 = 1;
    const a: c_int = 1;
    const b: c_int = 1;
    const v: c_int = c.add(a, b);
    _ = c.printf("%c %i %i", s, add, v);
}
