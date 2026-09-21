import 'package:flutter/material.dart';

/// Situação atual de um jogo dentro do backlog.
enum GameStatus { wantToPlay, playing, completed }

extension GameStatusInfo on GameStatus {
  String get label {
    switch (this) {
      case GameStatus.wantToPlay:
        return 'Quero jogar';
      case GameStatus.playing:
        return 'Jogando';
      case GameStatus.completed:
        return 'Zerado';
    }
  }

  IconData get icon {
    switch (this) {
      case GameStatus.wantToPlay:
        return Icons.bookmark_border;
      case GameStatus.playing:
        return Icons.videogame_asset;
      case GameStatus.completed:
        return Icons.emoji_events;
    }
  }
}

/// Representa um jogo salvo no backlog do usuário.
class GameItem {
  String title;
  GameStatus status;

  GameItem({required this.title, this.status = GameStatus.wantToPlay});

  /// Converte o objeto em um Map simples, usado para salvar como JSON.
  Map<String, dynamic> toJson() => {
        'title': title,
        'status': status.index,
      };

  /// Reconstrói um GameItem a partir do Map salvo com shared_preferences.
  factory GameItem.fromJson(Map<String, dynamic> json) => GameItem(
        title: json['title'] as String,
        status: GameStatus.values[json['status'] as int],
      );
}
