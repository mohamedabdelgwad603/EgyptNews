import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit.dart';
import '../bloc/states.dart';
import '../components/components.dart';

class ScienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: ((context, state) {}),
      builder: (context, State) {
        var scienceArticles = BlocProvider.of<NewsCubit>(context).science;

        return buildArticleConditionalBuilder(scienceArticles);
      },
    );
  }
}
