import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opening_hours/services/getBusinesses.dart';

import '../services/getTodayHours.dart';
import '../structures/Business.dart';
import '../screens/BusinessScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController _textController = TextEditingController();
  Future<List<Business>> businesses;
  String query;

  @override
  void initState() {
    super.initState();
  }

  Future onItemChanged() async {
    Future<List<Business>> bs = getBusinesses(query);
    setState(() {
      businesses = bs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Opening Hours"),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Increment',
        child: new Icon(
          Icons.search,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        onPressed: () {
          onItemChanged();
          setState(() {
            FocusScope.of(context).unfocus();
          });
        },
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                textInputAction: TextInputAction.search,
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Search Here...',
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  border: const OutlineInputBorder(),
                ),
                onChanged: (val) {
                  setState(() {
                    query = val;
                  });
                },
                onSubmitted: (val) {
                  query = val;
                  onItemChanged();
                },
              ),
            ),
            Flexible(
              child: FutureBuilder<List>(
                future: businesses,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length == 0)
                      return Center(child: Text('No Results Found'));
                    return Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.black12,
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount:
                            snapshot.data == null ? 0 : snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 0,
                            color: Colors.white,
                            child: ListTile(
                              title: Text(
                                snapshot.data[index].name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              subtitle: RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          snapshot.data[index].formattedAddress,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '\n${snapshot.data[index].openingHours.openNow ? 'Open' : 'Closed' ?? 'No Data'} | ${getTodayHours(snapshot.data[index].openingHours.weekdayText)}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: snapshot.data[index]
                                                      .openingHours.openNow ==
                                                  true
                                              ? Colors.green ?? Colors.grey
                                              : Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Icon(Icons.arrow_right),
                              isThreeLine: true,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) =>
                                        BusinessScreen(snapshot.data[index]),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (!snapshot.hasData)
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: Icon(
                            Icons.access_time,
                            color: Colors.red,
                            size: 140.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 25.0),
                          child: Text(
                            'Search for a restraunt, business or shop!',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
