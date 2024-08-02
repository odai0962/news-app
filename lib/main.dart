import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odaibaklo/shared/component/constant.dart';
import 'package:odaibaklo/shared/cubit/cubit.dart';
import 'package:odaibaklo/shared/cubit/states.dart';
import 'package:odaibaklo/shared/network/local/cache_helper.dart';
import 'package:odaibaklo/shared/network/remote/dio_helper.dart';

import 'layout/home_layout.dart';
import 'moduls/search_screen/search_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
 bool? isDark =  CacheHelper.getData(key: "isDark");
  runApp(Main( isDark));
}

class Main extends StatelessWidget {

   bool? isDark;

   Main(this.isDark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getBusiness()..changeAppTheme(fromPref: isDark),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return MaterialApp(
            theme: ThemeData(
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                selectedItemColor: Colors.amber.shade900,
              ),
              textTheme: TextTheme(
                bodySmall: TextStyle(color: Colors.black),
                bodyLarge: TextStyle(color: Colors.black),
                bodyMedium: TextStyle(color: Colors.black),
                titleLarge: TextStyle(color: Colors.black),
                titleMedium: TextStyle(color: Colors.black),
                titleSmall: TextStyle(color: Colors.black),
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.amber.shade900,
                foregroundColor: Colors.black,
                elevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.light,
                ),
              ),
            ),
            themeMode: cubit.isDark ? ThemeMode.light : ThemeMode.dark,
            darkTheme: ThemeData(
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.grey.shade900,
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.amber.shade900,
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.grey.shade900,
                foregroundColor: Colors.amber.shade900,
                actionsIconTheme: IconThemeData(
                  color: Colors.amber.shade900,
                ),
              ),
              scaffoldBackgroundColor: Colors.grey.shade900,
              textTheme: TextTheme(
                bodySmall: TextStyle(color: Colors.white),
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white),
                titleLarge: TextStyle(color: Colors.white),
                titleMedium: TextStyle(color: Colors.white),
                titleSmall: TextStyle(color: Colors.white),
              ),
            ),
            home: HomeLayout(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

