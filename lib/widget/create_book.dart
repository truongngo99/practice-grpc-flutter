import 'package:flutter/material.dart';
import 'package:practice_grpc/generation/book.pbgrpc.dart';
import 'package:practice_grpc/service/service.dart';

class CreateBook extends StatefulWidget {
  const CreateBook({super.key});

  @override
  State<CreateBook> createState() => _CreateBookState();
}

class _CreateBookState extends State<CreateBook> {
  TextEditingController idCtl = TextEditingController();
  TextEditingController nameCtl = TextEditingController();
  TextEditingController imageCtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("id"),
            TextField(
              controller: idCtl,
              decoration: const InputDecoration(hintText: "id"),
            ),
            const Text("title"),
            TextField(
              controller: nameCtl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Book Title"),
            ),
            const Text("Image"),
            TextField(
              controller: imageCtl,
              decoration: const InputDecoration(hintText: "Image"),
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close")),
                ElevatedButton(
                    onPressed: () {
                      final book = Book(
                          id: int.parse(idCtl.text),
                          title: nameCtl.text,
                          imageUrl: imageCtl.text);
                      BookService.createBook(book);
                      Navigator.pop(context, true);
                    },
                    child: const Text("Close")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
