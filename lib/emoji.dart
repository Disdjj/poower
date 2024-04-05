import 'dart:math';

import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poower_flutter/timer.dart';

class EmojiWidget extends StatefulWidget {
  EmojiWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EmojiWidgetState();
  }
}

class _EmojiWidgetState extends State<EmojiWidget> with SingleTickerProviderStateMixin {
  // 默认是大便的emoji
  AnimatedEmojiData onEmoji = AnimatedEmojis.poop;

  late AnimatedEmoji animatedEmoji;

  // 是否运行中
  bool isRunning = false;

  // stopWatch
  final timerPage = CountUpTimerPage();

  late final AnimationController controller;

  AnimatedEmoji buildEmoji(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // 取宽度和高度中的较小值作为emoji的大小
    double size = min(screenWidth, screenHeight) * 0.9;

    return AnimatedEmoji(
      AnimatedEmojis.poop,
      // half screen
      controller: controller,
      size: size,
      animate: isRunning,
      repeat: true,
    );
  }

  @override
  void initState() {
    super.initState();
    // repeat
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    animatedEmoji = buildEmoji(context);
    return Scaffold(
      body: Column(
        children: [
          // 空白填充一个
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(flex: 2, child: GestureDetector(onTap: _onStartTap, child: animatedEmoji)),
          Expanded(
            flex: 1,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  timerPage,
                  GestureDetector(
                      onTap: _onClearTap,
                      child: AnimatedEmoji(
                        AnimatedEmojis.wave,
                        // half screen
                        size: 60,
                        animate: !isRunning,
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // onclick
  void _onStartTap() {
    setState(() {
      isRunning = !isRunning;
      animatedEmoji = buildEmoji(context);
      if (isRunning) {
        controller.forward();
        controller.repeat();
        timerPage.state.startTimer();
      } else {
        controller.stop();
        timerPage.state.stopTimer();
      }
    });
  }

  void _onClearTap() {
    if (timerPage.state.showDuration != "") {
      timerPage.state.resetTimer();
      // pop up
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Poower!'),
              content: Text(buildText(timerPage.state.startTime, timerPage.state.showDuration)),
              actions: <Widget>[
                TextButton(
                  child: const Text('懂你意思'),
                  onPressed: () {
                    // 点击确定按钮的操作
                    Navigator.of(context).pop(); // 关闭对话框
                  },
                ),
              ],
            );
          });
    }

    setState(() {
      isRunning = false;
      controller.reset();
      animatedEmoji = buildEmoji(context);
    });
  }
}

String buildText(DateTime start, String dur) {
  String formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(start);
  return "💩开始时间: $formattedDate\n🧻耗时: $dur";
}
