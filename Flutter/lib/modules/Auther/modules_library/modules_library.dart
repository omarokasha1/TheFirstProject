import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/models/assignment_model.dart';
import 'package:lms/modules/Auther/create_assigment/assignment_screen.dart';
import 'package:lms/modules/Auther/create_assigment/create_assignment.dart';
import 'package:lms/modules/Auther/create_assigment/cubit/cubit.dart';
import 'package:lms/modules/Auther/create_assigment/cubit/states.dart';
import 'package:lms/modules/Auther/create_assigment/update_assignment.dart';
import 'package:lms/modules/Auther/create_module/create_module_screen.dart';
import 'package:lms/modules/Auther/create_module/update_module.dart';
import 'package:lms/modules/Auther/modules_library/assignment_view.dart';
import 'package:lms/modules/Auther/modules_library/module_view.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import '../../../models/module_model.dart';
import '../create_module/cubit/cubit.dart';
import '../create_module/cubit/states.dart';

class ModulesLibraryScreen extends StatelessWidget {
  ModulesLibraryScreen({Key? key}) : super(key: key);

  final List<Widget> myTabs = [
    const Tab(text: 'Content'),
    const Tab(text: 'Assignment'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateAssignmentCubit,CreateAssignmentStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocProvider.value(
          value: BlocProvider.of<CreateModuleCubit>(context)..getModulesData()..list,
          child: BlocConsumer<CreateModuleCubit, CreateModuleStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = CreateModuleCubit.get(context);
              return Layout(
                widget: DefaultTabController(
                  length: myTabs.length,
                  child: Scaffold(
                    floatingActionButton: SpeedDial(
                      icon: Icons.add,
                      children: [
                        SpeedDialChild(
                            child: Icon(Icons.post_add),
                            label: 'Add Assignment',
                            onTap: () {
                              navigator(context, CreateAssignmentScreen());
                            }),
                        SpeedDialChild(
                            child: Icon(Icons.play_circle_fill),
                            label: 'Add Modules',
                            onTap: () {
                              navigator(context, CreateModuleScreen());
                            }),
                      ],
                    ),
                    appBar: AppBar(),
                    body: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Modules Library',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    navigator(context, CreateModuleScreen());
                                  },
                                  child: Text(
                                    'New Module',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TabBar(
                              labelColor: primaryColor,
                              indicatorColor: primaryColor,
                              unselectedLabelColor: Colors.black,
                              tabs: myTabs,
                              labelStyle: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: TabBarView(
                                physics: BouncingScrollPhysics(),
                                children: [
                                  ConditionalBuilder(
                                    condition: cubit.getModuleModel != null,
                                    builder: (context) => ConditionalBuilder(
                                      condition: cubit.getModuleModel!.contents!.isNotEmpty,
                                      builder: (context) => buildContentTab(cubit.getModuleModel!.contents!, cubit),
                                      fallback: (context) => Center(child: emptyPage(context: context, text: "no Modules Yet"),
                                      ),
                                    ),
                                    fallback: (context) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  ConditionalBuilder(
                                    condition: CreateAssignmentCubit.get(context).getModuleModel != null,
                                    builder: (context) => buildAssignmentTab(CreateAssignmentCubit.get(context).getModuleModel!.assignments!, CreateAssignmentCubit.get(context)),
                                    fallback: (context) => Center(child: CircularProgressIndicator(),),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },

    );
  }

  //Build ModuleItem
  Widget buildModuleItem(
    context,
    index,
    Contents model,
    CreateModuleCubit cubit,
  ) {
    return InkWell(
     onTap: (){
       navigator(context,ModuleDetailsScreen(model));
     },
      child: Container(
        width: double.infinity,
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.grey[100],
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children: [
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Text(
                //  "File name asd afew werg  iuejh iujh iuvjh iuwjhuijv iujhuijh iuwhji uhwuivh iuwhu wiuhf uiwh ifuhwiushviu hsdfubifh iuhfbiughr siih iuv iusb bs ",
                model.contentTitle!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            CircleAvatar(
              backgroundColor: primaryColor,
              radius: 22.r,
              child: IconButton(
                onPressed: () {
                  navigator(context, UpdateModule(model));
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            CircleAvatar(
              backgroundColor: Colors.red,
              radius: 22.r,
              child: IconButton(
                onPressed: () {
                  cubit.deleteModule(moduleId: model.sId!);
                },
                icon: Icon(
                  Icons.delete_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
        ),
      ),
    );
  }
  Widget buildContentTab(List<Contents> content, cubit) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildModuleItem(context, index, content[index], cubit),
      separatorBuilder: (context, index) => const SizedBox(height: 10,),
      shrinkWrap: true,
      itemCount: content.length,
    );
  }

  Widget buildAssignmentItem(
      context,
      index,
      Assignments model,
      CreateAssignmentCubit cubit,
      ) {
    return InkWell(
      onTap: ()
      {
        navigator(context,AssignmentDetailsScreen(model));

      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.grey[100],
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children: [
            Image.network('https://cdn-icons-png.flaticon.com/512/337/337946.png',width: 55,height: 55,),
            SizedBox(
              width: 10.w,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //  "File name asd afew werg  iuejh iujh iuvjh iuwjhuijv iujhuijh iuwhji uhwuivh iuwhu wiuhf uiwh ifuhwiushviu hsdfubifh iuhfbiughr siih iuv iusb bs ",
                      '${model.assignmentTitle}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      //  "File name asd afew werg  iuejh iujh iuvjh iuwjhuijv iujhuijh iuwhji uhwuivh iuwhu wiuhf uiwh ifuhwiushviu hsdfubifh iuhfbiughr siih iuv iusb bs ",
                      '${model.assignmentDuration}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      //  "File name asd afew werg  iuejh iujh iuvjh iuwjhuijv iujhuijh iuwhji uhwuivh iuwhu wiuhf uiwh ifuhwiushviu hsdfubifh iuhfbiughr siih iuv iusb bs ",
                      '15 MB',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            CircleAvatar(
              backgroundColor: primaryColor,
              radius: 18.r,
              child: IconButton(
                onPressed: () {
                  navigator(context, UpdateAssignment(model));
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            CircleAvatar(
              backgroundColor: Colors.red,
              radius: 18.r,
              child: IconButton(
                onPressed: () {
                  cubit.deleteAssignment(moduleId: model.sId!);
                },
                icon: Icon(
                  Icons.delete_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
        ),
      ),
    );
  }
  Widget buildAssignmentTab(List<Assignments> assignment, cubit) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildAssignmentItem(context, index, assignment[index], cubit),
      separatorBuilder: (context, index) => const SizedBox(height: 10,),
      shrinkWrap: true,
      itemCount: assignment.length,
    );
  }

}
