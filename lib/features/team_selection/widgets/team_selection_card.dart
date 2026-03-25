import 'package:flutter/material.dart';

import '../../../core/models/team.dart';

class TeamSelectionCard extends StatelessWidget {
  const TeamSelectionCard({
    super.key,
    required this.team,
    required this.isSelected,
    required this.onTap,
  });

  final Team team;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected ? team.primaryColor : Colors.transparent;

    return Card(
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: borderColor, width: 2),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              SizedBox(
                width: 64,
                height: 64,
                child: Image.asset(
                  team.characterAsset,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => ColoredBox(
                    color: team.primaryColor.withValues(alpha: 0.16),
                    child: Icon(Icons.shield, color: team.primaryColor),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  team.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
