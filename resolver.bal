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

    resource function get books() returns Book[] {
        BookRow[] books = getBooksByAuthor(self.id);
        return from BookRow book in books
            select convertToBook(book);
    }

}



