import 'package:eg_news_app/cubit/cubit.dart';
import 'package:eg_news_app/cubit/states.dart';
import 'package:eg_news_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class SportScreen extends StatelessWidget {
  SportScreen({Key? key}) : super(key: key);
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        return RefreshIndicator(
          key: refreshKey,
          onRefresh: () async {
            AppCubit.get(context).getSport();

            return await Future.delayed(
              const Duration(seconds: 1),
            );
          },
          child: Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) =>
                AppCubit.get(context).sportModel != null &&
                state is! NewsGetSportLoadingStates,
            widgetBuilder: (BuildContext context) {
              return ListView.separated(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.height / 100.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return buildNewsItem(
                    context: context,
                    articles: AppCubit.get(context).sportModel!.articles[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 15.0,
                  color: Colors.grey[400],
                ),
                itemCount: AppCubit.get(context).sportModel!.articles.length,
              );
            },
            fallbackBuilder: (BuildContext context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
