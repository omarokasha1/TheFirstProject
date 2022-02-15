import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../cubit For Internet/cubit.dart';
import '../cubit For Internet/states.dart';
import 'component.dart';

Widget noInternet(context) => BlocConsumer<InternetCubit, InternetStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/no internet.json',
                  width: MediaQuery.of(context).size.width / 1, height: 400),
              const Text(
                'Check Internet Connection',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 150,
                child: defaultButton(
                    text: 'Retry',
                    onPressed: () {
                      InternetCubit.get(context).checkInternetConnection();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
