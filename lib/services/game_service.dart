import '../database/database_helper.dart';
import '../models/game_model.dart';

class GameService {
  final dbHelper = DatabaseHelper.instance;

  Future<List<GameModel>> getGames() async {
    final db = await dbHelper.database;

    final result = await db.query(
      'games',
      orderBy: 'id DESC',
    );

    return result.map((map) {
      return GameModel.fromMap(map);
    }).toList();
  }

  Future<void> addGame(GameModel game) async {
    final db = await dbHelper.database;

    await db.insert(
      'games',
      game.toMap(),
    );
  }

  Future<void> updateGame(GameModel game) async {
    final db = await dbHelper.database;

    await db.update(
      'games',
      game.toMap(),
      where: 'id = ?',
      whereArgs: [game.id],
    );
  }

  Future<void> deleteGame(int id) async {
    final db = await dbHelper.database;

    await db.delete(
      'games',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}