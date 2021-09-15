import 'package:eg_news_app/cubit/cubit.dart';
import 'package:eg_news_app/models/news_model.dart';
import 'package:eg_news_app/modules/news_web/news_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

Widget buildNewsItem({
  required BuildContext context,
  required Articles articles,
}) =>
    InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => NewsWebScreen(
              url: articles.url.toString(),
              name: articles.title.toString(),
            ),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (articles.urlToImage != null)
            Image(
              image: NetworkImage(
                articles.urlToImage.toString(),
              ),
              width: MediaQuery.of(context).size.height / 7,
              height: MediaQuery.of(context).size.height / 7,
              fit: BoxFit.cover,
            ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 50.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  articles.title.toString(),
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: MediaQuery.of(context).size.height / 45.0,
                        fontWeight: FontWeight.w900,
                        height: 1.5,
                        overflow: TextOverflow.ellipsis,
                        color: AppCubit.get(context).isDark == true
                            ? Colors.white
                            : Colors.black,
                      ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50.0,
                ),
                Text(
                  articles.publishedAt.toString(),
                  maxLines: 1,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 50.0,
          ),
          IconButton(
            onPressed: () {
              Share.share(
                'العنوان : '
                '${articles.title.toString()}\n'
                'الرابط : '
                '${articles.url.toString()}',
              );
            },
            icon: const Icon(
              Icons.share,
            ),
          ),
        ],
      ),
    );

Future<void> refresh({
  required GlobalKey<RefreshIndicatorState> refreshKey,
}) async {
  refreshKey.currentState!.show(atTop: false);
  await Future.delayed(const Duration(seconds: 2));
}

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blueGrey,
  bool isUpperCase = true,
  double radius = 15.0,
  double height = 40.0,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
        elevation: 50.0,
      ),
    );

Widget defaultTextFormField({
  required String hint,
  required IconData prefixIcon,
  required BuildContext context,
  required TextInputType type,
  required Function validator,
  required TextEditingController controller,
  bool isPassword = false,
  IconButton? suffixIcon,
  Function? onChange,
  Function? onSubmit,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.blueGrey.withOpacity(0.1),
      ),
      child: TextFormField(
        onFieldSubmitted: onSubmit != null
            ? (s) {
                onSubmit(s);
              }
            : null,
        onChanged: onChange != null
            ? (s) {
                onChange(s);
              }
            : null,
        controller: controller,
        validator: (value) {
          validator(value);
        },
        keyboardType: type,
        obscureText: isPassword,
        style: TextStyle(
          textBaseline: TextBaseline.alphabetic,
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          suffix: suffixIcon,
          contentPadding: EdgeInsets.all(
            (MediaQuery.of(context).size.width) / 50.0,
          ),
          isCollapsed: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 1,
            ),
          ),
          prefixIcon: Icon(
            prefixIcon,
          ),
          // hintText: hint,
          // hintStyle: TextStyle(
          //   color: Colors.grey.withOpacity(0.5),
          //   textBaseline: TextBaseline.alphabetic,
          // ),
          labelText: hint,
        ),
      ),
    );

Card defaultLoading({
  required BuildContext context,
}) =>
    Card(
      child: Padding(
        padding: EdgeInsets.all(
          (MediaQuery.of(context).size.height) / 40.0,
        ),
        child: CircularProgressIndicator(),
      ),
      elevation: 5,
    );
