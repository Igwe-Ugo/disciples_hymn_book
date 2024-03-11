import 'dart:async';
import 'widget.dart';
import 'common/widget.dart';
import 'package:flutter/material.dart';

class DiscipleshipHymnarySplashScreen extends StatefulWidget {
  const DiscipleshipHymnarySplashScreen({super.key});

  @override
  State<DiscipleshipHymnarySplashScreen> createState() => _DiscipleshipHymnarySplashScreenState();
}

class _DiscipleshipHymnarySplashScreenState extends State<DiscipleshipHymnarySplashScreen> {
  bool _isInvisible = false;

  _DiscipleshipHymnarySplashScreenState(){
    Timer(const Duration(seconds: 5), (){
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Responsive.isDesktop(context) ? const HomeScreenManager() : DiscipleshipHymnaryHome()), (route) => false);
      });
    });
    Timer(const Duration(milliseconds: 5), (){
      setState(() {
        _isInvisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Styles.defaultBlueColor,
            Styles.defaultSwatchColor,
          ],
          begin: FractionalOffset(0, 0),
          end: FractionalOffset(1.0, 0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity: _isInvisible? 1.0:0,
        duration: const Duration(milliseconds: 1200),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 140.0,
                width: 140.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Styles.defaultWhiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2.0,
                      offset: const Offset(5.0, 3.0),
                      spreadRadius: 2.0,
                    )
                  ]
                ),
                child: Center(
                  child: ClipOval(
                    child: Image.asset('assets/images/piano.jpeg', width: 100, height: 100,)
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                "Disciples'\nhymn book".toUpperCase(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Styles.defaultWhiteColor,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}