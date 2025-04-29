import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/provider/team_provider.dart';

class DashboardTeams extends StatelessWidget {
  const DashboardTeams({super.key});

  static const Map<String, MaterialColor> _teamColors = {
    'Amarillo': Colors.yellow,
    'Azul': Colors.blue,
    'Rojo': Colors.red,
  };

  static const Map<String, List<String>> _members = {
    'Amarillo': ['Ana', 'Beto', 'Carlos'],
    'Azul': ['X', 'Y', 'Z'],
    'Rojo': ['Juan', 'Luisa', 'Mateo'],
  };

  @override
  Widget build(BuildContext context) {
    // Get the provider
    final teamService = Provider.of<TeamService>(context);

    final String currentTeam = teamService.currentTeam ?? 'Azul';
    final MaterialColor teamColor = _teamColors[currentTeam]!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hola,\n<NOMBRE>!',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: _teamColors.entries.map((e) {
                        final color = e.value;
                        return ChoiceChip(
                          label: Text(e.key),
                          selected: currentTeam == e.key,
                          selectedColor: color.shade400,
                          backgroundColor: color.shade100,
                          labelStyle: TextStyle(
                            color: color.computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white,
                          ),
                          onSelected: (_) => teamService.currentTeam = e.key,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    _TeamBox(
                      title: 'Equipo $currentTeam',
                      members: _members[currentTeam] ?? const [],
                      color: teamColor,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black87),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Actualiza tu equipo',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _teamColors.entries.map((e) {
                            final color = e.value;
                            return GestureDetector(
                              onTap: () => teamService.currentTeam = e.key,
                              child: Container(
                                width: 32,
                                height: 32,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: color.shade400,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: color.shade800, width: 2),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                      backgroundColor: Colors.red.shade100,
                      foregroundColor: Colors.red.shade700,
                      side: BorderSide(color: Colors.red.shade300),
                    ),
                    onPressed: () => teamService.clear(),
                    child: const Text('Salir'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamBox extends StatelessWidget {
  const _TeamBox({
    required this.title,
    required this.members,
    required this.color,
  });

  final String title;
  final List<String> members;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    const double lineHeight = 24;
    const double maxVisibleHeight = 6 * lineHeight;
    final bool needsScroll = members.length * lineHeight > maxVisibleHeight;

    Widget list = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: members
          .map((m) => Text(m, style: const TextStyle(fontSize: 14)))
          .toList(),
    );

    if (needsScroll) {
      list = SizedBox(
        height: maxVisibleHeight,
        child: SingleChildScrollView(child: list),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.shade700, width: 3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: color.shade700)),
          const SizedBox(height: 8),
          list,
        ],
      ),
    );
  }
}
