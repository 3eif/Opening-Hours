import '../structures/Business.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../services/getTodayHours.dart';

class BusinessScreen extends StatelessWidget {
  final Business business;
  BusinessScreen(this.business);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          elevation: 1,
          backgroundColor: Colors.red,
          title: Text(
            business.name,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                  child: Text(
                    business.name,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 45,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 40.0, right: 40.0, top: 5.0),
                  child: Chip(
                    label: Text(
                      '${business.openingHours.openNow ? 'Open' : 'Closed' ?? 'No Data'}: ${getTodayHours(business.openingHours.weekdayText)}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: business.openingHours.openNow
                        ? Colors.green
                        : Colors.red,
                  ),
                  // child: Text(
                  //   '\n${business.openingHours.openNow ? 'Open' : 'Closed' ?? 'No Data'}\n${getTodayHours(business.openingHours.weekdayText)}',
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //     color: business.openingHours.openNow == true
                  //         ? Colors.green ?? Colors.grey
                  //         : Colors.red,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, left: 25.0, right: 25.0, bottom: 10.0),
              child: new Divider(
                color: Colors.black,
              ),
            ),
            Flexible(
              child: Scrollbar(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(
                      bottom: 10.0, left: 25.0, right: 25.0),
                  itemCount: business.openingHours.weekdayText.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 4.0),
                      child: Card(
                        elevation: 7,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontSize: 17.5, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      '${business.openingHours.weekdayText[index].split(':')[0]}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.5),
                                ),
                                TextSpan(
                                  text:
                                      '\n${business.openingHours.weekdayText[index].replaceFirst(':', '?').split('?')[1]}',
                                  style: TextStyle(fontSize: 17.5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // child: GridView.count(
            //   crossAxisCount: 24,
            //   children: List.generate(168, (index) {
            //     return Container(
            //       height: 150.0,
            //       width: 150.0,
            //       color: Colors.transparent,
            //       child: Container(
            //         decoration: BoxDecoration(
            //             color: Colors.green,
            //             borderRadius: BorderRadius.all(Radius.circular(1.0))),
            //         child: new Center(),
            //       ),
            //     );
            //   }),
            // ),
          ],
        ),
      ),
    );
  }
}
