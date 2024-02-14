import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_4/Model/world_states_model.dart';
import 'package:flutter_application_4/view/countries_list.dart';
import 'package:pie_chart/pie_chart.dart';

import '../services/states_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    StatesServices statesServices = StatesServices();
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                FutureBuilder(
                    future: statesServices.fecthWorldStatesRecords(),
                    builder:
                        (context, AsyncSnapshot<worldStatesModel> snapshot) {
                      if (!snapshot.hasData) {
                        return Expanded(
                            flex: 1,
                            child: SpinKitFadingCircle(
                              color: Colors.white,
                              size: 50.0,
                              controller: _controller,
                            ));
                      } else {
                        return Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total": double.parse(
                                    snapshot.data!.cases!.toString()),
                                "Recovered": double.parse(
                                    snapshot.data!.recovered!.toString()),
                                "Deaths": double.parse(
                                    snapshot.data!.deaths!.toString()),
                              },
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              chartRadius: 180,
                              legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left,
                              ),
                              animationDuration: Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              //colorList: colorList,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * .06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(
                                      title: 'Cases',
                                      value: snapshot.data!.cases.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'Recovered',
                                      value:
                                          snapshot.data!.recovered.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'Deaths',
                                      value: snapshot.data!.deaths.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'Active',
                                      value: snapshot.data!.active.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'TodayDeaths',
                                      value:
                                          snapshot.data!.todayDeaths.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'Critical',
                                      value: snapshot.data!.critical.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'TodayRecovered',
                                      value: snapshot.data!.todayRecovered
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CountriesListScreen()),
                                );
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 116, 248, 184),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Track Countries',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Divider(
            color: Colors.grey.shade200,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
