import 'package:flutter/material.dart';
import 'package:melodify/components/neu_box.dart';
import 'package:melodify/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  //convert duration into min:sec
  String formatTime(Duration duration){
    String twoDigitSeconds =duration.inSeconds.remainder(60).toString().padLeft(2,'0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        //get playlist
        final playlist = value.playlist;

        //get current song index
        final currentSong = playlist[value.currentSongIndex ?? 0];

        //return scaffold UI
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
              child: Column(
                children: [
                  //app bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //back button
                      IconButton(
                          onPressed: () {
                            return Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),

                      //title
                      const Text("P L A Y L I S T"),

                      //menu button
                      IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //album artwork
                  NeuBox(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Column(
                            children: [
                              Image.asset(currentSong.albumArtImagePath),
                              //Song and artist name and icon
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //song and artist name
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currentSong.songName,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          currentSong.artistName,
                                          style: const TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),

                                    //heart icon
                                    const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ))),

                  //song duration progress
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //start time
                            Text(formatTime(value.currentDuration)),

                            //shuffle icon
                            const Icon(Icons.shuffle),

                            // repeat icon
                            const Icon(Icons.repeat),

                            //end time
                            Text(formatTime(value.totalDuration)),
                          ],
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 0,
                          )),
                          child: Slider(
                            min: 0,
                            max: value.totalDuration.inSeconds.toDouble(),
                            value: value.currentDuration.inSeconds.toDouble(),
                            activeColor: Colors.green,
                            onChanged: (double double) {
                              //during when the user is sliding around
                            },
                            onChangeEnd: (double double) {
                              //sliding has finished ,go to that position in song duration
                              value.seek(Duration(seconds: double.toInt()));
                            },
                          ),
                        )
                      ],
                    ),
                  ),

                  //playback controls
                  Row(
                    children: [
                      //skip backward
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                              onTap: value.playPreviousSong,
                              child: const NeuBox(
                                  child: Icon(Icons.skip_previous)))),

                      const SizedBox(
                        width: 20,
                      ),

                      //pause button
                      Expanded(
                          flex: 2,
                          child: GestureDetector(
                              onTap: value.pauseOrResume,
                              child: NeuBox(
                                child: Icon(value.isPlaying ?Icons.pause: Icons.play_arrow),
                              ),
                          ),
                      ),

                      const SizedBox(
                        width: 20,
                      ),

                      //skip forward
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                              onTap: value.playNextSong,
                              child:
                                  const NeuBox(child: Icon(Icons.skip_next)))),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
