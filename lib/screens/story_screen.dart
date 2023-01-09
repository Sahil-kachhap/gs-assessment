import 'dart:io';

import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryScreen extends StatefulWidget {
  final String? filePath;
  const StoryScreen({this.filePath, super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>{
  final controller = StoryController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StoryView(
        onComplete: () => Navigator.pop(context),
        storyItems: [
          StoryItem.pageProviderImage(FileImage(File(widget.filePath!),),),
        ],
        controller: controller,
        inline: false,
        repeat: false,
      ),
    );
  }
}