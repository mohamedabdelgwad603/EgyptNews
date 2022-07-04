import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:egynews/bloc/states.dart';
import 'package:egynews/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../bloc/cubit.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: ((context, state) {}),
      builder: (context, State) {
        var businessArticles = BlocProvider.of<NewsCubit>(context).business;

        return buildArticleConditionalBuilder(businessArticles);
      },
    );
  }
}
