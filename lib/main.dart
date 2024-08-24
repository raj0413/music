import 'package:flutter/material.dart';
import 'package:music/model/provider.dart';
import 'package:music/screens/music.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MusicProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlaylistScreen(),
    );
  }
}

class PlaylistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);

    return Scaffold(backgroundColor: const Color.fromARGB(255, 235, 194, 194) ,
      appBar: AppBar(
    backgroundColor: const Color.fromARGB(255, 235, 194, 194) ,
        
        title: Text('Music Playlist'),
      ),
      body: Padding(
        
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: musicProvider.musicList.length,
          itemBuilder: (context, index) {
            final music = musicProvider.musicList[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 230, 158, 158),
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: Image.asset(music.albumImage),
                title: Text(music.albumName),
                subtitle: Text(music.albumArtist),
                onTap: () {
                  musicProvider.setCurrentMusic(music);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MusicPlayerScreen(),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
