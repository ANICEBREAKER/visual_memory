// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'persistence/local_storage_player_progress_persistence.dart';
import 'persistence/player_progress_persistence.dart';
import 'package:game_testing/service/game_progress_storage_service.dart';

/// Encapsulates the player's progress.
class PlayerProgress extends ChangeNotifier {

  /// By default, settings are persisted using
  /// [LocalStoragePlayerProgressPersistence] (i.e. NSUserDefaults on iOS,
  /// SharedPreferences on Android or local storage on the web).
  final PlayerProgressPersistence _store;
  final SupabaseGameService _gameService = SupabaseGameService();

  int _highestLevelReached = 0;
  bool isNewHighScore = false;

  /// Creates an instance of [PlayerProgress] backed by an injected
  /// persistence [store].
  PlayerProgress({PlayerProgressPersistence? store})
    : _store = store ?? LocalStoragePlayerProgressPersistence();

  /// The highest level that the player has reached so far.
  int get highestLevelReached => _highestLevelReached;

  /// Resets the player's progress so it's like if they just started
  /// playing the game for the first time.
  void reset() {
    _highestLevelReached = 0;
    notifyListeners();
    //_store.saveHighestLevelReached(level: _highestLevelReached, game: game, difficulty: difficulty);
  }

  /// Registers [level] as reached.
  ///
  /// If this is higher than [highestLevelReached], it will update that
  /// value and save it to the injected persistence store.
  void setLevelReached(int level, String game, String difficulty) {
    if (level > _highestLevelReached) {
      _highestLevelReached = level;
      isNewHighScore = true;
      notifyListeners();
      //unawaited(_store.saveHighestLevelReached(level: level, game: game, difficulty: difficulty));
      _gameService.setGameData(level, game, difficulty);
    } else {
      isNewHighScore = false;
    }
  }

  /// Fetches the latest data from the backing persistence store.
  Future<void> getLatestFromStore(String game, String difficulty) async {
    final level = await _store.getHighestLevelReached(game: game, difficulty: difficulty);
    if (level > _highestLevelReached) {
      _highestLevelReached = level;
      notifyListeners();
    } else if (level < _highestLevelReached) {
      await _store.saveHighestLevelReached(level: _highestLevelReached, game: game, difficulty: difficulty);
    }
  }
}
//TODO: Fix the SharedPreferences issues [a.k.a] local storage in the program [particularly for player progress]