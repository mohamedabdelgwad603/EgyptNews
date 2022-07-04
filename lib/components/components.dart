import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:egynews/modules/webView_screen.dart';

import '../bloc/cubit.dart';

Widget buildIArticleItem(Map article, context) {
  return InkWell(
    onTap: () {
      BlocProvider.of<NewsCubit>(context).interstitialAd!.show();

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => WebViewScreen(url: article['url']))));
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            height: 150,
            width: 120,
            decoration: article['urlToImage'] != null
                ? BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("${article['urlToImage']}"),
                    ),
                  )
                : null,
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Container(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "${article['title']}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Text(
                    "${article['publishedAt']}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget buildArticleConditionalBuilder(List anyList, {bool isSearch = false}) {
  return ConditionalBuilder(
      condition: anyList.isNotEmpty,
      builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemCount: anyList.length,
            itemBuilder: ((context, index) {
              return buildIArticleItem(anyList[index], context);
            }),
            separatorBuilder: (context, index) => const Divider(),
          ),
      fallback: (context) => isSearch
          ? Container()
          : Center(
              child: CircularProgressIndicator(),
            ));
}
