import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_grpc/generation/book.pb.dart';
import 'package:practice_grpc/service/service.dart';
import 'package:practice_grpc/widget/create_book.dart';
import 'package:practice_grpc/widget/item_book.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  BookService bookService = BookService();
  List<Book> books = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Screen"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: BookService.getAllBook(),
        builder: (context, AsyncSnapshot<Books> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          books = snapshot.data!.books;
          return ListView(
            children: books
                .map(
                  (book) => ItemBook(book: book),
                )
                .toList(),
          );
        },
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
