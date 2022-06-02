import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:susanin/presentation/screens/tutorial/models/slide_model.dart';
import 'package:susanin/presentation/screens/tutorial/widgets/slide_tile.dart';
import 'package:susanin/presentation/screens/tutorial/widgets/tutorial_bottom_sheet.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<TutorialScreen> {
  List<SlideModel> slides = [];
  int currentIndex = 0;
  PageController pageController = PageController();

  @override
  void didChangeDependencies() {
    slides = getSlides(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: Theme.of(context).brightness == Brightness.dark
            ? SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Theme.of(context).scaffoldBackgroundColor)
            : SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Theme.of(context).scaffoldBackgroundColor),
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary,
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).scaffoldBackgroundColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 5.0),
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: slides.length,
                    onPageChanged: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      return SlideTile(
                        title: slides[index].title,
                        topContent: slides[index].topContent,
                        bottomContent: slides[index].bottomContent,
                        height: size.height,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: TutorialBottomSheet(
        pageController: pageController,
        currentIndex: currentIndex,
        slideQuantity: slides.length,
      ),
    );
  }
}
