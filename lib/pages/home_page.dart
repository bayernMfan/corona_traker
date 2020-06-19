import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_app/bloc/global_bloc.dart';
import 'package:provider_app/rep/models/global_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GlobalBloc>(context).add(FetchGlobal());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Center(
          child: Text('CORONA'),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(right: 32, left: 32, top: 16, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<GlobalBloc, GlobalState>(builder: (context, state) {
              if (state is GlobalIsNotSerached)
                return Text("GlobalIsNotSearched");
              else if (state is GlobalIsLoading)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else if (state is GlobalIsLoaded)
                return ShowGlobal(state.getGlobalInfo);
              else
                return Text(
                  "Error",
                  style: TextStyle(color: Colors.white),
                );
            }),
            SearchCountry(),
          ],
        ),
      ),
    );
  }
}

class ShowGlobal extends StatelessWidget {
  final GlobalModel globalInfo;
  //final city;

  //ShowGlobal(this.Global, this.city);
  ShowGlobal(this.globalInfo);
  @override
  Widget build(BuildContext context) {
    return Container(
        //padding: EdgeInsets.only(right: 32, left: 32, top: 10),
        child: Column(
      children: <Widget>[
        Text(
          'World total:',
          style: TextStyle(
              color: Colors.white70, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          globalInfo.totalConfirmed.round().toString(),
          style: TextStyle(color: Colors.white70, fontSize: 50),
        ),
        Text(
          "total confirmed",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  globalInfo.newConfirmed.round().toString(),
                  style: TextStyle(color: Colors.white70, fontSize: 30),
                ),
                Text(
                  "new confirmed",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  globalInfo.newDeaths.round().toString(),
                  style: TextStyle(color: Colors.white70, fontSize: 30),
                ),
                Text(
                  "new deaths",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: 50,
          child: FlatButton(
            shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            onPressed: () {
              BlocProvider.of<GlobalBloc>(context).add(ResetGlobal());
            },
            color: Colors.indigo,
            child: Text(
              "Reset",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
        )
      ],
    ));
  }
}

class SearchCountry extends StatefulWidget {
  SearchCountry({Key key}) : super(key: key);

  @override
  _SearchCountryState createState() => _SearchCountryState();
}

class _SearchCountryState extends State<SearchCountry> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Search by country',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              fillColor: Colors.white,
              labelText: 'Enter your country',
            ),
          ),
        ]);
  }
}
