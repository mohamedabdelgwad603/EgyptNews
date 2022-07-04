import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:egynews/bloc/cubit.dart';
import 'package:egynews/bloc/states.dart';
import 'package:egynews/components/components.dart';
import 'package:egynews/admob/AdsManger.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: ((context, state) {}),
      builder: (context, state) {
        var searchList = BlocProvider.of<NewsCubit>(context).searchList;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(),
            body: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  style: Theme.of(context).textTheme.caption,
                  controller: controller,
                  keyboardType: TextInputType.text,
                  validator: (String? value) {
                    if (value == null) {
                      return "search vlue must not be empty";
                    } else
                      return null;
                  },
                  onChanged: (str) {
                    BlocProvider.of<NewsCubit>(context).searchapp(str);
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      prefixIcon: Icon(Icons.search),
                      labelText: "ابحث"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child:
                    buildArticleConditionalBuilder(searchList, isSearch: true),
              ),
              AdmobBanner(
                adUnitId: AdsManager.bannerAdUnitId,
                adSize: AdmobBannerSize.BANNER,
              )
            ]),
          ),
        );
      },
    );
  }
}
