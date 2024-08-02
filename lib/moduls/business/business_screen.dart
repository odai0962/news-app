import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odaibaklo/shared/component/component.dart';
import 'package:odaibaklo/shared/cubit/cubit.dart';
import 'package:odaibaklo/shared/cubit/states.dart';

class BusinessScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is! GetBusinessDataLoadingState,
            builder: (context) {

              var cubit = AppCubit.get(context);
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return defultItemDesign(cubit.business[index],context);
                  },
                  separatorBuilder: (context, index) => Container(width: double.infinity,height: 1,color: Colors.black,),
                  itemCount: cubit.business.length,
              );
            },
          fallback: (context) => Center(child: CircularProgressIndicator(color: Colors.amber,)),);
      },
    );
  }
}
