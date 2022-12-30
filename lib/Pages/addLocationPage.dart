import 'package:flutter/material.dart';
import 'package:weather/Components/background.dart';
import 'package:weather/Pages/HomePage.dart';
import '../Repository/get_Information.dart';
import '../Style/style.dart';
import '../Style/textStyle.dart';
import '../store/local_store.dart';

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
              style: PrimaryTextStyle.normal(textColor: Style.whiteColor),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xff2E335A).withOpacity(0.95),
                  border: OutlineInputBorder(
                      borderRadius: Style.primaryRadius,
                      borderSide: BorderSide(
                          color: locateEmpty
                              ? Style.redColor
                              : Style.borderColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: Style.primaryRadius,
                      borderSide: BorderSide(
                          color: locateEmpty
                              ? Style.redColor
                              : Style.borderColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: Style.primaryRadius,
                      borderSide: BorderSide(
                          color: locateEmpty
                              ? Style.redColor
                              : Style.borderColor)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                  hintText: "Locate",
                  hintStyle:
                      PrimaryTextStyle.normal(textColor: Style.textColor)),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Style.brandColor,
        onPressed: () async {
          if (textEditingController.text.isNotEmpty) {
            var data = await GetInformationRepository.getInformationWeather(
                textEditingController.text);

            LocalStore.setCountry(textEditingController.text);
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const HomePage(),
                ),
                (route) => false);
            if (data["error"] == null) {
            } else {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    data["error"].toString(),
                  ),
                ),
              );
            }
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
