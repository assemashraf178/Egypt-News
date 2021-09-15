import 'package:eg_news_app/cubit/cubit.dart';
import 'package:eg_news_app/cubit/states.dart';
import 'package:eg_news_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class ScienceScreen extends StatelessWidget {
  ScienceScreen({Key? key}) : super(key: key);
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        return RefreshIndicator(
          key: refreshKey,
          onRefresh: () async {
            AppCubit.get(context).getScience();

            return await Future.delayed(
              const Duration(seconds: 1),
            );
          },
          child: Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) =>
                AppCubit.get(context).scienceModel != null &&
                state is! NewsGetScienceLoadingStates,
            widgetBuilder: (BuildContext context) {
              return ListView.separated(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.height / 100.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return buildNewsItem(
                    context: context,
                    articles:
                        AppCubit.get(context).scienceModel!.articles[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 15.0,
                  color: Colors.grey[400],
                ),
                itemCount: AppCubit.get(context).scienceModel!.articles.length,
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
