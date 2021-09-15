import 'package:eg_news_app/cubit/cubit.dart';
import 'package:eg_news_app/cubit/states.dart';
import 'package:eg_news_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

class BusinessScreen extends StatelessWidget {
  BusinessScreen({Key? key}) : super(key: key);

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (BuildContext context) =>
              AppCubit.get(context).businessModel != null &&
              state is! NewsGetBusinessLoadingStates,
          widgetBuilder: (BuildContext context) {
            return ListView.separated(
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.height / 100.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return buildNewsItem(
                  context: context,
                  articles:
                      AppCubit.get(context).businessModel!.articles[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(
                height: 15.0,
                color: Colors.grey[400],
              ),
              itemCount: AppCubit.get(context).businessModel!.articles.length,
            );
          },
          fallbackBuilder: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
