import Text "mo:base/Text";
import Trie "mo:base/Trie";

module Util {
    public func key(key : Text) : Trie.Key<Text> = {
        hash = Text.hash(key);
        key  = key;
    };
};
