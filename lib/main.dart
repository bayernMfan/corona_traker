import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_app/constant.dart';
import 'package:provider_app/pages/home_page.dart';
import 'package:provider_app/pages/tab_page.dart';

import 'bloc/country_bloc/country_bloc.dart';
import 'bloc/global_bloc/global_bloc.dart';
import 'rep/API/country.dart';
import 'rep/API/global_repo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Country>(create: (context) => Country()),
        RepositoryProvider<GlobalRepo>(create: (context) => GlobalRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CountryBloc>(
            create: (BuildContext context) => CountryBloc(RepositoryProvider.of<Country>(context)),
          ),
          BlocProvider<GlobalBloc>(
            create: (BuildContext context) => GlobalBloc(RepositoryProvider.of<GlobalRepo>(context)),
          ),
        ],
        child: MaterialApp(
          title: 'Covid Notify',
          theme: ThemeData(
            scaffoldBackgroundColor: kBackGroundColor,
            fontFamily: "Poppins",
            textTheme: TextTheme(
              bodyText2: TextStyle(
                color: kBodyTextColor,
              ),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Tabbar(),
        ),
      ),
    );
  }
}
