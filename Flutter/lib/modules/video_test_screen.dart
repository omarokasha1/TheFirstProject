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
