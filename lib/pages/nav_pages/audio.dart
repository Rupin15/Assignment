import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class BarItemPage extends StatefulWidget {
  const BarItemPage({Key? key}) : super(key: key);

  @override
  State<BarItemPage> createState() => _BarItemPageState();
}

class _BarItemPageState extends State<BarItemPage> {
  final audioPlayer=AudioPlayer();
  bool isPlaying=false;
  Duration duration=Duration.zero;
  Duration position=Duration.zero;

  @override
  void initState() {
    setAudio();
    super.initState();
   try{

     audioPlayer.onPlayerStateChanged.listen((event) {
       if(mounted)
       setState(() {
         isPlaying=event==PlayerState.playing;
       });
     });

     audioPlayer.onDurationChanged.listen((event) {
       if(mounted)
       setState(() {
         duration=event;
       });
     });

     audioPlayer.onPositionChanged.listen((event) {
       if(mounted)
       setState(() {
         position=event;
       });
     });
   }catch(e){
      print(e);
    }

  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                "https://plus.unsplash.com/premium_photo-1669638665133-3fec4466ad43?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80",
              width: double.infinity,
              height: height*0.5,
              fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: height*0.05),
            Text("Sample Audio", style: TextStyle(fontSize: 20)),
            Slider(value: position.inSeconds.toDouble(),
                min:0,
                max:duration.inSeconds.toDouble(),
                onChanged: (value) async{
                final position=Duration(seconds: value.toInt());
                await audioPlayer.seek(position);
                await audioPlayer.resume();
                }),
            Padding(padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatTime(position)),
                Text(formatTime(duration-position))
      ],
            ),
            ),
            CircleAvatar(
              radius: height*0.05,
              child: IconButton(
                icon: Icon(
                  isPlaying?Icons.pause: Icons.play_arrow
                ),
                iconSize: 50,
                onPressed: () async{
                  if(isPlaying){
                    await audioPlayer.pause();
                  }else{
                 audioPlayer.resume();
                  }

                },

              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int m) => m.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours) ;
    final minutes = twoDigits(duration.inMinutes. remainder (60));
    final seconds = twoDigits(duration. inSeconds. remainder (60));
    return [
    if (duration.inHours > 0) hours,
    minutes,
    seconds,
    ].join(":");
  }

  Future setAudio() async{
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    AudioCache audioCache = AudioCache(prefix: 'assets/');
    final url = await audioCache.load('sample.mp3');
    await audioPlayer.setSourceAsset("sample.mp3");
  }
}
