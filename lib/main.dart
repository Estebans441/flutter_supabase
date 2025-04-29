import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_supabase/pages/dashboard.dart';
import 'package:flutter_supabase/pages/login.dart';
import 'package:flutter_supabase/services/provider/team_provider.dart';
import 'package:flutter_supabase/services/supabase/supabase_config.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  await SupabaseConfig.initializeSupabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TeamService>(
          create: (_) => TeamService(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Team Selector',
          initialRoute: 'dashboard',
          routes: {
            '/': (_) => Login(),
            'dashboard': (_) => DashboardTeams(),
          }),
    );
  }
}
