import 'widget.dart';
import 'dart:convert';
import 'common/widget.dart';
import 'models/models.dart';
import 'package:flutter/material.dart';

late PageController changePageController;

class HomeScreenManager extends StatefulWidget {
  const HomeScreenManager({
    super.key,
  });

  @override
  State<HomeScreenManager> createState() => _HomeScreenManagerState();
}

class _HomeScreenManagerState extends State<HomeScreenManager> {
  int screenIndex = 0;
  final double _height = 60.0;
  bool isDesktopSearch = false;
  final double _desktopFontSize = 14.0;
  List<DiscipleshipHymnaryModel>? desktopHymnFuture;
  int hymnIndex = 0;
  int? selectedSearchResult;

  @override
  void initState() {
    super.initState();
    changePageController = PageController();
    desktopReadJsonData(context).then(
      (value) {
        desktopHymnFuture = value;
        setState(() {});
      },
    );
  }

  void updateHymn(int value) {
    setState(() {
      hymnIndex = value - 1;
    });
    changePageController.jumpToPage(1);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isDesktop(context)
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
                    if (desktopHymnFuture != null) {
                      final selected = await showSearch(
                        context: context,
                        delegate: SearchDesktop(
                          allHymnsDesktop: desktopHymnFuture!,
                          allHymnsDesktopSuggestion: desktopHymnFuture!,
                          onSearchResultSelected: updateHymn, // Pass the updateHymn function
                        ),
                      );
                      // Do something with selected search result if needed
                      if (selected != null){
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.32,
                          child: ListView.builder(
                            itemCount: desktopHymnFuture!.length,
                            itemBuilder: (context, desktopIndex) {
                              final desktopHymns = desktopHymnFuture![desktopIndex];
                              return HymnCard(
                                hymns: desktopHymns,
                                fontSize: _desktopFontSize,
                                fromHome: true,
                                onTap: (value) {
                                  updateHymn(value);
                                },
                              );
                            },
                          ),
                        );
                      }
                    }
                  },
                  tooltip: 'Search hymnary',
                ),
              ],
            )
          : null,
      body: Responsive.isDesktop(context)
          ? Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.22,
                  child: DiscipleshipSideBar(),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.005),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: PageView(
                    controller: changePageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const PrefaceScreen(),
                      if (desktopHymnFuture != null)
                        HymnDialog(
                          hymnaryModel: desktopHymnFuture![hymnIndex],
                        )
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.005),
                if (desktopHymnFuture != null)
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.32,
                    child: ListView.builder(
                      itemCount: desktopHymnFuture!.length,
                      itemBuilder: (context, desktopIndex) {
                        final desktopHymns = desktopHymnFuture![desktopIndex];
                        return HymnCard(
                          hymns: desktopHymns,
                          fontSize: _desktopFontSize,
                          fromHome: true,
                          onTap: (value) {
                            updateHymn(value);
                          },
                        );
                      },
                    ),
                  )
                else
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                const SizedBox.shrink(),
              ],
            )
          : DiscipleshipHymnaryHome(),
    );
  }

  Future<List<DiscipleshipHymnaryModel>> desktopReadJsonData(
      BuildContext context) async {
    final desktopAssetBundle = DefaultAssetBundle.of(context);
    final desktopData = await desktopAssetBundle.loadString('assets/json/discipleship_hymnary.json');
    final desktopList = json.decode(desktopData) as List<dynamic>;
    return desktopList.map((jsonItems) => DiscipleshipHymnaryModel.fromJson(jsonItems)).toList();
  }

  @override
  void dispose() {
    super.dispose();
    changePageController.dispose();
  }
}
