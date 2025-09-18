import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandora_ui/pandora_ui.dart';
import 'features/notes/presentation/notes_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  print('✅ Starting Pandora app...');
  
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pandora Notes',
      theme: createPandoraLightTheme(),
      darkTheme: createPandoraTheme(),
      themeMode: ThemeMode.system,
      home: const NotesListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
