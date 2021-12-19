import 'package:get/get.dart';

class MainController extends GetxController{

  final _isPlaying = false.obs;

  bool get isPlaying => _isPlaying.value;

  void toggle() {
    _isPlaying.value = !_isPlaying.value;
    update();
  }
}