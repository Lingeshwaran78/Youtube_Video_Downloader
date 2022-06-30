import 'package:flutter_youtube_downloader/flutter_youtube_downloader.dart';

class Download {
  late int resolution;
  Download({required this.resolution});
  Future<void> downloadVideo(String youTube_link, String title) async {
    final result = await FlutterYoutubeDownloader.downloadVideo(
        youTube_link, "$title", resolution);
    print(result);
  }
}
