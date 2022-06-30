import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../downloader.dart';

class BrowserPage extends StatefulWidget {
  const BrowserPage({Key? key}) : super(key: key);

  @override
  State<BrowserPage> createState() => _BrowserPageState();
}

class _BrowserPageState extends State<BrowserPage> {
  List<int> resolutions = [
    18, //360p
    83, //480p
    22, //720p
    37 //1080p
  ];
  List resolutionText = ['360p', '480p', '720p', '1080p'];
  final link = "https://www.youtube.com";
  WebViewController? _controller;
  bool _showDownloadButton = false;
  void checkUrl() async {
    if (await _controller!.currentUrl() == "https://m.youtube.com/") {
      setState(() {
        _showDownloadButton = false;
      });
    } else {
      setState(() {
        _showDownloadButton = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    checkUrl();
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (await _controller!.canGoBack()) {
            _controller!.goBack();
          }
          return false;
        },
        child: Scaffold(
          body: WebView(
            initialUrl: link,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              setState(() {
                _controller = controller;
              });
            },
          ),
          floatingActionButton: _showDownloadButton == false
              ? Container()
              : FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: () async {
                    Resolution();
                  },
                  child: Icon(Icons.download),
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
                          onPressed: () async {
                            final url = await _controller!.currentUrl();
                            final title = await _controller!.getTitle();
                            Download(resolution: resolutions[index])
                                .downloadVideo(url!, "$title.mp4");
                            Navigator.pop(context);
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
