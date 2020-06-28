import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_app/constant.dart';
import 'package:provider_app/pages/tab_page.dart';

import 'bloc/global_bloc/global_bloc.dart';
import 'rep/API/global_repo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackGroundColor,
        fontFamily: "Poppins",
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: kBodyTextColor,
          ),
        ),
        //primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => GlobalBloc(GlobalRepo()),
        child: Tabbar(),
      ),
    );
  }
}
