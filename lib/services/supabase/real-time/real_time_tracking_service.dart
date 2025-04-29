import 'package:supabase_flutter/supabase_flutter.dart';

/// UTILS FOR REAL TIME TRACKING SERVICE
Future<void> upsertUser(String username, String color) async {
  await Supabase.instance.client
      .from('teams')
      .upsert({'username': username, 'team': color});
}

Future<void> deleteUser(String username) async {
  await Supabase.instance.client
      .from('teams')
      .delete()
      .eq('username', username);
}
