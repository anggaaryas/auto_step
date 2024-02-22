import 'package:auto_step/auto_step.dart';
import 'package:auto_step/loop_mode.dart';
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
                duration: const Duration(milliseconds: 1000),
                builder: (step) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
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
                      duration: const Duration(milliseconds: 3000),
                      builder: (step) => AnimatedAlign(
                            alignment: step
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            duration: const Duration(milliseconds: 2000),
                            child: Container(
                              width: 64,
                              height: 64,
                              decoration: const BoxDecoration(
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
                  duration: const Duration(milliseconds: 750),
                  loopMode: const AutoStepReverseLoop(),
                  builder: (step) {
                    tabController.animateTo(step - 1);
                    return Column(
                      children: [
                        TabBar(controller: tabController, tabs: const [
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
                            child: TabBarView(
                                controller: tabController,
                                children: const [
                              Center(child: Text("Page One")),
                              Center(child: Text("Page Two")),
                              Center(child: Text("Page Three")),
                            ]))
                      ],
                    );
                  }),
            ),
          ),
          Center(
            child: AutoStepValues<BoxDecoration>(
              values:  [
                BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.red
                ),

                const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green
                ),

                const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.blue
                ),

                BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  border: Border.all(color: Colors.black)
                ),

              ],
              duration: List.generate(4, (index) => const Duration(milliseconds: 1000)),
              builder: (step) => AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: step,
                width: 100,
                height: 100,
              ),
            ),
          )
        ],
      ),
    );
  }
}
