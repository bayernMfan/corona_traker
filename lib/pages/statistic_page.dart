import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_app/bloc/global_bloc/global_bloc.dart';
import 'package:provider_app/rep/models/global_model.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build StatisticPage");
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
            BlocBuilder<GlobalBloc, GlobalState>(
              builder: (context, state) {
                if (state is GlobalInitial)
                  return Text("GlobalInitial");
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
              },
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: FlatButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                onPressed: () {
                  context.bloc<GlobalBloc>().add(FetchGlobal());
                  //BlocProvider.of<GlobalBloc>(context).add(ResetGlobal());
                  //BlocProvider.of<GlobalBloc>(context).add(FetchGlobal());
                },
                color: Colors.indigo,
                child: Text(
                  "Reset",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            ),
            SearchCountry(),
          ],
        ),
      ),
    );
  }
}

class ShowGlobal extends StatelessWidget {
  final GlobalModel globalInfo;

  ShowGlobal(this.globalInfo);
  @override
  Widget build(BuildContext context) {
    return Container(
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
          "total cases",
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
                  "new cases",
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
  String _searchText = "";
  TextEditingController _searchController;
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Search by country',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: "Search by country",
              hintText: "Country",
              prefixIcon: IconButton(
                icon: Icon(Icons.search),
                color: Colors.white,
                onPressed: () {
                  print(_searchController.text);
                },
              ),
              suffixIcon: _searchText.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
          ),
        ]);
  }

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
