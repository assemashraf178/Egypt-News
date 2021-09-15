import 'package:eg_news_app/cubit/cubit.dart';
import 'package:eg_news_app/cubit/states.dart';
import 'package:eg_news_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppCubit.get(context).getSearch('مصر');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Search',
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(
              MediaQuery.of(context).size.height / 50.0,
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultTextFormField(
                      hint: 'Search',
                      prefixIcon: Icons.search,
                      context: context,
                      type: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'search must not be empty';
                        }
                        return null;
                      },
                      controller: searchController,
                      onSubmit: (s) {
                        if (formKey.currentState!.validate()) {
                          AppCubit.get(context).getSearch(s);
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50.0,
                    ),
                    Conditional.single(
                      context: context,
                      conditionBuilder: (BuildContext context) =>
                          AppCubit.get(context).searchModel != null &&
                          state is! NewsGetSearchLoadingStates,
                      widgetBuilder: (BuildContext context) =>
                          ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height / 100.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return buildNewsItem(
                            context: context,
                            articles: AppCubit.get(context)
                                .searchModel!
                                .articles[index],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          height: 15.0,
                          color: Colors.grey[400],
                        ),
                        itemCount:
                            AppCubit.get(context).searchModel!.articles.length,
                      ),
                      fallbackBuilder: (BuildContext context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
