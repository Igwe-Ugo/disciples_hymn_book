import 'models/models.dart';
import 'common/widget.dart';
import 'package:flutter/material.dart';

class HymnCard extends StatelessWidget {
  const HymnCard({
    super.key,
    required this.hymns,
    required double fontSize,
    required this.onTap,
    required this.fromHome,
  }) : _fontSize = fontSize;

  final DiscipleshipHymnaryModel hymns;
  final double _fontSize;
  final void Function(int) onTap;
  final bool fromHome;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(hymns.id);
        if (!fromHome) {
          Navigator.of(context).pop();
        }
      },
      child: Card(
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
          leading: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Styles.defaultBlueColor,
              borderRadius: BorderRadius.circular(15),
            ),
            constraints: const BoxConstraints(
              minWidth: 30,
              minHeight: 30,
            ),
            child: Text(
              hymns.id.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          title: Text(
            hymns.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Styles.defaultBlueColor,
              fontSize: 15.0,
            ),
          ),
          subtitle: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              hymns.verses,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: _fontSize,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}
