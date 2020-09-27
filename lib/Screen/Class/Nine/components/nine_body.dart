import 'package:flutter/material.dart';
import 'package:squarehack/Meeting/join_meeting.dart';
import 'package:squarehack/Personal_Details/personal_detail_screen.dart';

import 'package:squarehack/Screen/Class/Nine/components/nine_background.dart';
import 'package:squarehack/Screen/Home/home_screen.dart';
import 'package:squarehack/components/rounded_button.dart';
import 'package:squarehack/constants.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NineBody extends StatelessWidget {
  final String id;

  // YoutubePlayerController _controller = YoutubePlayerController(
  //     initialVideoId: '7wtfhZwyrcc',
  //     flags: YoutubePlayerFlags(
  //       autoPlay: true,
  //       mute: false,
  //     ));

  NineBody({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return NineBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.15,
            ),
            Text("This is Nine class page"),
            SizedBox(
              height: size.height * 0.25,
            ),
            // YoutubePlayerBuilder(
            //   player: YoutubePlayer(
            //     controller: _controller,
            //     showVideoProgressIndicator: true,
            //     progressIndicatorColor: Colors.blueAccent,
            //     progressColors: ProgressBarColors(
            //       playedColor: Colors.amber,
            //       handleColor: Colors.amberAccent,
            //     ),
            //   ),
            //   builder: (context, player) {
            //     return Column(
            //       children: [
            //         player,
            //       ],
            //     );
            //   },
            // ),
            RoundedButton(
              text: "Join a class",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return JoinMeetingApp();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "Home",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen(currentUserId: null,);
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "Perform CRUD on Firebase",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PersonalDetailScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
