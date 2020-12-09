using System;
using System.IO;
using System.Linq;
using System.Collections.Generic;

var ops = File.ReadAllLines("input")
    .Select((l, i) => (Op) (l.Substring(0,3) switch {
        "acc" => new AccOp(Int32.Parse(l.Substring(4)), i),
        "jmp" => new JmpOp(Int32.Parse(l.Substring(4)), i),
        "nop" => new NopOp(Int32.Parse(l.Substring(4)), i),
        _ => throw new Exception()
    }))
    .ToList();

(int, bool) Run(List<Op> ops) {
    foreach (var o in ops) {
        o.Hits = 0;
    }

    int reg = 0, ip = 0;
    var op = ops[ip];
    while (op.Hits == 0) {
        op.Hits++;
        switch (op) {
            case AccOp a: reg += a.Operand; ip++; break;
            case JmpOp j: ip += j.Operand; break;
            default: ip++; break;
        }
        if (ip == ops.Count) return (reg, true);
        op = ops[ip];
    }
    return (reg, false);
}

// Part 1
Console.WriteLine(Run(ops));

Op Flip(Op toFlip) => toFlip switch {
    JmpOp j => new NopOp(j.Operand, j.Address),
    NopOp n => new JmpOp(n.Operand, n.Address)
};

// Part 2
for (int i = 0; i < ops.Count; i++) {
    var op = ops[i];
    if (op is AccOp) continue;

    ops[i] = Flip(op);
    var (reg, success) = Run(ops);
    if (success) {
        Console.WriteLine(reg);
        break;
    } else {
        ops[i] = op;
    }
}

enum OpType {
    Nop,
    Acc,
    Jmp
}

record Op(OpType Type, int Operand, int Address) { public int Hits = 0; }
record AccOp(int Operand, int Address) : Op(OpType.Acc, Operand, Address);
record NopOp(int Operand, int Address) : Op(OpType.Nop, Operand, Address);
record JmpOp(int Operand, int Address) : Op(OpType.Jmp, Operand, Address);