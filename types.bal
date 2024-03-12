public type Book record {|
    int authorId;
    string name;
    string description;
|};

public type BookRow record {|
    int authorId;
    string name;
    string description;
|};

public type AuthorRow record {|
    int id;
    string name;
    int age;
|};

public type GetAuthorInput record {|
    int id;
|};