import 'package:dashcast/main_controller.dart';
import 'package:dashcast/wave.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    ),
  );
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teste Wave"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Wave sound',
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Wave(
                  size: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.width,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Get.find<MainController>().toggle,
        tooltip: 'Toggle Play',
        child: GetX<MainController>(
          builder: (controller) {
            return controller.isPlaying
                ? Icon(Icons.pause)
                : Icon(Icons.play_arrow);
          },
        ),
      ),
    );
  }
}
