import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/review/domain/review_repository.dart';
import 'view/home_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // ignore: discarded_futures
    _onInit().ignore();
  }

  Future<void> _onInit() async {
    final reviewRepository = context.read<ReviewRepository>();
    await reviewRepository.checkAndShowReviewPrompt(context);
  }

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}
