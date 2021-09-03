module Table {
    /// A database attribute is a characteristic of a database entity.
    /// An attribute is a column in a database table.
    public type Attribute = (
        // Name of the column.
        Text,
        // Type of the column fields (e.g. Text).
        AttributeType,
        // Set of constraints on the data.
        [Constraint],
    );

    /// A database constraint is a set of rules that define valid data.
    public type Constraint = {
        // A field must contain a unique value in the table.
        #Unique;
        // A field can contain only specific data types or even specific allowable values.
        #Check : (Field) -> Bool;
        // A field will contain a default value if it has no existing value to preclude a null value.
        #Default : Field;
        // The primary key must be unique.
        #PrimaryKey;
        // The foreign key must match an existing primary key in another table.
        #ForeignKey : Text;
    };

    public type AttributeType = {
        #Text;
        // etc.
    };

    public type Field = {
        #Text : Text;
    };
};
