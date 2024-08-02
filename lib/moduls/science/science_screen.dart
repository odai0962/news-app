import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component/component.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class ScienceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetScienceDataLoadingState,
          builder: (context) {

            var cubit = AppCubit.get(context);
            return ListView.separated(
              itemBuilder: (context, index) {
                return defultItemDesign(cubit.science[index],context);
              },
              separatorBuilder: (context, index) => Container(width: double.infinity,height: 1,color: Colors.black,),
              itemCount: cubit.science.length,
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator(color: Colors.amber,)),);
      },
    );
  }
}
