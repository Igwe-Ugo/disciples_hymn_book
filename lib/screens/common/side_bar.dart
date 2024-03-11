// ignore_for_file: must_be_immutable

import '../widget.dart';
import 'widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DiscipleshipSideBar extends StatefulWidget {
  Function? changeScreenSideBar;
  DiscipleshipSideBar({super.key, this.changeScreenSideBar});

  @override
  State<DiscipleshipSideBar> createState() => _DiscipleshipSideBarState();
}

class _DiscipleshipSideBarState extends State<DiscipleshipSideBar> {
  @override
  Widget build(BuildContext context) {
    double drawerIconSize = 24;
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Styles.defaultBlueColor.withOpacity(0.2),
              Colors.white.withOpacity(0.5),
            ],
          ),
        ),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [Styles.defaultBlueColor, Colors.black45],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 45.0,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: const AssetImage(
                      "assets/images/piano.jpeg",
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "disciples' Hymn book".toUpperCase(),
                    style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            !Responsive.isDesktop(context)
                ? ListTile(
                    leading: Icon(Icons.home_outlined,
                        size: drawerIconSize, color: Styles.defaultBlueColor),
                    title: Text(
                      'home'.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 17, color: Styles.defaultBlueColor),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DiscipleshipHymnaryHome()));
                    },
                  )
                : const SizedBox.shrink(),
            ListTile(
              leading: Icon(Icons.info_outline,
                  size: drawerIconSize, color: Styles.defaultBlueColor),
              title: Text(
                'preface'.toUpperCase(),
                style: const TextStyle(
                    fontSize: 17, color: Styles.defaultBlueColor),
              ),
              onTap: () {
                !Responsive.isDesktop(context)
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrefaceScreen()))
                    : changePageController.jumpToPage(0);
              },
            ),
            ListTile(
              leading: Icon(Icons.perm_device_information_outlined,
                  size: drawerIconSize, color: Styles.defaultBlueColor),
              title: Text(
                'about'.toUpperCase(),
                style: const TextStyle(
                    fontSize: 17, color: Styles.defaultBlueColor),
              ),
              onTap: () {
                aboutDialog(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.wb_sunny_outlined,
                  size: drawerIconSize, color: Styles.defaultBlueColor),
              title: Text(
                'dark theme'.toUpperCase(),
                style: const TextStyle(
                    fontSize: 17, color: Styles.defaultBlueColor),
              ),
              trailing: Switch(
                value: themeChange.darkTheme,
                onChanged: (value) {
                  setState(() {
                    themeChange.darkTheme = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future aboutDialog(BuildContext context) {
    const String contactEmail = 'discipleshymn@gmail.com';
    final Uri urlForEmail = Uri.parse('mailto:$contactEmail');
    const String aboutUs = "A careful look at the music played in the Church now shows that the Church is in the wilderness. We are therefore committed to making sure that we bring back the glory of the church through hymns. We are asking that God may visit His saving grace upon our lives and grant us a revival that our land may enter into rest.\n\nIf you have any suggestions or wants to contact us, click the link below or contact us through telephone.\n\nGrace be with you.";
    return showDialog(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        insetPadding: const EdgeInsets.all(10.0),
        title: Text(
          'about'.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage("assets/images/piano.jpeg"),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Disciple's Hymn Book",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Version: 1.0.0',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  aboutUs,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  onTap: () async {
                    if (await canLaunchUrl(urlForEmail)) {
                      await launchUrl(urlForEmail);
                    } else {
                      debugPrint('Cant;');
                    }
                  },
                  leading: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Styles.defaultBlueColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 50,
                      minHeight: 50,
                    ),
                    child: const Icon(
                      Icons.email_rounded,
                      size: 20,
                    ),
                  ),
                  title: const Text(
                    'Email Address',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Styles.defaultBlueColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  subtitle: const Text(
                    contactEmail,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Styles.defaultBlueColor,
                    ),
                    child: Text(
                      'close'.toUpperCase(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
