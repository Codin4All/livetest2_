import 'package:flutter/material.dart';
import 'package:livetest2/note_card.dart';
import 'package:livetest2/note_model.dart';
import 'package:livetest2/note_storage.dart';
import 'add_edit_note_screen.dart';
import 'note_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  List<NoteModel> notes = [];
  List<NoteModel> filteredNotes = [];

  final TextEditingController searchController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    loadNotes();

    searchController.addListener(searchNotes);
  }

  void loadNotes() {
    notes = NoteStorage.getNotes();
    filteredNotes = List.from(notes);

    setState(() {});
  }

  void searchNotes() {
    final query = searchController.text.toLowerCase();

    setState(() {
      filteredNotes = notes.where((note) {
        return note.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> addNote() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddEditNoteScreen(),
      ),
    );

    loadNotes();
  }

  Future<void> editNote(NoteModel note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditNoteScreen(
          note: note,
        ),
      ),
    );

    loadNotes();
  }

  Future<void> deleteNote(NoteModel note) async {
    await NoteStorage.deleteNote(note.id);

    loadNotes();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Note deleted'),
      ),
    );
  }

  void showDeleteDialog(NoteModel note) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Note'),
          content: const Text(
            'Are you sure you want to delete this note?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                deleteNote(note);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by title...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          searchController.clear();
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: filteredNotes.isEmpty
                  ? const Center(
                      child: Text(
                        'No notes found',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredNotes.length,
                      itemBuilder: (context, index) {
                        final note = filteredNotes[index];

                        return NoteCard(
                          note: note,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NoteDetailsScreen(
                                  note: note,
                                ),
                              ),
                            );
                          },
                          onEdit: () {
                            editNote(note);
                          },
                          onDelete: () {
                            showDeleteDialog(note);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}