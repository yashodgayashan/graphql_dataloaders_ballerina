public isolated function bookLoaderFunction(readonly & anydata[] ids) returns BookRow[][]|error {
    final readonly & int[] authorIds = <readonly & int[]>ids;

    final BookRow[] & readonly books = (getBooksByAuthors(authorIds)).cloneReadOnly();

    return authorIds.'map(
        isolated function(readonly & int authorId) returns BookRow[] {
            return books.filter(book => book.authorId == authorId);
        }
    );
};