const This = @This();

a: i32 = 4,
b: i32 = 5,

pub fn sum(this: This) i32 {
    return this.a + this.b;
}
