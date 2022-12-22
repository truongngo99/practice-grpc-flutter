import '../../generation/book.pbgrpc.dart';

class BookService {
  final BookMethodsClient client;

  BookService(this.client);

  Future<Books> getAllBook() async {
    final books = await client.getAllBooks(Empty());
    return books;
  }

  Future deleteBook(BookId id) async {
    await client.deleteBook(id);
  }

  Future createBook(Book book) async {
    await client.createBook(book);
  }

  Future editBook(Book book) async {
    await client.editBook(book);
  }

  Future<Book> getBook(BookId bookId) async {
    return await client.getBook(bookId);
  }
}
