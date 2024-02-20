import 'package:auto_step/auto_step.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Step Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Auto Step Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Center(
            child: AutoStep(
                total: 3,
                duration: Duration(milliseconds: 1000),
                builder: (step) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: 100.0 * step,
                    height: 100,
                    color: Colors.green,
                  );
                }),
          ),
          Center(
            child: SizedBox(
              height: 100,
              child: Stack(
                children: [
                  AutoStepSwitch(
                      duration: Duration(milliseconds: 3000),
                      builder: (step) => AnimatedAlign(
                            alignment: step
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            duration: Duration(milliseconds: 2000),
                            child: Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                            ),
                          ))
                ],
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 300,
              child: AutoStep(
                total: 3,
                duration: Duration(milliseconds: 750),
                builder: (step) {
                  tabController.animateTo(step-1);
                  return Column(
                    children: [
                      TabBar(controller: tabController, tabs: [
                        Tab(
                          text: "One",
                        ),
                        Tab(
                          text: "Two",
                        ),
                        Tab(
                          text: "Three",
                        ),
                      ]),
                      Expanded(
                          child: TabBarView(controller: tabController, children: [
                        Center(child: Text("Page One")),
                        Center(child: Text("Page Two")),
                        Center(child: Text("Page Three")),
                      ]))
                    ],
                  );
                }
              ),
            ),
          )
        ],
      ),
    );
  }
}
