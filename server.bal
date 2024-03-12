import ballerina/graphql;
import ballerina/http;
import ballerina/graphql.dataloader;

@graphql:ServiceConfig {
    graphiql: {
        enabled: true
    },
    contextInit: isolated function(http:RequestContext requestContext, http:Request request) returns graphql:Context {
        graphql:Context context = new;
        context.registerDataLoader(bookLoaderFunctionName, new dataloader:DefaultDataLoader(bookLoaderFunction));
        return context;
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

