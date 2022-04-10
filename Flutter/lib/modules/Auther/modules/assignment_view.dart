import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/models/assignment_model.dart';
import 'package:lms/models/module_model.dart';
import 'package:lms/modules/Auther/modules/pdf_view_screen.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:open_file/open_file.dart';
import 'package:readmore/readmore.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../shared/component/component.dart';

class AssignmentDetailsScreen extends StatelessWidget {
  final Assignments model;

  AssignmentDetailsScreen(this.model, {Key? key}) : super(key: key);
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
                    model.assignmentTitle.toString(),
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
                  '${model.description}',
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
                children: [
                  const Text(
                    "Duration : ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "${model.assignmentDuration}",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
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
              const SizedBox(
                height: 15,
              ),
              if (model.fileUrl!.split('\.').last == 'jpg' ||
                  model.fileUrl!.split('\.').last == 'png')
                Container(
                  width: double.infinity,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: imageFromNetwork(
                      url: '${model.fileUrl}',
                    ),
                  ),
                ),
              if (model.fileUrl!.split('\.').last == 'pdf')

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
                        navigator(context, PdfViewScreen( fileUrl: model.fileUrl.toString(),));
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
              // InkWell(
              //   onTap: (){
              //     OpenFile.open(model.fileUrl,);
              //   },
              //   child: Text(
              //     model.fileUrl.toString(),
              //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              //   ),
              // ),

              // viewFileDetails(),
            ],
          ),
        ),
      ),
    );
  }
}
