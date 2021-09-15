import 'package:bloc/bloc.dart';
import 'package:eg_news_app/layouts/home_layout.dart';
import 'package:eg_news_app/shared/BlocObserver.dart';
import 'package:eg_news_app/shared/network/local/cashed_helper.dart';
import 'package:eg_news_app/shared/network/remote/dio_helper.dart';
import 'package:eg_news_app/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashedHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  bool? isDark = CashedHelper.getData(key: 'isDark') ?? false;
  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  const MyApp({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) {
          return AppCubit()
            ..changeThemeMode(fromCashed: isDark)
            ..getBusiness()
            ..getSport()
            ..getScience();
        },
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (BuildContext context, AppStates state) {},
            builder: (BuildContext context, AppStates state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Egypt News',
                theme: lightMode(),
                darkTheme: darkMode(),
                themeMode: AppCubit.get(context).isDark == true
                    ? ThemeMode.dark
                    : ThemeMode.light,
                home: HomeLayout(),
              );
            }));
  }
}
