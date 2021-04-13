import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider_app/bloc/country_bloc/country_bloc.dart';
import 'package:provider_app/bloc/global_bloc/global_bloc.dart';
import 'package:provider_app/constant.dart';
import 'package:provider_app/rep/API/country.dart';
import 'package:provider_app/rep/API/global_repo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build HomePage");
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              padding: EdgeInsets.only(
                left: 50,
                top: 50,
                right: 8,
              ),
              height: 260,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF3383CD),
                    Color(0xFF11249F),
                  ],
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/virus.png"),
                ),
              ),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: SvgPicture.asset("assets/icons/menu.svg"),
                  ),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/Drcorona.svg",
                          width: 200,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                        Positioned(
                          top: 20,
                          left: 140,
                          child: Text(
                            "All you need \nis not being a puss",
                            style: kHeadingTextStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              //Case update
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: BlocProvider(
                create: (BuildContext context) => GlobalBloc(GlobalRepo()),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        //search
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Color(0xFFE5E5E5),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 20,
                              color: kShadowColor,
                            ),
                          ],
                        ),
                        child: BlocProvider(
                          create: (context) => CountryBloc(Country()),
                          child: CountrySearch(), //Search by country widget
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Case update\n",
                                  style: kTitleTextStyle,
                                ),
                                TextSpan(
                                  text: "Newest update today",
                                  style: TextStyle(color: kTextLightColor),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "See details",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      StatsWidget(), //GlobalInfo statistic widget

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Virus Spread\n",
                                  style: kTitleTextStyle,
                                ),
                                TextSpan(
                                  text: "Around the world",
                                  style: TextStyle(color: kTextLightColor),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "See details",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 190,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFE5E5E5),
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 20,
                              color: kShadowColor,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          "assets/images/map.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CountrySearch extends StatefulWidget {
  const CountrySearch({
    Key key,
  }) : super(key: key);

  @override
  _CountrySearchState createState() => _CountrySearchState();
}

class _CountrySearchState extends State<CountrySearch> {
  final List<String> countries = ['World'];
  String dropdownValue = 'World';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<CountryBloc>(context).add(GetCountry("Country"));
    print("GetCountry");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryBloc, CountryState>(
      builder: (context, state) {
        if (state is CountryInitial)
          return Text("CountryInitial");
        else if (state is CountryIsLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        else if (state is CountryLoaded) {
          //state.getProps.add("World");
          state.getProps.sort();
          print("countries in dropdown = ${state.getProps.length}");
          return Row(
            children: <Widget>[
              SvgPicture.asset("assets/icons/maps-and-flags.svg"),
              SizedBox(width: 8),
              Expanded(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    isExpanded: true,
                    underline: SizedBox(),
                    icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                    value: dropdownValue,
                    onChanged: (String newValue) {
                      BlocProvider.of<GlobalBloc>(context)
                          .add(FetchGlobal(newValue));
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: state.getProps
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        } else if (state is CountryNotLoaded)
          return Text(
            state.getMessage,
            style: TextStyle(color: Colors.black),
          );
        return Container();
      },
    );
  }
}

class StatsWidget extends StatefulWidget {
  StatsWidget({Key key}) : super(key: key);
  @override
  _StatsWidgetState createState() => _StatsWidgetState();
}

class _StatsWidgetState extends State<StatsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<GlobalBloc>(context).add(FetchGlobal());
    print("FetchGlobal event");
  }

  @override
  Widget build(BuildContext context) {
    print("build StatsWidget");
    return Container(
      //counters
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFE5E5E5),
        ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 20,
            color: kShadowColor,
          ),
        ],
      ),
      child: BlocBuilder<GlobalBloc, GlobalState>(
        builder: (context, state) {
          if (state is GlobalInitial)
            return Text("GlobalInitial");
          else if (state is GlobalIsLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (state is GlobalIsLoaded) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Counter(
                  color: kInfectedColor,
                  number: state.getGlobalInfo.totalConfirmed,
                  title: "Infected",
                ),
                Counter(
                  color: kDeathColor,
                  number: state.getGlobalInfo.totalDeaths,
                  title: "Deaths",
                ),
                Counter(
                  color: kRecoveryColor,
                  number: state.getGlobalInfo.totalRecovered,
                  title: "Recovered",
                ),
              ],
            );
          } else if (state is GlobalIsNotLoaded)
            return Text(
              state.getMessage,
              style: TextStyle(color: Colors.black),
            );
          return Container();
        },
      ),
    );
  }
}

class Counter extends StatelessWidget {
  final int number;
  final Color color;
  final String title;
  const Counter({
    Key key,
    this.number,
    this.color,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(.25),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: color,
                width: 2,
              ),
            ),
          ),
        ),
        Text(
          "$number",
          style: TextStyle(
            fontSize: 20,
            color: color,
          ),
        ),
        Text(
          "$title",
          style: kSubTextStyle,
        ),
      ],
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 2, size.height + 40, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
