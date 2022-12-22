import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_grpc/generation/book.pb.dart';
import 'package:practice_grpc/presentation/widget/create_book.dart';
import 'package:practice_grpc/presentation/widget/item_book.dart';
import 'package:practice_grpc/share/provider.dart';

class BookScreen extends ConsumerStatefulWidget {
  const BookScreen({super.key});

  @override
  ConsumerState<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends ConsumerState<BookScreen> {
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    ref.read(bookProvider.notifier).getAllBook();
  }

  @override
  Widget build(BuildContext context) {
    final bookState = ref.watch(bookProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Book Screen",
        ),
        centerTitle: true,
      ),
      body: bookState.maybeWhen(
        orElse: () => const Center(
            child: CupertinoActivityIndicator(
          radius: 20,
        )),
        success: (books) => ListView(
          children: books
              .map(
                (book) => ItemBook(book: book),
              )
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const CreateBook();
            },
          );
        },
        tooltip: "Add Book",
        child: const Icon(Icons.add),
      ),
    );
  }
}
