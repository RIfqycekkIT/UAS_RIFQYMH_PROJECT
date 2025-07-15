import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:poli_app2/app/data/models/poli.dart';

import '../controllers/poli_controller.dart';

class PoliView extends GetView<PoliController> {
  const PoliView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PoliView'), centerTitle: true),
      body: Center(child: _PoliPage()),
    );
  }
}

class _PoliPage extends StatefulWidget {
  @override
  _PoliPageState createState() => _PoliPageState();
}

class _PoliPageState extends State<_PoliPage> {
  PoliController ctrl = Get.put(PoliController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() {
        if (ctrl.isLoading.value) {
          return Text("Loading...");
        }
        return FutureBuilder<Poli>(
          future: ctrl.futurePoli,
          builder: (ctx, snap) {
            if (!snap.hasData) {
              return Text("Kosong!");
            }
            return ListView.builder(
              itemCount: snap.data!.ListPoli.length,
              itemBuilder: (ctx, index) {
                var poli = snap.data!.ListPoli[index];
                return Container(
                  decoration: BoxDecoration(border: Border.all()),
                  padding: EdgeInsets.all(14),
                  child: Column(children: [Text(poli.nama), Text(poli.jenis)]),
                );
              },
            );
          },
        );
      }),
    );
  }
}
