import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/game_item.dart';

class BacklogScreen extends StatefulWidget {
  const BacklogScreen({super.key});

  @override
  State<BacklogScreen> createState() => _BacklogScreenState();
}

class _BacklogScreenState extends State<BacklogScreen> {
  // Chave usada para salvar a lista de jogos no armazenamento local.
  static const _storageKey = 'games_backlog';

  final List<GameItem> _games = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ---------- Persistência com shared_preferences ----------

  Future<void> _loadGames() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_storageKey);

    if (stored != null) {
      final List<dynamic> decoded = jsonDecode(stored) as List<dynamic>;
      setState(() {
        _games.addAll(
          decoded.map(
            (item) => GameItem.fromJson(item as Map<String, dynamic>),
          ),
        );
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveGames() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_games.map((g) => g.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  // ---------- Ações do usuário ----------

  void _addGame() {
    final title = _controller.text.trim();
    if (title.isEmpty) return;

    setState(() {
      _games.add(GameItem(title: title));
      _controller.clear();
    });
    _saveGames();
  }

  void _cycleStatus(int index) {
    setState(() {
      final current = _games[index].status;
      final nextIndex = (current.index + 1) % GameStatus.values.length;
      _games[index].status = GameStatus.values[nextIndex];
    });
    _saveGames();
  }

  void _removeGame(int index) {
    setState(() {
      _games.removeAt(index);
    });
    _saveGames();
  }

  // ---------- Interface ----------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu Backlog de Jogos')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            labelText: 'Nome do jogo',
                            border: OutlineInputBorder(),
                          ),
                          onSubmitted: (_) => _addGame(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton.filled(
                        onPressed: _addGame,
                        icon: const Icon(Icons.add),
                        tooltip: 'Adicionar jogo',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: _games.isEmpty
                        ? const Center(
                            child: Text('Nenhum jogo adicionado ainda.'),
                          )
                        : ListView.builder(
                            itemCount: _games.length,
                            itemBuilder: (context, index) {
                              final game = _games[index];
                              return Card(
                                child: ListTile(
                                  leading: Icon(game.status.icon),
                                  title: Text(game.title),
                                  subtitle: Text(game.status.label),
                                  onTap: () => _cycleStatus(index),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete_outline),
                                    tooltip: 'Remover jogo',
                                    onPressed: () => _removeGame(index),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
