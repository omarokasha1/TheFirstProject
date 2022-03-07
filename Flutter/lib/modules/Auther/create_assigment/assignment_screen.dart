import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/models/module_model.dart';
import 'package:lms/modules/Auther/create_assigment/cubit/cubit.dart';
import 'package:lms/modules/Auther/create_assigment/update_assignment.dart';
import 'package:lms/modules/Auther/create_module/cubit/cubit.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';
class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen(List<Contents> list, CreateModuleCubit cubit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CreateAssignmentCubit.get(context);
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildAssignmentItem(context, index, cubit.content[index], cubit),
          separatorBuilder: (context, index) => const SizedBox(height: 10,),
          shrinkWrap: true,
          itemCount: cubit.content!.length,
        ) ;
      },
    );
  }
}
Widget buildAssignmentItem(
    context,
    index,
    Contents model,
    CreateAssignmentCubit cubit,
    ) {
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
              navigator(context, UpdateAssignment(model));
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
              cubit.deleteAssignment(moduleId: model.sId!);
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
  );
}