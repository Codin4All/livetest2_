import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:livetest2/main.dart';
import 'package:livetest2/note_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('note app shows the notes screen title', (tester) async {
    await NoteStorage.init();
    await tester.pumpWidget(const NoteManagementApp());
    await tester.pump();

    expect(find.text('My Notes'), findsOneWidget);
  });
}
