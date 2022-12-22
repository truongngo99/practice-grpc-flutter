import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../generation/book.pb.dart';
import '../infrastructure/service/service.dart';
part 'book_notifier.freezed.dart';

@freezed
class BookState with _$BookState {
  const BookState._();
  const factory BookState.initial() = _Initial;
  const factory BookState.success(
    List<Book> books,
  ) = _Success;
}

class BookNotifier extends StateNotifier<BookState> {
  final BookService _bookService;

  BookNotifier(this._bookService) : super(const BookState.initial());

  void getAllBook() async {
    final books = await _bookService.getAllBook();
    if (books.books.isNotEmpty) {
      state = BookState.success(books.books);
    }
  }

  void deleteBook(BookId id) async {
    await _bookService.deleteBook(id);
    getAllBook();
  }

  void createBook(Book book) async {
    await _bookService.createBook(book);
    getAllBook();
  }

  void editBook(Book book) async {
    await _bookService.editBook(book);
    getAllBook();
  }
}
