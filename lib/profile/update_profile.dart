import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:notex/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _updatedName = TextEditingController();
  int _updatedSem = 0;
  String _updatedBranch = "";

  @override
  Widget build(BuildContext context) {
    void onButtonPressed(int index) {
      setState(() {
        _updatedSem = index;
      });
    }

    void onButtonPressed1(String index) {
      setState(() {
        _updatedBranch = index;
      });
    }

    // buttons list

    List<String> buttonsText = ["CSE", "ECE"];

    // buttons

    List<Widget> buttons = List.generate(
      buttonsText.length,
      (index) {
        return ElevatedButton(
          onPressed: () {
            onButtonPressed1(buttonsText[index]);
          },
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(100, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(width: 1)),
            foregroundColor: _updatedBranch == buttonsText[index]
                ? Colors.white
                : Colors.black,
            backgroundColor: _updatedBranch == buttonsText[index]
                ? Colors.black
                : Colors.white,
          ),
          child: Text(
            buttonsText[index],
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w400,
              fontSize: _updatedBranch == buttonsText[index] ? 20 : 15,
            ),
          ),
        );
      },
      growable: true,
    );

// list 2

    List<String> buttonsText1 = [
      "I",
      "II",
      "III",
      "IV",
      "V",
      "VI",
      "VII",
      "VIII",
    ];

    List<Widget> buttons1 = List.generate(
      buttonsText1.length,
      (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: ElevatedButton(
            onPressed: () {
              onButtonPressed(index + 1);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(width: 1)),
              foregroundColor:
                  _updatedSem == index + 1 ? Colors.white : Colors.black,
              backgroundColor:
                  _updatedSem == index + 1 ? Colors.black : Colors.white,
            ),
            child: Text(
              buttonsText1[index],
              style: GoogleFonts.manrope(
                fontWeight: FontWeight.w600,
                fontSize: _updatedSem == index + 1 ? 20 : 13,
              ),
            ),
          ),
        );
      },
      growable: true,
    );

    save() async {
      if (_updatedName.text.trim().isEmpty) {
        showSnackBar(context, "plz enter your name");
      } else {
        // save data to auth0 and local storage
        SharedPreferences prefs = await SharedPreferences.getInstance();

        // profile screen

        await prefs.setString("username", _updatedName.text.trim());
        await prefs.setInt("semester", _updatedSem.toInt());
        await prefs.setString("branch", _updatedBranch);

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Navigation()),
        );
        // ignore: use_build_context_synchronously
        showSnackBar(context, "updated");
      }
    }

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 20),
        child: FloatingActionButton(
            elevation: 10,
            backgroundColor: Colors.black,
            onPressed: save,
            child: Icon(MdiIcons.contentSaveAll)),
      ),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 20, left: 10),
          child: Text(
            'Update Details',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 223, 223, 223),
        forceMaterialTransparency: true,
        toolbarHeight: 70,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
        children: [
          // name field

          Container(
            alignment: const Alignment(-0.9, 0),
            child: Text(
              "Name",
              softWrap: true,
              style: GoogleFonts.manrope(
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),

          // naME field

          Padding(
            padding: const EdgeInsets.only(top: 10, right: 20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(width: 1)),
              ),
              child: TextFormField(
                controller: _updatedName,
                keyboardType: TextInputType.name,
                textAlign: TextAlign.justify,
                scrollPhysics: const BouncingScrollPhysics(),
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  constraints: BoxConstraints(
                    minHeight: 50,
                    maxHeight: 100,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Name",
                  labelStyle: TextStyle(color: Colors.transparent),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),

          // sem

          Container(
            alignment: const Alignment(-0.9, 0),
            child: Text(
              "Semester",
              softWrap: true,
              style: GoogleFonts.manrope(
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),

          Wrap(children: buttons1),
          const SizedBox(height: 50),

          // branch

          Text(
            "Branch",
            softWrap: true,
            style: GoogleFonts.manrope(
              fontSize: 30,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 20),

          // branch nutton

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Wrap(
              spacing: wdth * 0.07,
              children: buttons,
            ),
          ),
        ],
      ),
    );
  }
}
