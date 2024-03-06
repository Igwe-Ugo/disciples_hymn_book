import 'widget.dart';
import 'models/models.dart';
import 'common/widget.dart';
import 'package:flutter/material.dart';

class HymnCardMobile extends StatelessWidget {
  const HymnCardMobile({
    super.key,
    required this.hymns,
    required double fontSize,
  }) : _fontSize = fontSize;

  final DiscipleshipHymnaryModel hymns;
  final double _fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HymnDialog(hymnaryModel: hymns)));
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
