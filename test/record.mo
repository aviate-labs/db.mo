import record "../src/record";

let t = record.Table();
t.init("t00", [
    ("f00", #Boolean),
    ("f01", #Boolean),
]);

assert(t.findEntry("t01", "f00") == null);
assert(t.findEntry("t00", "f02") == null);
assert(t.findValue("t00", "f01", "") == null);
