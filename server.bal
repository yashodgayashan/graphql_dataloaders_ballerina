import ballerina/graphql;

@graphql:ServiceConfig {
    graphiql: {
        enabled: true
    }
}
service /graphql on new graphql:Listener(9090) {

    resource function get authors(graphql:Context context) returns Author[]? {
        AuthorRow[] authors = getAuthors();
        return from AuthorRow author in authors
            select new (author);
    }

    resource function get author(GetAuthorInput input) returns Author|error? {
        AuthorRow author = check getAuthor(input.id);
        return new (author);
    }
}

