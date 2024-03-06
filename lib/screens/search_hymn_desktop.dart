import 'package:flutter/material.dart';
import 'models/models.dart';
import 'widget.dart';

class SearchDesktop extends SearchDelegate<DiscipleshipHymnaryModel>{
  final List<DiscipleshipHymnaryModel> allHymnsDesktop;
  final List<DiscipleshipHymnaryModel> allHymnsDesktopSuggestion;
  final Function(int) onSearchResultSelected;
  final double _fontSize = 14.0;

  SearchDesktop({
    required this.allHymnsDesktop,
    required this.allHymnsDesktopSuggestion,
    required this.onSearchResultSelected
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
    final List<DiscipleshipHymnaryModel> hymnsIndex = allHymnsDesktop.where((disciplesHymn) {
      return disciplesHymn.title.toString().toLowerCase().contains(query.toLowerCase()) || disciplesHymn.id.toString() == query.toLowerCase();
    }).toList();
    return ListView.builder(
      itemCount: hymnsIndex.length,
      itemBuilder: (context, index){
        final hymnDesktopSearch = hymnsIndex[index];
        return HymnCard(
          fromHome: true,
          fontSize: _fontSize,
          hymns: hymnDesktopSearch,
          onTap: (value) {
            onSearchResultSelected(value);
            Navigator.of(context).pop();
          },
        );
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<DiscipleshipHymnaryModel> hymnsIndex = allHymnsDesktop.where((disciplesHymn) {
      return disciplesHymn.title.toString().toLowerCase().contains(query.toLowerCase()) || disciplesHymn.id.toString() == query.toLowerCase();
    }).toList();
    return ListView.builder(
        itemCount: hymnsIndex.length,
        itemBuilder: (context, index){
          final hymnDesktopSearch = hymnsIndex[index];
          return HymnCard(
            fromHome: true,
            fontSize: _fontSize,
            hymns: hymnDesktopSearch,
            onTap: (value) {
              onSearchResultSelected(value);
              Navigator.of(context).pop();
            },
          );
        }
    );
  }
}