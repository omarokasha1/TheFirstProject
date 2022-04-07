import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/models/assignment_model.dart';
import 'package:lms/models/new/contents_model.dart';
import 'package:lms/modules/Auther/modules/assignment_view.dart';
import 'package:lms/modules/Auther/modules/create_assigment/create_assignment.dart';
import 'package:lms/modules/Auther/modules/create_assigment/cubit/cubit.dart';
import 'package:lms/modules/Auther/modules/create_assigment/cubit/states.dart';
import 'package:lms/modules/Auther/modules/create_assigment/update_assignment.dart';
import 'package:lms/modules/Auther/modules/create_module/create_module_screen.dart';
import 'package:lms/modules/Auther/modules/create_module/cubit/cubit.dart';
import 'package:lms/modules/Auther/modules/create_module/cubit/states.dart';
import 'package:lms/modules/Auther/modules/create_module/update_module.dart';
import 'package:lms/modules/Auther/modules/module_view.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';


class ModulesLibraryScreen extends StatelessWidget {
  ModulesLibraryScreen({Key? key}) : super(key: key);

  final List<Widget> myTabs = [
    const Tab(text: 'Content'),
    const Tab(text: 'Assignment'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateAssignmentCubit, CreateAssignmentStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocProvider.value(
          value: BlocProvider.of<CreateModuleCubit>(context)
            ..getModulesData()
            ..list,
          child: BlocConsumer<CreateModuleCubit, CreateModuleStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = CreateModuleCubit.get(context);
              return Layout(
                widget: DefaultTabController(
                  length: myTabs.length,
                  child: Scaffold(
                    appBar: AppBar(),
                    body: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                            child: Row(
                              children: [
                                Text(
                                  'Modules Library',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const Spacer(),
                                    PopupMenuButton(
                                      elevation: 1,
                                      itemBuilder: (BuildContext context) => [
                                        PopupMenuItem(
                                          child: MaterialButton(
                                            onPressed: (){
                                              navigator(context, CreateModuleScreen());
                                            },
                                            child: const Text('Add Content'),
                                          ),
                                        
                                          value: 1,
                                        ),
                                        PopupMenuItem(
                                          child: MaterialButton(
                                            onPressed: (){
                                              navigator(context, CreateAssignmentScreen());
                                            },
                                            child: const Text('Add Assignment'),
                                          ),
                                          value: 2,

                                        ),
                                      ],
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: primaryColor,

                                    ),
                                    child: Row(
                                      children:const [
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                         Text('Create',style: TextStyle(color: Colors.white,fontSize: 18),),
                                      ],
                                    ),
                                  ),

                                  // Text(
                                  //   'Add Module',
                                  //   style: TextStyle(
                                  //     fontSize: 16.sp,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                ),
                              ],
                            ),
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
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: TabBarView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                //Contents
                                ConditionalBuilder(
                                  condition: cubit.getContent != null,
                                  builder: (context) => ConditionalBuilder(
                                    condition: cubit
                                        .getContent!.contents!.isNotEmpty,
                                    builder: (context) => buildContentTab(
                                        cubit.getContent!,
                                        cubit),
                                    fallback: (context) => Center(
                                      child: emptyPage(
                                          context: context,
                                          text: "no Modules Yet"),
                                    ),
                                  ),
                                  fallback: (context) => const Center(
                                    child:  CircularProgressIndicator(),
                                  ),
                                ),
                                //Assignments
                                ConditionalBuilder(
                                  condition:
                                      CreateAssignmentCubit.get(context).getModuleModel != null,
                                  builder: (context) => buildAssignmentTab(
                                      CreateAssignmentCubit.get(context)
                                          .getModuleModel!
                                          .assignments!,
                                      CreateAssignmentCubit.get(context)),
                                  fallback: (context) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
      onTap: () {
        navigator(context, ModuleDetailsScreen(model));
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        //height: 90.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow:  [
            BoxShadow(
              color: Colors.grey[300]!,
              offset: const Offset(0.6, 1.2), //(x,y)
              blurRadius: 6.0,
            ),
          ],
          color: Colors.white,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children: [
            const SizedBox(
              width: 20.0,
            ),
            Text(
              model.contentTitle!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            const Spacer(),

            CircleAvatar(
              backgroundColor: primaryColor,
              radius: 18.r,
              child: IconButton(
                onPressed: () {
                  navigator(context, UpdateModule(model));
                },
                icon: const Icon(
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
                  cubit.deleteModule(moduleId: model.sId!);
                },
                icon: const Icon(
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

  Widget buildContentTab(ContentsModel contents, cubit) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) =>
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
            child: buildModuleItem(context, index, contents.contents![index], cubit),
          ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 0,
      ),
      shrinkWrap: true,
      itemCount: contents.contents!.length,
    );
  }

  Widget buildAssignmentItem(
    context,
    index,
    Assignments model,
    CreateAssignmentCubit cubit,
  ) {
    return InkWell(
      onTap: () {
        navigator(context, AssignmentDetailsScreen(model));
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow:  [
            BoxShadow(
              color: Colors.grey[300]!,
              offset: const Offset(0.6, 1.2), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        color: Colors.white,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children: [
            SizedBox(
              width: 10.w,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.assignmentTitle}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          // PopupMenuButton(
          //   elevation: 1,
          //   itemBuilder: (BuildContext context) => [
          //     PopupMenuItem(
          //       child: TextButton.icon(onPressed: (){
          //         navigator(context, UpdateAssignment(model));
          //       }, icon:Icon(Icons.edit) , label: Text('Edit')),
          //       onTap: (){
          //         navigator(context, UpdateAssignment(model));
          //       },
          //       value: 1,
          //     ),
          //     PopupMenuItem(
          //       child: TextButton.icon(onPressed: (){
          //         cubit.deleteAssignment(moduleId: model.sId!);
          //       }, icon:Icon(Icons.delete,color: Colors.red,) , label: Text('Delete',style: TextStyle(color: Colors.red),)),
          //       value: 2,
          //
          //     ),
          //     PopupMenuItem(
          //       child: TextButton.icon(onPressed: (){}, icon:Icon(Icons.download,color: Colors.green,) , label: Text('Download',style: TextStyle(color: Colors.green),)),
          //       value: 3,
          //     ),
          //   ],
          // ),
            CircleAvatar(
              backgroundColor: primaryColor,
              radius: 18.r,
              child: IconButton(
                onPressed: () {
                  navigator(context, UpdateAssignment(model));
                },
                icon: const Icon(
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
                icon: const Icon(
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
      itemBuilder: (context, index) =>
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
            child: buildAssignmentItem(context, index, assignment[index], cubit),
          ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 0,
      ),
      shrinkWrap: true,
      itemCount: assignment.length,
    );
  }
}
