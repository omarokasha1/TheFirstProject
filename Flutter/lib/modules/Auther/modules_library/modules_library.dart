import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/modules/Auther/create_module/create_module_screen.dart';

import 'package:lms/shared/component/MyAppBar.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
import 'modules_library_cubit/cubit.dart';
import 'modules_library_cubit/status.dart';

class ModulesLibraryScreen extends StatelessWidget {
  const ModulesLibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ModulesLibraryCubit(),
      child: BlocConsumer<ModulesLibraryCubit, ModulesLibraryStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
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
                    SizedBox(height: 20.0,),
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildModuleItem(),
                        separatorBuilder: (context, index) => SizedBox(height: 10,),
                        shrinkWrap: true,
                        itemCount: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  //Build ModuleItem
  Widget buildModuleItem() {
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
          SizedBox(width: 20.0,),
          Expanded(
            child: Text(
              "File name asd afew werg  iuejh iujh iuvjh iuwjhuijv iujhuijh iuwhji uhwuivh iuwhu wiuhf uiwh ifuhwiushviu hsdfubifh iuhfbiughr siih iuv iusb bs ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 20.0,),
          CircleAvatar(
            backgroundColor: primaryColor,
            radius: 22.r,
            child: IconButton(
              onPressed: () {},
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
}