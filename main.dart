import 'screens/widget.dart';
import 'screens/common/widget.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(const DiscipleshipHymnary());
}

class DiscipleshipHymnary extends StatefulWidget{
  const DiscipleshipHymnary({super.key});

  @override
  State<DiscipleshipHymnary> createState() => _DiscipleshipHymnaryState();
}

class _DiscipleshipHymnaryState extends State<DiscipleshipHymnary>{
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState(){
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async{
    themeChangeProvider.darkTheme = await themeChangeProvider.discipleshipHymnaryPreferences.getTheme();
  }

  @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_){
            return themeChangeProvider;
          },
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeData, child){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Discipleship Hymnary',
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: const DiscipleshipHymnarySplashScreen(),
          );
        }
      ),
    );
  }
}
