import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(CovidInfoApp());
}

class CovidInfoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Info COVID-19',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: InfoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  Map<String, dynamic>? globalData;
  Map<String, dynamic>? indonesiaData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCovidData();
  }

  Future<void> fetchCovidData() async {
    try {
      // Ubah URL sesuai alamat server FastAPI kamu
      final globalRes = await http.get(Uri.parse('http://127.0.0.1:8000/covid/global'));
      final indoRes = await http.get(Uri.parse('http://127.0.0.1:8000/covid/indonesia'));

      setState(() {
        globalData = json.decode(globalRes.body);
        indonesiaData = json.decode(indoRes.body);
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Widget buildCard(String title, Map<String, dynamic> data) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Divider(),
            Text("Kasus: ${data['cases']}"),
            Text("Meninggal: ${data['deaths']}"),
            Text("Sembuh: ${data['recovered']}"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi COVID-19'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                buildCard("🌍 Data Dunia", globalData!),
                buildCard("🇮🇩 Data Indonesia", indonesiaData!),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text("Nama: Rifqy Malikh Hanapi\nNIM: 230444040011\nValidasi: ✔️",
                      style: TextStyle(fontSize: 16)),
                )
              ],
            ),
    );
  }
}
