import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/*
Getting data for the leaderboard from supabase.
Make a function that gets the data from supabase and returns it as a list of maps/list?.

This will run/reload whenever:
- Player chooses new game
- Player chooses new difficulty
- Player changes the timeframe [not implemented yet]
 */

fetchData(String difficulty, String gameName, String timeframe) async {
  final supabase = Supabase.instance.client;
  final data = await supabase
      .from('player_progress')
      .select()
      .eq('game', gameName)
      .eq('difficulty', difficulty)
      .order('level', ascending: false);
  // print(data);
  return data;
}

fetchPlayerData(String difficulty, String gameName, String timeframe) async {
  final supabase = Supabase.instance.client;
  final data = await supabase
      .from('player_progress')
      .select()
      .eq('user_id', supabase.auth.currentUser!.id)
      .eq('game', gameName)
      .eq('difficulty', difficulty)
      .order('level', ascending: false);
  // print(data);
  return data;
}

