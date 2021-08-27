import Trie "mo:base/Trie";

module Field {
    public type Type = {
        #Boolean;
        // TODO: Int, Nat, Text, ...
    };

    public type TypeTable = Trie.Trie<Text, Type>;

    public type Value = {
        #Scalar : ?Scalar;
    };

    public type ValueTable = Trie.Trie<Text, Value>;

    public type Scalar = {
        #Boolean : Bool;
        // etc... (same as types?)
    };
};
