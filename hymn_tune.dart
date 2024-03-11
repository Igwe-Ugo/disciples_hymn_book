import 'package:just_audio/just_audio.dart';
import 'common/widget.dart';
import 'package:flutter/material.dart';

class HymnTune extends StatefulWidget {
  final String hymnMusicPath;
  const HymnTune({super.key, required this.hymnMusicPath});

  @override
  // ignore: library_private_types_in_public_api
  _HymnTuneState createState() => _HymnTuneState();
}

class _HymnTuneState extends State<HymnTune>
    with SingleTickerProviderStateMixin {
  late AnimationController iconController;
  bool isAnimated = false;
  bool showPlayButton = true;
  bool showPauseButton = false;
  double iconSize = 30.0;
  AudioPlayer hymnTunePlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    loadMusic();
  }

  void loadMusic() async {
    if (mounted && widget.hymnMusicPath.isNotEmpty) {
      await hymnTunePlayer
          .setAudioSource(AudioSource.asset(widget.hymnMusicPath));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hymnMusicPath.isNotEmpty) {
      hymnTunePlayer.setAudioSource(AudioSource.asset(widget.hymnMusicPath));
    } else {
      hymnTunePlayer = AudioPlayer();
    }
    return FloatingActionButton(
      onPressed: () => animateIcon(),
      elevation: 10,
      backgroundColor: Styles.defaultBlueColor,
      tooltip: isAnimated != false ? 'Stop tune' : 'Listen to tune',
      foregroundColor: Colors.white,
      child: AnimatedIcon(
        icon: AnimatedIcons.play_pause,
        progress: iconController,
        size: iconSize,
        color: Colors.white,
      ),
    );
  }

  void animateIcon() async {
    if (widget.hymnMusicPath.isNotEmpty) {
      isAnimated = !isAnimated;
      if (isAnimated) {
        await iconController.forward();
        await hymnTunePlayer.play();
      } else {
        await iconController.reverse();
        await hymnTunePlayer.stop();
      }
      setState(() {});
    }
  }

  @override
  void dispose() async {
    super.dispose();
    await hymnTunePlayer.dispose();
    iconController.dispose();
  }
}
