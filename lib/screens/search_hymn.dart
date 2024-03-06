import 'widget.dart';
import 'models/models.dart';
import 'package:flutter/material.dart';

class SearchHymnary extends SearchDelegate<DiscipleshipHymnaryModel> {
  final List<DiscipleshipHymnaryModel> allHymns;
  final List<DiscipleshipHymnaryModel> allHymnsSuggestion;
  final double _fontSize = 14.0;

  SearchHymnary({
    required this.allHymns,
    required this.allHymnsSuggestion,
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
        tooltip: "Clear",
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_left),
      onPressed: () {
        Navigator.of(context).pop();
      },
      tooltip: "Back",
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<DiscipleshipHymnaryModel> hymnsIndex =
        allHymns.where((discipleshipHymns) {
      return discipleshipHymns.title
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          discipleshipHymns.id.toString() == query.toLowerCase();
    }).toList();

    return ListView.builder(
      itemCount: hymnsIndex.length,
      itemBuilder: (context, index) {
        final hymnSearch = hymnsIndex[index];
        return HymnCardMobile(hymns: hymnSearch, fontSize: _fontSize);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<DiscipleshipHymnaryModel> hymnsSuggestion =
        allHymns.where((discipleshipHymns) {
      return discipleshipHymns.title
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          discipleshipHymns.id.toString() == query.toLowerCase();
    }).toList();
    return ListView.builder(
      itemCount: hymnsSuggestion.length,
      itemBuilder: (context, index) {
        final hymnSearch = hymnsSuggestion[index];
        return HymnCardMobile(hymns: hymnSearch, fontSize: _fontSize);
      },
    );
  }
}
