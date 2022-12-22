import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:practice_grpc/generation/book.pb.dart';

import '../infrastructure/service/service.dart';

part 'detail_book_notifier.freezed.dart';

@freezed
class BookDetailState with _$BookDetailState {
  const BookDetailState._();
  const factory BookDetailState.initial() = _Initial;
  const factory BookDetailState.success(Book book) = _Sucess;
}

class BookDetailNotifier extends StateNotifier<BookDetailState> {
  final BookService _bookService;
  BookDetailNotifier(this._bookService)
      : super(const BookDetailState.initial());

  void getBook(BookId bookId) async {
    final result = await _bookService.getBook(bookId);
    state = BookDetailState.success(result);
  }
}
