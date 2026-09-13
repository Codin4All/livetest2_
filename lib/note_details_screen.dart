import 'package:flutter/material.dart';
import 'package:livetest2/note_model.dart';


class NoteDetailsScreen extends StatelessWidget {
  final NoteModel note;

  const NoteDetailsScreen({
    super.key,
    required this.note,
  });



  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              note.description,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}