const std = @import("std");
const expect = std.testing.expect;

fn increment(num: *u8) void {
    num.* += 1;
}

test "Pointer arithmetic" {
    var x: u8 = 0;

    increment(&x);

    try expect(x == 1);
}

test "usize" {
    try expect(@sizeOf(usize) == @sizeOf(*u8));
    try expect(@sizeOf(isize) == @sizeOf(*u8));
}


// Many item pointer

fn doubleAllManyPointer(buffer: [*]u8, byte_count: usize) void {
    var i: usize = 0;

    while (i < byte_count) : (i += 1) {
        buffer[i] *= 2;
    }
}

test "many-item pointers" {
    var buffer: [100]u8 = [_]u8{1} ** 100;
    const buffer_ptr: *[100]u8 = &buffer;

    const buffer_many_ptr: [*]u8 = buffer_ptr;
    doubleAllManyPointer(buffer_many_ptr, buffer.len);

    for (buffer) |byte| {
        try expect(byte == 2);
    }

    const first_element_ptr: *u8 = &buffer_many_ptr[0];
    const first_element_ptr2: *u8 = @ptrCast(buffer_many_ptr);

    try expect(first_element_ptr == first_element_ptr2);
}
