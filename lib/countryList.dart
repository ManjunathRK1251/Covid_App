import 'package:covid_app/countrydetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  String enteredText = '';
  bool loading = true;
  List<String> countries = [];
  List<String> results = [];

  void getCountries() async {
    var url = Uri.https('projectify-covidapp.herokuapp.com', '/countryList');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var c in data) {
        countries.add(c);
      }
      // print(countries);
    }
    else {
      throw Exception('Failed to load data');
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getCountries();
  }

  void runFilter(String enteredKeyword) {
    results.clear();
    if (enteredKeyword.isEmpty) {
      results = List.from(countries);
      print(results);
    } else {
      for (int i = 0; i < countries.length; ++i) {
        String data = countries[i];
        if (data.toLowerCase().contains(enteredKeyword.toLowerCase())) {
          if (results.contains(data) == false) {
            results.add(data);
          }
        }
      }
      // print(results);
    }

    setState(() {
      results = List.from(results);
    });
  }

  Widget build(BuildContext context) {
    results.isEmpty
        ? results = List.from(countries)
        : results = List.from(results);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.0,
            backgroundColor: Color(0xff66466E),
            title: Container(
              child: TextField(
                cursorColor: Colors.white10,
                onChanged: (newText) {
                  enteredText = newText;
                  // print(enteredText);
                  runFilter(enteredText);
                },
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: Color.fromRGBO(255, 255, 255, 0.30000001192092896),
                  ),
                  prefixIcon: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_sharp,
                      color: Color.fromRGBO(255, 255, 255, 0.30000001192092896),
                    ),
                  ),
                  hintText: 'Search Countries',
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.30000001192092896),
                    fontFamily: 'Roboto',
                    fontSize: 22,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff66466E),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff66466E),
                    ),
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 20.0,
                  //backgroundColor: Colors.white,
                ),
              ),
              width: 374,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Color.fromRGBO(64, 22, 75, 1),
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xff66466E),
        body: (loading)
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              )
            : ((countries.length > 0)
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                          bottomLeft: Radius.circular(14),
                          bottomRight: Radius.circular(14),
                        ),
                        color: Color.fromRGBO(64, 22, 75, 1),
                      ),
                      padding: EdgeInsets.all(20.0),
                      //color: Colors.purple,
                      child: ScrollConfiguration(
                        behavior: ScrollBehavior(),
                        child: GlowingOverscrollIndicator(
                          axisDirection: AxisDirection.down,
                          color: Colors.purple,
                          child: ListView.separated(
                            addRepaintBoundaries: false,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(height: 10);
                            },
                            itemBuilder: (context, index) {
                              return // Figma Flutter Generator Rectangle4Widget - RECTANGLE
                                  Container(
                                width: 348,
                                height: 55,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  color: Color.fromRGBO(102, 70, 110, 1),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return CountryDetails(
                                              countryName: results[index]);
                                        },
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(
                                      results[index],
                                      style: TextStyle(color: Colors.white38),
                                    ),
                                    //tileColor: Colors.blue[100],
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                ),
                              );
                            },
                            itemCount: results.length,
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Text('No countries to show!'),
                  )),
      ),
    );
  }
}

      // Figma Flutter Generator SearchcountryWidget - TEXT

/*
Container(
                  child: TextField(
                    cursorColor: Colors.white10,
                    onChanged: (newText) {
                      enteredText = newText;
                      // print(enteredText);
                      runFilter(enteredText);
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.ac_unit),
                      hintText: 'Search Countries',
                      hintStyle: TextStyle(
                        color:
                            Color.fromRGBO(255, 255, 255, 0.30000001192092896),
                        fontFamily: 'Roboto',
                        fontSize: 22,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff66466E),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff66466E),
                        ),
                      ),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 20.0,
                      //backgroundColor: Colors.white,
                    ),
                  ),
                  width: 374,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: Color.fromRGBO(64, 22, 75, 1),
                  ),
                ),
*/