import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/modules/quiz/cubit/cubit.dart';
import 'package:lms/shared/component/constants.dart';
import '../../../cubit/states.dart';

class Option extends StatefulWidget {
  const Option({
    Key? key,
    required this.text,
  required  this.index,
 required   this.press,
  }) : super(key: key);
  final String text;
  final int index;
  final VoidCallback press;

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit,QuizStates>(
        listener: (context,state){},
        builder:(context,state){
          var cubit = QuizCubit.get(context);
          return Builder(
            builder: (context) {
              return Builder(

                  builder: (context) {
                    Color getTheRightColor() {
                      if (cubit.isAnswered) {
                        if (widget.index == cubit.correctAns) {
                          return kGreenColor;
                        } else if (widget.index == cubit.selectedAns &&
                            cubit.selectedAns != cubit.correctAns) {
                          return kRedColor;
                        }
                      }
                      return kGrayColor;
                    }

                    IconData getTheRightIcon() {
                      return getTheRightColor() == kRedColor ? Icons.close : Icons.done;
                    }

                    return InkWell(
                      onTap: widget.press,
                      child: Container(
                        margin: EdgeInsets.only(top: kDefaultPadding),
                        padding: EdgeInsets.all(kDefaultPadding),
                        decoration: BoxDecoration(
                          border: Border.all(color: getTheRightColor()),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${widget.index + 1}. ${widget.text}",
                              style: TextStyle(color: getTheRightColor(), fontSize: 16),
                            ),
                            Container(
                              height: 26,
                              width: 26,
                              decoration: BoxDecoration(
                                color: getTheRightColor() == kGrayColor
                                    ? Colors.transparent
                                    : getTheRightColor(),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: getTheRightColor()),
                              ),
                              child: getTheRightColor() == kGrayColor
                                  ? null
                                  : Icon(getTheRightIcon(), size: 16),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
          );
        }
    );
  }
}
