const std = @import("std");

const Node = struct {
    value: i32,
    left: ?*Node,
    right: ?*Node,
};

fn createNode(allocator: std.mem.Allocator, value: i32) !*Node {
    const node = try allocator.create(Node);
    node.* = Node{
        .value = value,
        .left = null,
        .right = null,
    };
    return node;
}

fn insert(allocator: std.mem.Allocator, root: ?*Node, value: i32) !*Node {
    if (root == null) {
        return try createNode(allocator, value);
    }

    if (value < root.?.value) {
        root.?.left = try insert(allocator, root.?.left, value);
    } else {
        root.?.right = try insert(allocator, root.?.right, value);
    }

    return root.?;
}

fn search(root: ?*Node, value: i32) bool {
    if (root == null) return false;

    if (root.?.value == value) return true;

    if (value < root.?.value)
        return search(root.?.left, value);
    else
        return search(root.?.right, value);
}

fn inorder(root: ?*Node) void {
    if (root == null) return;

    inorder(root.?.left);
    std.debug.print("{d} ", .{root.?.value});
    inorder(root.?.right);
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var root: ?*Node = null;

    root = try insert(allocator, root, 50);
    root = try insert(allocator, root, 30);
    root = try insert(allocator, root, 70);
    root = try insert(allocator, root, 20);
    root = try insert(allocator, root, 40);
    root = try insert(allocator, root, 60);
    root = try insert(allocator, root, 80);

    std.debug.print("Recorrido in-order:\n", .{});
    inorder(root);
    std.debug.print("\n", .{});

    const encontrado = search(root, 40);
    std.debug.print("Buscar 40: {any}\n", .{encontrado});
}