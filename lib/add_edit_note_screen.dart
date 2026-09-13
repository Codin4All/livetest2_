import 'package:flutter/material.dart';
import 'package:livetest2/note_model.dart';
import 'package:livetest2/note_storage.dart';



class AddEditNoteScreen extends StatefulWidget {
  final NoteModel? note;

  const AddEditNoteScreen({
    super.key,
    this.note,
  });

  @override
  State<AddEditNoteScreen> createState() =>
      _AddEditNoteScreenState();
}

class _AddEditNoteScreenState
    extends State<AddEditNoteScreen> {
  final TextEditingController titleController =
      TextEditingController();

  final TextEditingController descriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      titleController.text = widget.note!.title;
      descriptionController.text = widget.note!.description;
    }
  }

  Future<void> saveNote() async {
    if (titleController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter title and description'),
        ),
      );

      return;
    }

    if (widget.note == null) {
      final note = NoteModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
      );

      await NoteStorage.addNote(note);
    } else {
      final note = NoteModel(
        id: widget.note!.id,
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
      );

      await NoteStorage.updateNote(note);
    }

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.note != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit Note' : 'Add Note',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter note title',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: descriptionController,
              maxLines: 8,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter note description',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: saveNote,
                icon: const Icon(Icons.save),
                label: Text(
                  isEdit ? 'Update Note' : 'Save Note',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}