// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:shared_preferences/shared_preferences.dart';
import 'player_progress_persistence.dart';

/// An implementation of [PlayerProgressPersistence] that uses
/// `package:shared_preferences`.
class LocalStoragePlayerProgressPersistence extends PlayerProgressPersistence {
  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();


  @override
  Future<int> getHighestLevelReached({difficulty = " ", game = ""}) async {
    String infoDestination = 'highestLevelReached_${game}_$difficulty';
    print("Getting highest level for Difficulty: $difficulty, Game: $game");
    int highestLevelReached = await asyncPrefs.getInt(infoDestination) ?? 0;
    print(highestLevelReached);
    return highestLevelReached;
  }

  @override
  Future<void> saveHighestLevelReached({level = 0, difficulty = " ", game = ""}) async {
    String infoDestination = 'highestLevelReached_${game}_$difficulty';
    print("Saving highest level for Difficulty: $difficulty, Game: $game, Level: $level");
    await asyncPrefs.setInt(infoDestination, level);
  }
}
