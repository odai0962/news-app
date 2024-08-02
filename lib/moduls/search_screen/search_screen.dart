import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odaibaklo/shared/cubit/cubit.dart';
import 'package:odaibaklo/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../../shared/component/component.dart';

class SearchScreen extends StatelessWidget {
  var fieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  style: TextStyle(color: Colors.amber.shade900),
                  controller: fieldController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "The field can't be empty";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (value.length >= 10) {
                      AppCubit.get(context).getSearch(query: value);
                    }
                  },
                  decoration: InputDecoration(
                    label: Text('Search'),
                    labelStyle: Theme.of(context).textTheme.titleSmall,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.amber.shade900,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ConditionalBuilder(
                    condition: state is! GetSearchDataLoadingState,
                    builder: (context) {
                      var cubit = AppCubit.get(context);
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          return defultItemDesign(cubit.searchList[index], context);
                        },
                        separatorBuilder: (context, index) => Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.black,
                        ),
                        itemCount: cubit.searchList.length,
                      );
                    },
                    fallback: (context) => Center(
                      child: CircularProgressIndicator(color: Colors.amber.shade900),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
