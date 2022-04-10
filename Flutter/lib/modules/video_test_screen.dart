// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// class VideoTestScreen extends StatelessWidget {
//   const VideoTestScreen({Key? key}) : super(key: key);
//
//   List createDataSet() {
//     List dataSourceList = <BetterPlayerDataSource>[];
//     dataSourceList.add(
//       BetterPlayerDataSource(
//         BetterPlayerDataSourceType.network,
//         "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
//       ),
//     );
//     dataSourceList.add(
//       BetterPlayerDataSource(BetterPlayerDataSourceType.network,
//           "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"),
//     );
//     dataSourceList.add(
//       BetterPlayerDataSource(BetterPlayerDataSourceType.network,
//           "http://sample.vodobox.com/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8"),
//     );
//     return dataSourceList;
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AspectRatio(
//         aspectRatio: 16 / 9,
//         child: BetterPlayerPlaylist(
//             betterPlayerConfiguration: BetterPlayerConfiguration(),
//             betterPlayerPlaylistConfiguration: const BetterPlayerPlaylistConfiguration(),
//             betterPlayerDataSourceList: ),
//       ),
//     );
//   }
// }

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:open_file/open_file.dart';

class TestOpening extends StatefulWidget {
  @override
  _TestOpeningState createState() => _TestOpeningState();
}

class _TestOpeningState extends State<TestOpening> {
  var _openResult = 'Unknown';

  Future<void> openFile() async {
    var filePath = r'/storage/emulated/0/update.apk';
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      filePath = result.files.single.path!;
    } else {
      // User canceled the picker
    }
    final _result = await OpenFile.open(filePath);
    print(_result.message);

    setState(() {
      _openResult = "type=${_result.type}  message=${_result.message}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('open result: $_openResult\n'),
              TextButton(
                child: Text('Tap to open file'),
                onPressed: openFile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}