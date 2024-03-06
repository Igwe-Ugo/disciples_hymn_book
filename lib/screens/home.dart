// ignore_for_file: must_be_immutable
import 'widget.dart';
import 'dart:convert';
import 'common/widget.dart';
import 'models/models.dart';
import 'package:flutter/material.dart';

class DiscipleshipHymnaryHome extends StatefulWidget {
  Function? changeScreen;
  DiscipleshipHymnaryHome({super.key, this.changeScreen});

  @override
  State<DiscipleshipHymnaryHome> createState() =>
      _DiscipleshipHymnaryHomeState();
}

class _DiscipleshipHymnaryHomeState extends State<DiscipleshipHymnaryHome> {
  final double _fontSize = 14.0;
  final double _height = 60.0;
  late Future<List<DiscipleshipHymnaryModel>> hymnFuture;
  List<DiscipleshipHymnaryModel>? selectHymn;
  String? selectedHymn;

  @override
  void initState() {
    super.initState();
    hymnFuture = readJsonData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              toolbarHeight: _height,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 15.0,
                    backgroundColor: Colors.grey[200],
                    backgroundImage:
                        const AssetImage('assets/images/piano.jpeg'),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      "disciples' hymn book".toUpperCase(),
                      style: const TextStyle(
                        letterSpacing: -1.2,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              elevation: 0.0,
              centerTitle: false,
              actions: [
                IconButton(
                    icon: const Icon(Icons.search),
                    iconSize: 20.0,
                    onPressed: () async {
                      showSearch(
                        context: context,
                        delegate: SearchHymnary(
                          allHymns: selectHymn!,
                          allHymnsSuggestion: selectHymn!,
                        ),
                      );
                    },
                    tooltip: 'Search hymnary'),
              ],
            )
          : null,
      drawer: DiscipleshipSideBar(),
      body: FutureBuilder(
          future: readJsonData(context),
          builder: (context, data) {
            if (data.hasError) {
              return Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.sms_failed_rounded,
                      color: Styles.defaultBlueColor,
                      size: 30,
                    ),
                    Text(
                      '${data.error}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            } else if (data.hasData) {
              var hymnItems = data.data as List<DiscipleshipHymnaryModel>;
              selectHymn = hymnItems.toList();
              return ListView.builder(
                  itemCount: hymnItems.length,
                  itemBuilder: (context, index) {
                    final hymns = hymnItems[index];
                    return selectedHymn == ""
                        ? Container()
                        : HymnCardMobile(hymns: hymns, fontSize: _fontSize);
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
          }),
    );
  }

  Future<List<DiscipleshipHymnaryModel>> readJsonData(
      BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data =
        await assetBundle.loadString('assets/json/discipleship_hymnary.json');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => DiscipleshipHymnaryModel.fromJson(e)).toList();
  }
}
