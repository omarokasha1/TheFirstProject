import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/layout/layout.dart';
import 'package:lms/models/author_manger_request.dart';
import 'package:lms/modules/Auther/author_profile/author_profile_screen.dart';
import 'package:lms/modules/admin/cubit/cubit.dart';
import 'package:lms/modules/admin/cubit/states.dart';
import 'package:lms/shared/component/component.dart';
import 'package:lms/shared/component/constants.dart';

class AddManager extends StatelessWidget {
  AddManager({Key? key}) : super(key: key);

  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AdminCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              title: Text(
                'Add Manager',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
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
                          cubit.searchManager(value);
                        },
                      ),
                    ),
                    Expanded(
                      child: ConditionalBuilder(
                        condition: cubit.authorsManagerRequest != null,
                        builder: (context) {
                          return cubit.search.length == 0
                              ? emptyPage(
                                  text: 'There\'s Noe Search like This',
                                  context: context)
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      buildUserData(
                                          context, cubit.search[index]!, cubit),
                                  itemCount: cubit.search.length,
                                );
                        },
                        fallback: (context) {
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

Widget buildUserData(context, Users user, AdminCubit cubit) => InkWell(
      onTap: () {
        navigator(context, AuthorProfileScreen(user.sId!));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey[100],
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          //'https://img-c.udemycdn.com/user/200_H/317821_3cb5_10.jpg',
                          '${user.imageUrl ?? 'https://img-c.udemycdn.com/user/200_H/317821_3cb5_10.jpg'}',
                        ),
                        radius: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 100.w,
                        child: Text(
                          //'User Name',
                          '${user.userName}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                        ),
                        onPressed: () {
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
                                        'Are you sure you want ${user.userName} become a Manager ?',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        height: 40,
                                        child: defaultButton(
                                          text: 'Yes, I\'m Agree',
                                          onPressed: () {
                                            cubit.makeAuthorManagerRole(
                                                userRequestId: user.sId);
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 40,
                                        child: defaultButton(
                                          text: 'No',
                                          onPressed: () {
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
                        child: Text('Make Manager'),
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
