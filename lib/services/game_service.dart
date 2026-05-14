import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/game_model.dart';

class GameService {
  static const String _key = 'games';

  Future<List<GameModel>> getGames() async {
    final prefs = await SharedPreferences.getInstance();
    final gamesJson = prefs.getStringList(_key) ?? [];

    return gamesJson
        .map((game) => GameModel.fromMap(jsonDecode(game)))
        .toList();
  }

  Future<void> saveGames(List<GameModel> games) async {
    final prefs = await SharedPreferences.getInstance();

    final gamesJson = games
        .map((game) => jsonEncode(game.toMap()))
        .toList();

    await prefs.setStringList(_key, gamesJson);
  }

  Future<void> addGame(GameModel game) async {
    final games = await getGames();

    game.id = DateTime.now().millisecondsSinceEpoch;
    games.add(game);

    await saveGames(games);
  }

  Future<void> updateGame(GameModel updatedGame) async {
    final games = await getGames();

    final index = games.indexWhere((game) => game.id == updatedGame.id);

    if (index != -1) {
      games[index] = updatedGame;
      await saveGames(games);
    }
  }

  Future<void> deleteGame(int id) async {
    final games = await getGames();

    games.removeWhere((game) => game.id == id);

    await saveGames(games);
  }
}