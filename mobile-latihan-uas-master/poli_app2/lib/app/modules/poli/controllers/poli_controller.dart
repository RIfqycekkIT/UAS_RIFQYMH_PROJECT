import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:poli_app2/app/data/models/poli.dart';

class PoliController extends GetxController {
  late Future<Poli> futurePoli;
  RxBool isLoading = true.obs;
  RxString errorMessage = "".obs;

  final baseUrl = "http://192.168.0.194:8000";
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    futurePoli = fetchData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<Poli> fetchData() async {
    try {
      isLoading.value = true;
      var response = await http.get(Uri.parse("${baseUrl}/poli"));
      if (response.statusCode == 200) {
        return Poli.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Gagal mengambil data");
      }
    } catch (e) {
      errorMessage.value = "Kesalahan mengambil data";
      throw Exception("Gagal mengambil data");
    } finally {
      isLoading.value = false;
    }
  }

  void increment() => count.value++;
}
