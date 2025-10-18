import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseGameService {
  final SupabaseClient _client = Supabase.instance.client;

  SupabaseGameService();

  Future getGameData(String game, String difficulty) async {
    final response = await _client
        .from('player_progress')
        .select('level')
        .eq('game', game)
        .eq('difficulty', difficulty)
        .limit(1)
        .single();
    print(response);
    return response;
  }

  Future setGameData(int level, String game, String difficulty) async {
    await _client.from('player_progress').upsert(
      {
        'game': game,
        'difficulty': difficulty,
        'level': level,
        'user_id': _client.auth.currentUser?.id
      },
      onConflict: 'game,difficulty,user_id',
      ignoreDuplicates: false,
    ).select();
  }
}
