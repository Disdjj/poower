import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CountUpTimerPage extends StatefulWidget {
  var state = _State();

  CountUpTimerPage({super.key});

  @override
  _State createState() => state;
}

class _State extends State<CountUpTimerPage> {
  final _isHours = false;

  DateTime startTime = DateTime.timestamp();
  int duration = 0;
  String showDuration = "";

  final StopWatchTimer stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        /// Display stop watch time
        StreamBuilder<int>(
          stream: stopWatchTimer.rawTime,
          initialData: stopWatchTimer.rawTime.value,
          builder: (context, snap) {
            final value = snap.data!;
            duration = value;
            final displayTime = StopWatchTimer.getDisplayTime(value, hours: _isHours);
            showDuration = displayTime;
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    displayTime,
                    style: const TextStyle(fontSize: 60, fontFamily: 'Helvetica', fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void startTimer() {
    startTime = DateTime.timestamp();
    stopWatchTimer.onStartTimer();
  }

  void stopTimer() {
    stopWatchTimer.onStopTimer();
  }

  void resetTimer() {
    stopWatchTimer.onResetTimer();
  }
}
