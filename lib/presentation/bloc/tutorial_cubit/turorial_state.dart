import 'package:equatable/equatable.dart';

enum TutorialStatus {
  loading,
  loaded,
}

class TutorialState extends Equatable {
  final TutorialStatus tutorialStatus;
  final bool isFirstTime;

  const TutorialState({
    required this.tutorialStatus,
    required this.isFirstTime,
  });

  @override
  List<Object> get props => [
        tutorialStatus,
        isFirstTime,
      ];

  TutorialState copyWith({
    TutorialStatus? tutorialStatus,
    bool? isFirstTime,
  }) {
    return TutorialState(
      tutorialStatus: tutorialStatus ?? this.tutorialStatus,
      isFirstTime: isFirstTime ?? this.isFirstTime,
    );
  }
}
