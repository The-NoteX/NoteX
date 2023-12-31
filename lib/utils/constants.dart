import 'package:flutter/material.dart';
import 'package:notex/hackathon/explore_hackatho.dart';
import 'package:notex/internship/internship.dart';
import 'package:notex/notes/explore_notes.dart';
import 'package:notex/profile/profile.dart';

import '../notes/upload_notes.dart';

Color backgroundColor = Colors.amberAccent.shade200;

showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text(content)),
      duration: const Duration(seconds: 5),
    ),
  );
}

List<Widget> pages = [
  const ExploreNotes(),
  const InternshipPage(),
  const ExploreHackathons(),
  const UploadNotes(),
  const Profile(),
];

List<String> subjects = [
  "Maths",
  "Semi-conductors (theory)",
  "Semi-conductors (lab)",
  "Signals & Systems",
  "COA (lab)",
  "COA (theory)",
  "Data Structure",
  "Python (lab)",
  "Python (theory)",
  "Psychology",
  "Economics",
];

late double hght;
late double wdth;
