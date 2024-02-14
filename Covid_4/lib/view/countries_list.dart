import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/services/states_services.dart';
import 'package:flutter_application_4/view/details_screen.dart';

import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextFormField(
              controller: searchcontroller,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Search with country name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: statesServices.countriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade500,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  } else {}
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (searchcontroller.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              name: snapshot.data![index]
                                                  ['country'],
                                              totalClass: snapshot.data![index]
                                                      ['cases']
                                                  .toString(),
                                              todayRecovered: snapshot
                                                  .data![index]['recovered']
                                                  .toString(),
                                              totalDeaths: snapshot.data![index]
                                                      ['todayDeaths']
                                                  .toString(),
                                              active: snapshot.data![index]
                                                      ['active']
                                                  .toString(),
                                              test: snapshot.data![index]
                                                      ['tests']
                                                  .toString(),
                                              totalRecovered: snapshot
                                                  .data![index]
                                                      ['totalRecovered']
                                                  .toString(),
                                              critical: snapshot.data![index]
                                                      ['critical']
                                                  .toString(),
                                            )),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    snapshot.data![index]['country'],
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index]['cases'].toString(),
                                  ),
                                  leading: Image(
                                      height: 70,
                                      width: 70,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag'])),
                                ),
                              )
                            ],
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchcontroller.text.toLowerCase())) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              name: snapshot.data![index]
                                                  ['country'],
                                              totalClass: snapshot.data![index]
                                                  ['cases'],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ['todayRecovered'],
                                              totalDeaths: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              active: snapshot.data![index]
                                                  ['active'],
                                              test: snapshot.data![index]
                                                  ['tests'],
                                              totalRecovered:
                                                  snapshot.data![index]
                                                      ['totalRecovered'],
                                              critical: snapshot.data![index]
                                                  ['critical'],
                                            )),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    snapshot.data![index]['country'],
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index]['cases'].toString(),
                                  ),
                                  leading: Image(
                                      height: 70,
                                      width: 70,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag'])),
                                ),
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      });
                }),
          ),
        ],
      )),
    );
  }
}
