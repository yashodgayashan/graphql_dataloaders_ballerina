import ballerina/log;


final AuthorRow & readonly author1 = {
    id: 1,
    name: "J. K. Rowling",
    age: 56
};

final AuthorRow & readonly author2 = {
    id: 2,
    name: "Dan Brown",
    age: 55
};

final AuthorRow & readonly author3 = {
    id: 3,
    name: "R R Tolkin",
    age: 31
};

final AuthorRow[] & readonly authors = [author1, author2, author3];

final BookRow[] & readonly books = [
    rowlingBook1, rowlingBook2, rowlingBook3, 
    brownBook1, brownBook2, 
    tolkinBook1, tolkinBook2, tolkinBook3, tolkinBook4
];

final BookRow & readonly rowlingBook1 = {
    name: "Harry Potter 1", description: "some", authorId: 1
};

final BookRow & readonly rowlingBook2 = {
    name: "Harry Potter 2", description: "some", authorId: 1
};

final BookRow & readonly rowlingBook3 = {
    name: "Harry Potter 3", description: "some", authorId: 1
};

final BookRow & readonly brownBook1 = {
    name: "Origin", description: "some", authorId: 2
};

final BookRow & readonly brownBook2 = {
    name: "Inferno", description: "some", authorId: 2
};

final BookRow & readonly tolkinBook1 = {
    name: "LOTR 1", description: "some", authorId: 3
};

final BookRow & readonly tolkinBook2 = {
    name: "LOTR 2", description: "some", authorId: 3
};

final BookRow & readonly tolkinBook3 = {
    name: "LOTR 3", description: "some", authorId: 3
};

final BookRow & readonly tolkinBook4 = {
    name: "Hobbit", description: "some", authorId: 3
};

isolated function getAuthors() returns AuthorRow[] {
    log:printInfo("Database call to get all authors");
    return authors;
}

isolated function getAuthor(int id) returns AuthorRow|error {
    log:printInfo(string `Database call to get author with Id ${id}`);
    AuthorRow[] filteredAuthors = authors.filter(author => author.id == id);
    if filteredAuthors.length() == 1 {
        return filteredAuthors[0];
    }
    return error("author cannot be found");
}

isolated function getBooksByAuthor(int authorId) returns BookRow[] {
    log:printInfo(string `Database call to get books for authorId ${authorId}`);
    return books.filter(book => book.authorId == authorId);
}

isolated function getBooksByAuthors(int[] authorIds) returns BookRow[] {
    log:printInfo("Database call to get books for all authors");
    BookRow[] filteredBooks = [];
    foreach int authorId in authorIds {
        BookRow[] authorBooks = books.filter(book => book.authorId == authorId);
        filteredBooks.push(...authorBooks);
    }
    return filteredBooks;
}

