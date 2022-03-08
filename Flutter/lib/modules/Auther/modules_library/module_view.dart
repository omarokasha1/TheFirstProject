
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/shared/component/constants.dart';
import 'package:readmore/readmore.dart';

class ModuleDetailsScreen extends StatelessWidget {
  ModuleDetailsScreen({Key? key}) : super(key: key);

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
                Row(children: [
                  Icon(Icons.file_copy_outlined),
                  SizedBox(width: 10,),
                  Text(
                    'File Name',maxLines: 2,overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      //color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Description:',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ReadMoreText(
                    'I’m excited to announce the launch of my updated and improved Prime Sport and Prime Ski Racing online courses for athletes (ski racers), coaches, and parents. These courses offer the same information that I use with the professional and Olympic athletes, coaches, and parents I work with all over the world in a structured, engaging, and affordable format.',
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
                    Text("Duration : ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),
                    ),
                    Text("7 hr",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                    )
                  ],),
                SizedBox(height: 15,),
                Text(
                  'Content :',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),
                ),



              ],
            ),
        ),
      ),
    );
  }
}
