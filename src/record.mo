import Result "mo:base/Result";
import Text "mo:base/Text";
import Trie "mo:base/Trie";

import field "field";

module {
    public type PrimaryKey = Text;

    private type Record = {
        name   : Text;
        types  : field.TypeTable;
        values : Trie.Trie<PrimaryKey, field.ValueTable>;
    };

    public class Table() = {
        let table = Trie.empty<Text, Record>();

        public func init(
            name   : Text,
            fields : [(Text, field.Type)],
        ) {
            let types = Trie.empty<Text, field.Type>();
            for ((fn, ft) in fields.vals()) {
                ignore Trie.replace<Text, field.Type>(
                    types,
                    _key(fn), Text.equal,
                    ?ft,
                );
            };
            ignore Trie.replace<Text, Record>(
                table,
                _key(name), Text.equal,
                ?{
                    name   = name;
                    types  = types;
                    values = Trie.empty<Text, field.ValueTable>();
                },
            );
        };

        public func findEntry(
            name : Text,
            key  : PrimaryKey,
        ) : ?field.ValueTable {
            let record = Trie.find(
                table,
                _key(name), Text.equal,
            );
            switch (record) {
                case (null) { null; };
                case (? r)  {
                    let vt = Trie.find(
                        r.values,
                        _key(key), Text.equal,
                    );
                    switch (vt) {
                        case (null) { null; };
                        case (? e)  { ?e;    };
                    };
                };
            };
        };

        public func findValue(
            name      : Text,
            key       : PrimaryKey,
            fieldName : Text,
        ) : ?field.Value {
            let entry = findEntry(name, key);
            switch (entry) {
                case (null) { null; };
                case (? e)  {
                    Trie.find(
                        e,
                        _key(fieldName), Text.equal
                    );
                };
            };
        };

        private func _key(key : Text) : Trie.Key<Text> = {
            hash = Text.hash(key);
            key  = key;
        };
    };
};
