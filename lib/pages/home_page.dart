import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_app/bloc/GlobalBloc.dart';
import 'package:provider_app/rep/models/GlobalModel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final globalBloc = BlocProvider.of<GlobalBloc>(context);
    return Container(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Center(
            child: Text('CORONA'),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('load global data'),
              RaisedButton(
                onPressed: () {
                  BlocProvider.of<GlobalBloc>(context).add(FetchGlobal());
                },
                child: Text('getData'),
              ),
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
            ],
          ),
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
        padding: EdgeInsets.only(right: 32, left: 32, top: 10),
        child: Column(
          children: <Widget>[
            Text(
              'World total:',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              globalInfo.totalConfirmed.round().toString(),
              style: TextStyle(color: Colors.white70, fontSize: 50),
            ),
            Text(
              "totalConfirmed",
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
                      "newConfirmed",
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
                      "newDeaths",
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
                color: Colors.lightBlue,
                child: Text(
                  "Back",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            )
          ],
        ));
  }
}
