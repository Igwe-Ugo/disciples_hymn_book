import 'dart:convert';
import 'common/widget.dart';
import 'models/models.dart';
import 'package:flutter/material.dart';

class PrefaceScreen extends StatefulWidget {
  const PrefaceScreen({super.key});
  @override
  State<PrefaceScreen> createState() => _PrefaceScreenState();
}

class _PrefaceScreenState extends State<PrefaceScreen> {
  final double _height = 60.0;
  late Future<List<PrefaceModel>> prefaceFuture;

  @override
  void initState(){
    super.initState();
    prefaceFuture = readPrefaceData(context);
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: !Responsive.isDesktop(context) ? AppBar(
        toolbarHeight: _height,
        title: Row(
          children: [
            CircleAvatar(
              radius: 15.0,
              backgroundColor: Colors.grey[200],
              backgroundImage: const AssetImage('assets/images/piano.jpeg'),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                'preamble'.toUpperCase(),
                style: const TextStyle(
                  letterSpacing: -1.2,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        elevation: 0.0,
        centerTitle: false,
      ) : null,
      drawer: DiscipleshipSideBar(),
      body: FutureBuilder(
        future: readPrefaceData(context),
        builder: (context, data){
          if (data.hasError){
            return Center(
              child: Text('${data.error}')
            );
          } else if (data.hasData){
            var prefaceItems = data.data as List<PrefaceModel>;
            return SingleChildScrollView(
              child: Card(
                elevation: 10,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(30),
                          child: Column(
                            children: [
                              for (var i in prefaceItems)
                              Text(
                                i.vision,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'preface'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w800,
                          color: Styles.defaultBlueColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      for (var i in prefaceItems)
                      Text(
                        i.preface,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 10,),
                      for (var i in prefaceItems)
                      Text(
                        i.auditor,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10,),
                      const Divider(thickness: 3, color: Styles.defaultBlueColor),
                      const SizedBox(height: 10),
                      Text(
                        'dedication'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w800,
                          color: Styles.defaultBlueColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      for (var i in prefaceItems)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(
                          i.dedication,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          }else {
            return const Center(
              child: CircularProgressIndicator(
                color: Styles.defaultBlueColor,
              ),
            );
          }
        }
      ),
    );
  }

  Future<List<PrefaceModel>> readPrefaceData(BuildContext context) async{
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/json/preface.json');
    final list = json.decode(data) as List<dynamic>;
    return list.map((e) => PrefaceModel.fromJson(e)).toList();
  }
}