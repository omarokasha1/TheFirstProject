import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/modules/Auther/create_module/create_module_screen.dart';

import 'package:lms/shared/component/MyAppBar.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';

import '../../../models/module_model.dart';
import '../create_module/cubit/cubit.dart';
import '../create_module/cubit/states.dart';
class ModulesLibraryScreen extends StatelessWidget {
  ModulesLibraryScreen({Key? key}) : super(key: key);

  final List<Widget> myTabs = [
    Tab(text: 'Content'),
    Tab(text: 'Assignment'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateModuleCubit()..getModulesData(),
      child: BlocConsumer<CreateModuleCubit, CreateModuleStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CreateModuleCubit.get(context);
          return Layout(
            widget: DefaultTabController(
              length: myTabs.length,
              child: Scaffold(
                appBar: myAppBar(context),
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
                         // isScrollable: true,
                          tabs: myTabs,
                          labelStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Expanded(
                          child: TabBarView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              ConditionalBuilder(
                                condition: cubit.getModuleModel!=null,
                                builder: (context)=> buildContentTab(cubit.getModuleModel!.contents!),
                                fallback: (context)=>Center(child: CircularProgressIndicator(),),

                              ),
                              ConditionalBuilder(
                                condition: cubit.getModuleModel!=null,
                                builder: (context)=> buildContentTab(cubit.getModuleModel!.contents!),
                                fallback: (context)=>Center(child: CircularProgressIndicator(),),

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
  }

  //Build ModuleItem
  Widget buildModuleItem(context,index,Contents model) {
    return Container(
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
                navigator(context, CreateModuleScreen());
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
              onPressed: () {},
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
    );
  }

  Widget buildContentTab(List<Contents> content) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildModuleItem(context,index,content[index]),
      separatorBuilder: (context, index) => SizedBox(
        height: 10,
      ),
      shrinkWrap: true,
      itemCount: content.length,
    );
  }
}
