isolated function convertToBook(BookRow book) returns Book => {
    authorId: book.authorId,
    name: book.name,
    description: book.description
};