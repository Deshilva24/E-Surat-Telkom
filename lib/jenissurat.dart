import 'package:flutter/material.dart';
import 'lengkapidata.dart';

class PilihJenisSuratScreen extends StatelessWidget {
  const PilihJenisSuratScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'title': 'Surat Permintaan Isolir Layanan'},
      {'title': 'Surat Permintaan Ganti Nomor Layanan'},
      {'title': 'Surat Permintaan Pindah Alamat Layanan'},
      {'title': 'Surat Permintaan Berhenti Berlangganan'},
      {'title': 'Surat Permintaan Modifikasi Layanan'},
      {'title': 'Surat Permintaan Buka Isolir Sementara Layanan'},
      {'title': 'Surat Permintaan Balik Nama Layanan'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pilih Jenis Surat',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFDCDCDC),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.description_outlined,
                    size: 36,
                    color: Color(0xFF140F47),
                  ),
                ),
                Expanded(
                  child: Text(
                    item['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF140F47),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Mengirimkan jenisSurat yang dipilih
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LengkapiDataKTPScreen(
                          jenisSurat: item['title'],
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Pilih',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}