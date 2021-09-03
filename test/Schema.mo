import Schema "../src/Schema";

let schema = Schema.Schema([
    ("users", [
        ("userName",  #Text, [#Unique]),
        ("givenName", #Text, []),
        ("lastName",  #Text, []),
    ]),
]);
