import ballerina/graphql;
import ballerina/graphql.dataloader;

service class Author {
    private final string name;
    private final int age;
    private final int id;

    function init(AuthorRow author) {
        self.id = author.id;
        self.name = author.name;
        self.age = author.age;
    }

    resource function get name() returns string => self.name;

    resource function get age() returns int => self.age;

    // resource function get books() returns Book[] {
    //     BookRow[] books = getBooksByAuthor(self.id);
    //     return from BookRow book in books
    //         select convertToBook(book);
    // }

    isolated function preBooks(graphql:Context ctx) {
        dataloader:DataLoader booksLoader = ctx.getDataLoader(bookLoaderFunctionName);
        booksLoader.add(self.id);
    }

    isolated resource function get books(graphql:Context ctx) returns Book[]|error {
        dataloader:DataLoader booksLoader = ctx.getDataLoader(bookLoaderFunctionName);
        BookRow[] books = check booksLoader.get(self.id);
        return from BookRow book in books
                select convertToBook(book);
    }
}



