import 'package:flutter/material.dart';
import 'package:flutter_supabase/pages/dashboard.dart';
import 'package:flutter_supabase/pages/login.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const Login(),
  '/dashboard': (context) => const DashboardTeams(),
};