import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../shared/component/constants.dart';
import '../shared/component/no internet.dart';
import '../shared/cubit For Internet/cubit.dart';
import '../shared/cubit For Internet/states.dart';

class Layout extends StatelessWidget {
  final Widget widget;

  const Layout({required this.widget, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetCubit, InternetStates>(
      listener: (context, state) {},
      builder: (context, state) => RefreshIndicator(onRefresh: () async {
        InternetCubit.get(context).checkInternetConnection();
      }, child: Builder(builder: (BuildContext context) {
        return OfflineBuilder(
          connectivityBuilder: (context, connectivity, child) {
            connected = connectivity != ConnectivityResult.none;
            return SafeArea(
              child: Scaffold(
                body: Stack(
                  fit: StackFit.expand,
                  children: [
                    child,
                    Positioned(
                      top: 0,
                      left: 0.0,
                      right: 0.0,
                      height: 32.0,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        color: connected != true ? secondaryColor : null,
                        child: connected != true
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Text(
                                    "No connection",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  SizedBox(
                                    width: 12.0,
                                    height: 12.0,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  ),
                                ],
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          child: ConditionalBuilder(
            condition: connected,
            builder: (context) => widget,
            fallback: (context) => noInternet(context),
          ),
        );
      })),
    );
  }
}
