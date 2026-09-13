import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:livetest2/note_model.dart';

class NoteStorage {
  static const String boxName = 'notes';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  static Box get box => Hive.box(boxName);

  static List<NoteModel> getNotes() {
    return box.values.map((note) => NoteModel.fromMap(Map.from(note))).toList();
  }

  static Future<void> addNote(NoteModel note) async {
    await box.put(note.id, note.toMap());
  }

  static Future<void> updateNote(NoteModel note) async {
    await box.put(note.id, note.toMap());
  }

  static Future<void> deleteNote(String id) async {
    await box.delete(id);
  }
}
