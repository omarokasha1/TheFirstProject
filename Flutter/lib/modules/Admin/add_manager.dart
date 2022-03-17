import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/modules/Admin/cubit/cubit.dart';
import 'package:lms/modules/Admin/cubit/states.dart';
import 'package:lms/shared/component/MyAppBar.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';

class AddManager extends StatelessWidget {
  AddManager({Key? key}) : super(key: key);

  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManagerCubit(),
      child: BlocConsumer<ManagerCubit,ManagerStates>(
        listener: (context, state) {},
        builder: (context, state) {
        var cubit = ManagerCubit.get(context);
    return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: myAppBar(context),
          body: Layout(
            widget: Padding(
              padding: EdgeInsets.all(10.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: TextFormField(
                      controller: searchController,
                      cursorColor: primaryColor,
                      decoration: const InputDecoration(
                        fillColor: primaryColor,
                        iconColor: primaryColor,
                        border: InputBorder.none,
                        hintText: "Search Users",
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: primaryColor,
                        ),
                        prefixIconColor: primaryColor,
                      ),
                      onChanged: (value) {
                        //call database to get Search
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),

                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey[100],
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [

                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            'https://img-c.udemycdn.com/user/200_H/317821_3cb5_10.jpg'),
                                        radius: 18,
                                      ),
                                      SizedBox(
                                        width: 10,),
                                      Container(
                                        width: 100.w,
                                        child: Text(
                                          'User Name',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Spacer(),
                                      ElevatedButton(style:ElevatedButton.styleFrom(primary: cubit.flag ? primaryColor : Colors.green,) ,onPressed: (){
                                        AwesomeDialog(
                                          context: context,
                                          animType: AnimType.SCALE,
                                          dialogType: DialogType.NO_HEADER,
                                          body: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Form(
                                                //  key: formkey,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Are you sure you want #Name become a Manager ?',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Container(
                                                      height: 40,
                                                      child: defaultButton(
                                                        text: cubit.flag?'Request':'Unrequested',
                                                        onPressed: () {
                                                          cubit.changeButton();
                                                          Navigator.pop(context);
                                                          },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          title: 'This is Ignored',
                                          desc: 'This is also Ignored',
                                          //   btnOkOnPress: () {},
                                        ).show();
                                      },
                                        child: Text(cubit.flag? "Send Request":"Requested"),),

                                    ],),


                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      itemCount: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );}
      ),
    );
  }
}
// Widget buildUserData(context) => Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: Container(
//     padding: EdgeInsets.all(0),
//     width: double.infinity,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(8.0),
//       color: Colors.grey[100],
//     ),
//     clipBehavior: Clip.antiAliasWithSaveLayer,
//     child: Row(
//       children: [
//
//         SizedBox(
//           width: 10.w,
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 10.h,
//               ),
//               Row(children: [
//                 CircleAvatar(
//                   backgroundImage: NetworkImage(
//                       'https://img-c.udemycdn.com/user/200_H/317821_3cb5_10.jpg'),
//                   radius: 18,
//                 ),
//                 SizedBox(
//                   width: 10,),
//                 Container(
//                   width: 100.w,
//                   child: Text(
//                     'User Name',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 15.sp,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                   ),
//                 ),
//                 Spacer(),
//                 ElevatedButton(style:ElevatedButton.styleFrom(primary: primaryColor,) ,onPressed: (){
//                   AwesomeDialog(
//                     context: context,
//                     animType: AnimType.SCALE,
//                     dialogType: DialogType.QUESTION,
//                     body: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Form(
//                         //  key: formkey,
//                           child: Column(
//                             children: [
//                               Text(
//                                 'Are you sure you want #Name become a Manager ?',
//                                 style: TextStyle(
//                                     fontStyle: FontStyle.italic),
//                               ),
//                               SizedBox(
//                                 height: 30,
//                               ),
//                               Container(
//                                 height: 40,
//                                 child: defaultButton(
//                                   text: 'OK',
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     title: 'This is Ignored',
//                     desc: 'This is also Ignored',
//                     //   btnOkOnPress: () {},
//                   ).show();
//                 },
//                   child: Text("Send Request"),),
//
//               ],),
//
//
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// );
//

