import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';
import 'package:practice_grpc/application/book_notifier.dart';
import 'package:practice_grpc/application/detail_book_notifier.dart';

import '../generation/book.pbgrpc.dart';
import '../infrastructure/service/service.dart';

final serviceProvider = Provider((ref) {
  final client = BookMethodsClient(
    ClientChannel(
      "localhost",
      port: 50051,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    ),
  );
  return BookService(client);
});

final bookProvider = StateNotifierProvider<BookNotifier, BookState>((ref) {
  return BookNotifier(ref.read(serviceProvider));
});

final bookDetailProvider =
    StateNotifierProvider<BookDetailNotifier, BookDetailState>((ref) {
  return BookDetailNotifier(ref.read(serviceProvider));
});
