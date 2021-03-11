import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/bloc/theme/theme_bloc.dart';
import 'package:susanin/domain/bloc/theme/theme_events.dart';
import 'package:susanin/domain/model/slider_model.dart';
import 'package:susanin/presentation/widgets/slide_tile_widget.dart';

import 'package:susanin/generated/l10n.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoardingScreen> {
  List<SlideModel> slides = [];
  int currentIndex = 0;
  PageController pageController = new PageController();

  Widget pageIndexIndicator(bool isCurrentPage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 5.0,
      width: isCurrentPage ? 10.0 : 5.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    slides = getSlides(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double padding = width * 0.01;
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: PageView.builder(
        controller: pageController,
        itemCount: slides.length,
        onPageChanged: (val) {
          setState(() {
            currentIndex = val;
          });
        },
        itemBuilder: (context, index) {
          return SlideTile(
            title: slides[index].getTitle,
            imagePath: slides[index].getImagePath,
            instruction: slides[index].getInstruction,
            width: width,
            height: height
          );
        },
      ),
      bottomSheet: currentIndex != slides.length - 1
          ? Container(
              color: Colors.white,
              height: Platform.isIOS ? 70.0 : 60.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: GestureDetector(
                        child: Text("${S.of(context).onBoardingButtonSkip}", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)),
                        onTap: () {
                          pageController.animateToPage(slides.length - 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
                        }),
                  ),
                  Row(
                    children: [
                      for (int i = 0; i < slides.length; i++) currentIndex == i ? pageIndexIndicator(true) : pageIndexIndicator(false),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                        child: Text("${S.of(context).onBoardingButtonNext}", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)),
                        onTap: () {
                          pageController.animateToPage(currentIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
                        }),
                  ),
                ],
              ),
            )
          : Container(
              color: Colors.white,
              height: Platform.isIOS ? 70.0 : 60.0,
              width: width,
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<ThemeBloc>(context).add(ThemeEventInstructionShowed());
                },
                child: Text(
                  "${S.of(context).onBoardingButtonStart}",
                  style: TextStyle(fontSize: 20.0, color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
    );
  }
}
