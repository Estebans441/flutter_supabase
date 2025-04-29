import 'package:flutter/material.dart';
import 'package:flutter_supabase/services/provider/team_provider.dart';
import 'package:provider/provider.dart';

import '../services/supabase/real-time/real_time_tracking_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Controller for the username input field
  final TextEditingController _usernameController = TextEditingController();
  // Variable to store the selected color
  String? _selectedColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'SELECTOR DE\nEQUIPOS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 4,
                width: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 32),
              const Text(
                'Ingrese su nombre de usuario',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Escoge un Equipo',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ColorBox(
                    color: Colors.yellow.shade200,
                    isSelected: _selectedColor == "Amarillo",
                    onTap: () {
                      setState(() {
                        _selectedColor = "Amarillo";
                      });
                    },
                  ),
                  const SizedBox(width: 20),
                  _ColorBox(
                    color: Colors.lightBlue.shade200,
                    isSelected: _selectedColor == "Azul",
                    onTap: () {
                      setState(() {
                        _selectedColor = "Azul";
                      });
                    },
                  ),
                  const SizedBox(width: 20),
                  _ColorBox(
                    color: Colors.pink.shade200,
                    isSelected: _selectedColor == "Rojo",
                    onTap: () {
                      setState(() {
                        _selectedColor = "Rojo";
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.lightBlue),
                  ),
                ),
                onPressed: () {
                  final teamService =
                      Provider.of<TeamService>(context, listen: false);
                  teamService.currentUser = _usernameController.text;

                  // Write the changes on DB
                  upsertUser(
                      _usernameController.text, _selectedColor ?? 'blue');

                  Navigator.pushNamed(context, 'dashboard');
                },
                child: const Text(
                  'Ingresar',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorBox extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _ColorBox({
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: !isSelected
                ? Colors.transparent
                : color == Colors.yellow.shade200
                    ? Colors.yellow.shade800
                    : color == Colors.lightBlue.shade200
                        ? Colors.lightBlue.shade800
                        : Colors.pink.shade800,
            width: isSelected ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
