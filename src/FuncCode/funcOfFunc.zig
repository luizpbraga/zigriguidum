// why comptime ?
const Fn = *const fn () void;

fn testIt(comptime f: Fn) bool {
    f();
    return true;
}

fn foo() void {}

test "foo" {
    if (testIt(foo)) {} else unreachable;
}

pub fn main() void {}
