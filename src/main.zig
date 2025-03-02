const std = @import("std");

const TokenType = enum {
    Num,
    Plus,
    Minus,
    Undef,
    EOF,
};

const Lexer = struct {
    input: []const u8,
    index: usize,

    pub fn NextTok(self: *Lexer) TokenType {
        while (self.index < self.input.len and self.input[self.index] == ' ' or self.input[self.index] == '\t') {
            self.index += 1;
        }
        if (self.index >= self.input.len) {
            return TokenType.EOF;
        }

        const current = self.input[self.index];

        if (current == '+') {
            self.index += 1;
            return TokenType.Plus;
        } else if (current == '-') {
            self.index += 1;
            return TokenType.Minus;
        } else if (current >= '0' and current <= '9') {
            const NumStart = self.index;
            while (self.index < self.input.len and self.input[self.index] >= '0' and self.input[self.index] <= '9') {
                self.index += 1;
            }

            const num = self.input[NumStart..self.index];
            std.debug.print("{}", .{num});
            return TokenType.Num;
        }
        return TokenType.Undef;
    }
};

pub fn main() void {
    std.debug.print("Hello {s}\n", .{"World"});
}
