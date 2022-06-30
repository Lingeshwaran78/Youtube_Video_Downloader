import 'package:flutter/material.dart';
import 'package:youtube_video_download/downloader.dart';
import 'dart:math';

class PasteLinkPage extends StatefulWidget {
  const PasteLinkPage({Key? key}) : super(key: key);

  @override
  State<PasteLinkPage> createState() => _PasteLinkPageState();
}

class _PasteLinkPageState extends State<PasteLinkPage> {
  final TextEditingController _textController = TextEditingController();
  List<int> resolutions = [
    18, //360p
    83, //480p
    22, //720p
    37 //1080p
  ];
  List<Color> colormain = [
    Colors.teal,
    Colors.deepPurple.shade600,
    Colors.pinkAccent,
    Colors.yellow
  ];
  int selectedcolor = 3;
  List resolutionText = ['360p', '480p', '720p', '1080p'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black38,
            leading: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedcolor = Random().nextInt(4) + 0;
                  });
                },
                child: Icon(Icons.update)),
            title: const Text('Worm Hole'),
            centerTitle: true),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _textController,
                decoration: const InputDecoration(
                    labelText: 'Paste Youtube Video Link'),
              ),
              GestureDetector(
                onTap: () {
                  if (_textController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No Link is Pasted')));
                  } else {
                    Resolution();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colormain[selectedcolor]),
                  child: const Center(
                    child: Text(
                      'Download Video',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Resolution() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Resolutions'),
            actions: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 300,
                width: 300,
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (BuildContext, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.black),
                          onPressed: () {
                            Download(resolution: resolutions[index])
                                .downloadVideo(
                                    _textController.text.trim(), 'yosabi.');
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Center(child: Text(resolutionText[index])),
                          ),
                        ),
                      );
                    }),
              )
            ],
          );
        });
  }
}
