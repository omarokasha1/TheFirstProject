import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/models/new/contents_model.dart';
import 'package:lms/modules/Auther/modules/create_module/cubit/cubit.dart';
import 'package:lms/modules/Auther/modules/create_module/cubit/states.dart';
import 'package:lms/modules/Auther/modules/pdf_view_screen.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:open_file/open_file.dart';
import 'package:readmore/readmore.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../models/new/courses_model.dart';
import '../../../shared/component/component.dart';

class ContentViewScreen extends StatefulWidget {
  final Contents contentModel;
  ContentViewScreen(this.contentModel, {Key? key}) : super(key: key);

  @override
  State<ContentViewScreen> createState() => _ContentViewScreenState();
}
class _ContentViewScreenState extends State<ContentViewScreen> {
  BetterPlayerController? betterPlayerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      "${widget.contentModel.imageUrl}",
      notificationConfiguration: BetterPlayerNotificationConfiguration(
        showNotification: true,
        title: "${widget.contentModel.contentTitle}",
        author: "${widget.contentModel.author!}",
        imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/Orange_logo.svg/1200px-Orange_logo.svg.png",
        activityName: "MainActivity",
      ),
    );
    betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource
    );

  }
  dynamic filePath;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateModuleCubit,CreateModuleStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Layout(
          widget: Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.file_copy_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.contentModel.contentTitle.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          //color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Description:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ReadMoreText(
                      //'I’m excited to announce the launch of my updated and improved Prime Sport and Prime Ski Racing online courses for athletes (ski racers), coaches, and parents. These courses offer the same information that I use with the professional and Olympic athletes, coaches, and parents I work with all over the world in a structured, engaging, and affordable format.',
                      '${widget.contentModel.description}',
                      trimLines: 3,
                      colorClickableText: Colors.black,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      moreStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                      lessStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children:  [
                      const Text(
                        "Duration : ",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "${widget.contentModel.contentDuration}",
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Content :',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),


                  if(widget.contentModel.imageUrl!.split('\.').last == 'jpg' || widget.contentModel.imageUrl!.split('\.').last == 'png' )
                    Container(
                      width: double.infinity,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: imageFromNetwork(
                          url: '${widget.contentModel.imageUrl}',
                        ),
                      ),
                    ),
                  if(widget.contentModel.imageUrl!.split('\.').last == 'mp4' )
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: BetterPlayer(
                        controller: betterPlayerController!,
                      ),
                    ),
                  if (widget.contentModel.imageUrl!.split('\.').last == 'pdf')
                    Row(
                      children: [
                        // Expanded(
                        //   child: Container(
                        //     padding: const EdgeInsets.all(10),
                        //     margin: const EdgeInsets.all(5),
                        //     decoration: BoxDecoration(
                        //         color: primaryColor,
                        //         borderRadius: BorderRadius.circular(10)),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: const [
                        //         Icon(
                        //           Icons.download,
                        //           color: Colors.white,
                        //         ),
                        //         SizedBox(
                        //           width: 10,
                        //         ),
                        //         Text(
                        //           'Download',
                        //           style: TextStyle(color: Colors.white),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              navigator(context, PdfViewScreen( fileUrl: widget.contentModel.imageUrl.toString(),));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'View',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  // viewFileDetails(contentModel),
                ],

              ),
            ),
          ),
        );
      },
    );
  }
}


