import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/models/new/contents_model.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:open_file/open_file.dart';
import 'package:readmore/readmore.dart';

class ModuleDetailsScreen extends StatelessWidget {
  final Contents contentModel;
  ModuleDetailsScreen(this.contentModel, {Key? key}) : super(key: key);
  dynamic filePath;

  @override
  Widget build(BuildContext context) {
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
                    contentModel.contentTitle.toString(),
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
                  '${contentModel.description}',
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
                    "${contentModel.contentDuration}",
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

              InkWell(
                onTap: (){
                  OpenFile.open(contentModel.imageUrl.toString(),);
                },
                child: Text(
                  contentModel.imageUrl.toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
             // viewFileDetails(contentModel),
            ],

          ),
        ),
      ),
    );
  }
}

Widget viewFileDetails(contentModel) {
  final kb = contentModel.imageUrl.size / 1024;
  final mb = kb / 1024;
  final fileSize =
  mb > 1 ? "${mb.toStringAsFixed(2)} MB" : "${kb.toStringAsFixed(2)} Kb";
  dynamic filePath = contentModel.imageUrl;
  final extension = filePath.extension ?? "none";

  return Stack(
    children: [
      Container(
        padding: EdgeInsets.all(12),

        child: InkWell(
          onTap: () {
            OpenFile.open(filePath.path);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              // color: secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(
                  color: primaryColor,
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  filePath.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ".${filePath.extension}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "/ $fileSize",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      // Positioned(
      //   top: 0,
      //   right: 0,
      //   child: CircleAvatar(
      //     backgroundColor: secondaryColor,
      //     radius: 20.0,
      //     child: IconButton(
      //       icon: const Icon(
      //         Icons.edit,
      //       ),
      //       color: Colors.white,
      //       iconSize: 20.0,
      //       onPressed: () async {
      //         result = await FilePicker.platform.pickFiles();
      //
      //         if (result != null) {
      //           file = File(result!.files.single.path!);
      //           filePath = result!.files.first;
      //
      //           cubit.selectImage();
      //         }
      //       },
      //     ),
      //   ),
      // ),
    ],
  );
}

