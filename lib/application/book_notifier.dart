import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:practice_grpc/domain/api_failure.dart';

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
  const factory BookState.failure(ApiFailure apiFailure) = _Failure;
}

class BookNotifier extends StateNotifier<BookState> {
  final BookService _bookService;

  BookNotifier(this._bookService) : super(const BookState.initial());

  void getAllBook() async {
    Either<ApiFailure, Books> failureOrSuccess =
        await _bookService.getAllBook();
    state = failureOrSuccess.fold(
        (l) => BookState.failure(l), (r) => BookState.success(r.books));
  }

  void deleteBook(BookId id) async {
    Either<ApiFailure, Empty> failureOrSuccess =
        await _bookService.deleteBook(id);

    failureOrSuccess.fold((l) => BookState.failure(l), (r) {
      final oldSate = (state as _Success);
      List<Book> listBook = List.from(oldSate.books);
      listBook.removeWhere((book) => book.id == int.parse(id.toString()));
      state = BookState.success(listBook);
    });
  }

  void createBook(Book book) async {
    Either<ApiFailure, Empty> failureOrSuccess =
        await _bookService.createBook(book);
    failureOrSuccess.fold((l) => BookState.failure(l), (r) {
      final oldSate = (state as _Success).books;
      List<Book> list = List.from(oldSate);
      list.add(book);

      state = BookState.success(list);
    });
  }

  void editBook(Book book) async {
    Either<ApiFailure, Empty> failureOrSuccess =
        await _bookService.editBook(book);

    failureOrSuccess.fold((l) => BookState.failure(l), (r) {
      final oldSate = (state as _Success);
      final findBook =
          oldSate.books.firstWhere((element) => element.id == book.id);
      findBook.title = book.title;
      findBook.imageUrl = book.imageUrl;
      state = BookState.success(oldSate.books);
    });
  }
}
