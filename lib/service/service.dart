import 'package:grpc/grpc.dart';

import '../generation/book.pbgrpc.dart';

// class BookMethodsService extends BookMethodsServiceBase {
//   Books books = Books();

//   @override
//   Future<Book> createBook(ServiceCall call, Book request) async {
//     var book = Book();
//     book.title = request.title;
//     book.id = request.id;
//     books.books.add(book);
//     return book;
//   }

//   @override
//   Future<Empty> deleteBook(ServiceCall call, BookId request) async {
//     books.books.removeWhere((book) => book.id == request.id);
//     return Empty();
//   }

//   @override
//   Future<Book> editBook(ServiceCall call, Book request) async {
//     final book = books.books.firstWhere((book) => book.id == request.id);
//     book.title = request.title;
//     return book;
//   }

//   @override
//   Future<Books> getAllBooks(ServiceCall call, Empty request) async {
//     return books;
//   }

//   @override
//   Future<Book> getBook(ServiceCall call, BookId request) async {
//     final book = books.books.firstWhere((book) => book.id == request.id);
//     return book;
//   }
// }

// void main(List<String> arguments) async {
//   final server = Server(
//     [BookMethodsService()],
//     const <Interceptor>[],
//     CodecRegistry(
//       codecs: const [GzipCodec(), IdentityCodec()],
//     ),
//   );
//   await server.serve(port: 50051);
//   // print("Server listening on port ${server.port}...");
// }

class BookService {
  static late BookMethodsClient client;

  BookService() {
    client = BookMethodsClient(
      ClientChannel(
        "localhost",
        port: 50051,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      ),
    );
  }

  static Future<Books> getAllBook() async {
    final books = await client.getAllBooks(Empty());
    return books;
  }

  static Future deleteBook(BookId id) async {
    await client.deleteBook(id);
  }

  static Future createBook(Book book) async {
    await client.createBook(book);
  }
}
