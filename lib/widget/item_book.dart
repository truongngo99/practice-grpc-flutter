import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:practice_grpc/generation/book.pb.dart';
import 'package:practice_grpc/service/service.dart';

class ItemBook extends StatelessWidget {
  final Book book;
  const ItemBook({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      direction: Axis.horizontal,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 1,
            onPressed: (context) {
              print("edit");
            },
            backgroundColor: const Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            flex: 1,
            onPressed: (context) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Are you sure you want to delete?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          BookService.deleteBook(BookId(id: book.id));
                          Navigator.pop(context);
                        },
                        child: const Text('Yes'),
                      )
                    ],
                  );
                },
              );
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        leading: Image.network(book.imageUrl),
        title: Text(book.title),
      ),
    );
  }
}
