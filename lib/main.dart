import 'package:flutter/material.dart';

import 'screens/backlog_screen.dart';

void main() {
  runApp(const GameBacklogApp());
}

class GameBacklogApp extends StatelessWidget {
  const GameBacklogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Backlog de Jogos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const BacklogScreen(),
    );
  }
}
