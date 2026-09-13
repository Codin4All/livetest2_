import 'package:flutter/material.dart';
import 'package:livetest2/home_screen.dart';
import 'package:livetest2/note_storage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NoteStorage.init();

  runApp(const NoteManagementApp());
}
//hee
class NoteManagementApp extends StatelessWidget {
  const NoteManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}