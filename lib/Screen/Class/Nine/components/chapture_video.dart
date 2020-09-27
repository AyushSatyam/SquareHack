import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ChaptureVideo extends StatelessWidget {
  YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: '7wtfhZwyrcc',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              progressColors: ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
            ),
            builder: (context, player) {
              return Column(
                children: [
                  player,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
