import 'package:flutter/material.dart';
import 'package:lms/models/on_boarding_model.dart';
import 'package:lottie/lottie.dart';

import 'constants.dart';

Widget buildBoardingItem(BoardingModel model, context) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: connected
                ? Lottie.network(model.lottie!,
                    width: MediaQuery.of(context).size.width / 1)
                : Lottie.asset('assets/no internet.json',
                    width: MediaQuery.of(context).size.width / 1)),
        const SizedBox(
      height: 20.0,
    ),
    Text(
      model.title!,
      style: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    const SizedBox(
      height: 15.0,
    ),
  ],
);
