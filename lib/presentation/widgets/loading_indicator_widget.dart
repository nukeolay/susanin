import 'package:flutter/material.dart';

class LoadingIndicator extends StatefulWidget {
  final Color startColor;
  final Color endColor;
  final int period;

  @override
  _LoadingIndicator createState() => _LoadingIndicator(startColor: startColor, endColor: endColor, period: period);

  LoadingIndicator({this.startColor, this.endColor, this.period});
}

class _LoadingIndicator extends State<LoadingIndicator> {
  Color startColor;
  Color endColor;
  int period;

  _LoadingIndicator({this.startColor, this.endColor, this.period});

  List<Color> colorList;

  @override
  void initState() {
    colorList = [startColor, endColor];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder<Color>(
        tween: ColorTween(begin: startColor, end: endColor),
        curve: Curves.linear,
        duration: Duration(milliseconds: period),
        onEnd: () => setState(() {
          if (startColor == colorList[0]) {
            startColor = colorList[1];
            endColor = colorList[0];
          } else {
            startColor = colorList[0];
            endColor = colorList[1];
          }
        }),
        builder: (_, Color color, __) {
          return AnimatedContainer(
            duration: Duration(milliseconds: period),
            //width: 20,
            //height: 20,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [endColor, color, startColor])),
          );
        },
      ),
    );
  }
}