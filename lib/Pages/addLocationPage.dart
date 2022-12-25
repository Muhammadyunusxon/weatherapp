import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/Components/backgraund.dart';

import '../Style/style.dart';
import 'HomePage.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({Key? key}) : super(key: key);

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  bool locateEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: TextFormField(
              onChanged: (s) {
                locateEmpty = false;
                setState(() {});
              },
              controller: textEditingController,
              style: Style.textStyleNormal(textColor: Style.whiteColor),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xff2E335A).withOpacity(0.95),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(color: Color(0xff1C1B33))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                          color: locateEmpty ? Colors.red : Color(0xff1C1B33))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                          color: locateEmpty ? Colors.red : Color(0xff1C1B33))),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                  hintText: "Locate",
                  hintStyle: Style.textStyleNormal(
                      textColor: Style.textColor)),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Style.brandColor,
        onPressed: () {
          if (textEditingController.text.isNotEmpty) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => HomePage(
                    location: textEditingController.text,
                  ),
                ),
                (route) => false);
          } else {
            locateEmpty = true;
            setState(() {});
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
