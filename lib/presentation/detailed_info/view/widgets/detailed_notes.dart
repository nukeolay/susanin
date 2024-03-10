import 'package:flutter/material.dart';

class DetailedNotes extends StatelessWidget {
  const DetailedNotes({required this.notes, super.key});
  final String notes;

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
      ),
      child: Text(notes),
    );
  }
}
