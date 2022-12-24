import 'package:flutter/material.dart';
import 'package:weather/model/weatherModel.dart';

import '../Repository/get_Information.dart';
import 'addLocationPage.dart';

class HomePage extends StatefulWidget {
  final String location;
  const HomePage({Key? key, this.location = 'Tashkent'}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  dynamic nameData;
  WeatherModel? weatherInfo;
  bool isLoading =true;
  int? status;
  getInformation() async {
    isLoading=true;
    setState(() {});
    nameData = await GetInformationRepository.getInformation(widget.location);
    weatherInfo=nameData;
    print(weatherInfo);
    status=GetInformationRepository.status;
    isLoading=false;
    setState(() {});

  }

  @override
  void initState() {
    getInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${widget.location.substring(0,1).toUpperCase()}${widget.location.substring(1).toLowerCase()}" ),
      ),
      body:isLoading?  const Center(child: CircularProgressIndicator()) :
      Container(
        height: MediaQuery.of(context).size.height/5,
        width: MediaQuery.of(context).size.width/2,
        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 18),
        color: Colors.cyan,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Name : ${nameData?.name ?? " "}"),
              const SizedBox(height: 10,),
              Text("Count : ${nameData?.count ?? " "}"),
              const SizedBox(height: 10,),
              Text("Gender : ${nameData?.gender ?? " "}"),
              const SizedBox(height: 10,),
              Text("Probability : ${nameData?.probability ?? " "}"),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const AddLocationPage()));
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
