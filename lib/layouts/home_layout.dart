import 'package:eg_news_app/cubit/cubit.dart';
import 'package:eg_news_app/cubit/states.dart';
import 'package:eg_news_app/modules/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SearchScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeThemeMode();
                },
                icon: const Icon(Icons.brightness_6),
              ),
            ],
            title: Text(
              AppCubit.get(context).titles[AppCubit.get(context).currentIndex],
            ),
          ),
          bottomNavigationBar: SalomonBottomBar(
            items: AppCubit.get(context).items,
            onTap: (int index) {
              AppCubit.get(context).changeBottomNavBarIndex(index);
            },
            currentIndex: AppCubit.get(context).currentIndex,
          ),
          body: RefreshIndicator(
            key: refreshKey,
            onRefresh: () async {
              if (AppCubit.get(context).currentIndex == 0) {
                AppCubit.get(context).getBusiness();
              } else if (AppCubit.get(context).currentIndex == 1) {
                AppCubit.get(context).getSport();
              } else if (AppCubit.get(context).currentIndex == 2) {
                AppCubit.get(context).getScience();
              }
              return await Future.delayed(
                const Duration(seconds: 1),
              );
            },
            child: AppCubit.get(context)
                .screens[AppCubit.get(context).currentIndex],
          ),
        );
      },
    );
  }
}
