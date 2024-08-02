import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odaibaklo/moduls/search_screen/search_screen.dart';
import 'package:odaibaklo/shared/cubit/cubit.dart';
import 'package:odaibaklo/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {} ,
      builder: (context, state) {

        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
              }, icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeAppTheme();},
                  icon: Icon(Icons.brightness_4_outlined)),
            ],
            title: Text(cubit.appBarTitle[cubit.currentIndex]),
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            onTap: (value) {
              cubit.BottomNavChangeItemIndex(value);
              },
              currentIndex: cubit.currentIndex,
              items: cubit.itemList),

          body: cubit.itemScreen[cubit.currentIndex],
        );
      },
    );
  }
}


