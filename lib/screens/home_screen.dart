import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500; // 25*60
  late Timer timer;
  int totalSeconds = twentyFiveMinutes;
  int totalPomodoros = 0;
  bool isRunning = false;

  void onStartPressed() {
    setState(() {
      isRunning = true;
    });
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
      totalSeconds = twentyFiveMinutes;
      totalPomodoros = 0;
    });
  }

  void onTick(timer) {
    if (totalSeconds == 0) {
      timer.cancel();
      setState(() {
        isRunning = false;
        totalPomodoros++;
        totalSeconds = twentyFiveMinutes;
      });
    } else {
      setState(() {
        totalSeconds--;
      });
    }
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: IconButton(
                iconSize: 120,
                color: Theme.of(context).cardColor,
                onPressed: isRunning ? onPausePressed : onStartPressed,
                icon: isRunning
                    ? const Icon(
                        Icons.pause_circle_outlined,
                      )
                    : const Icon(
                        Icons.play_circle_outlined,
                      ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pomodoros',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                              ),
                            ),
                            Text(
                              '$totalPomodoros',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                              ),
                            ),
                          ],
                        ),
                        VerticalDivider(
                          color: Theme.of(context).textTheme.headline1!.color,
                          thickness: 2,
                          indent: 80,
                          endIndent: 80,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Reset",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            IconButton(
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                              iconSize: 42,
                              onPressed: onResetPressed,
                              icon: const Icon(
                                Icons.restore_outlined,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
