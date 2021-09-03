import Text "mo:base/Text";
import Trie "mo:base/Trie";

import Entity "Entity";
import util "util";

module Schema {
    /// A database schema is the design of tables, columns, relations, and 
    /// constraints that make up a logically distinct section of a database. 
    public class Schema(
        tables : [(
            // Table name (e.g. users).
            Text,
            // Table columns (e.g. username, ...)
            [Entity.Attribute],
        )],
    ) = {
        /// An entity is a table in a database.
        private type Entity = {
            name       : Text;
            attributes : Trie.Trie<Text, AttributeType>
        };

        private type AttributeType = (Entity.AttributeType, [Entity.Constraint]);

        let schema = Trie.empty<Text, Entity>();
        for ((tName, tAttributes) in tables.vals()) {
            let attributes = Trie.empty<Text, AttributeType>();
            for ((cName, cType, cConstraints) in tAttributes.vals()) {
                ignore Trie.replace<Text, AttributeType>(
                    attributes,
                    util.key(cName), Text.equal,
                    ?(cType, cConstraints),
                );
            };
            ignore Trie.replace<Text, Entity>(
                schema,
                util.key(tName), Text.equal,
                ?{
                    name       = tName;
                    attributes = attributes;
                },
            );
        };
    };
};
