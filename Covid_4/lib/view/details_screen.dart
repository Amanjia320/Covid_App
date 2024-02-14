import 'package:flutter/material.dart';
import 'package:flutter_application_4/view/world_states.dart';

class DetailScreen extends StatefulWidget {
  String image;
  String name;
  String totalClass;
  String totalDeaths;
  String totalRecovered;
  String active;
  String critical;
  String todayRecovered;
  String test;

  DetailScreen({
    super.key,
    required this.image,
    required this.name,
    required this.totalClass,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .06),
                        ReusableRow(
                            title: 'cases',
                            value: widget.totalClass.toString()),
                        ReusableRow(
                            title: 'totalRecovered',
                            value: widget.totalRecovered.toString()),
                        ReusableRow(
                            title: 'totalDeaths',
                            value: widget.totalDeaths.toString()),
                        ReusableRow(
                            title: 'active', value: widget.active.toString()),
                        ReusableRow(
                            title: 'test', value: widget.test.toString()),
                        ReusableRow(
                            title: 'critical',
                            value: widget.critical.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ],
            )
          ]),
    );
  }
}
