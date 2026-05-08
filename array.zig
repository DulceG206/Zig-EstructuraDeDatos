const std = @import("std");

pub fn main() void {
    
    var numeros: [5]i32 = .{ 10, 20, 30, 40, 50 };

    
    std.debug.print("Primer elemento: {}\n", .{numeros[0]});

    
    numeros[2] = 99;

    
    for (numeros) |valor, i| {
        std.debug.print("Indice {}: {}\n", .{i, valor});
    }
}
