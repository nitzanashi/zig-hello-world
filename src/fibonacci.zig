const std = @import("std");

fn fibonacci(n: u16) u16 {
    if (n == 0 or n == 1) {
        return n;
    }

    return fibonacci(n - 1) + fibonacci(n - 2);
}

test "Fibonacci 5" {
    const x = fibonacci(5);

    try std.testing.expect(x == 5);
}

test "Fibonacci 10" {
    const x = fibonacci(10);

    try std.testing.expect(x == 55);
}
