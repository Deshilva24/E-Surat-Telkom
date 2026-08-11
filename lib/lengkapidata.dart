import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'verifikasidata.dart';
import 'src/platform_file.dart';

class LengkapiDataKTPScreen extends StatefulWidget {
  final String jenisSurat;

  const LengkapiDataKTPScreen({super.key, required this.jenisSurat});

  @override
  State<LengkapiDataKTPScreen> createState() => _LengkapiDataKTPScreenState();
}

class _LengkapiDataKTPScreenState extends State<LengkapiDataKTPScreen> {
  XFile? _pickedFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _showImageSourceDialog() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF140F47)),
                title: const Text('Pilih dari Galeri'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera, color: Color(0xFF140F47)),
                title: const Text('Ambil Foto via Kamera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          // Reset file lama dan ganti dengan file baru
          _pickedFile = pickedFile;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil gambar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Lengkapi Data KTP',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFDCDCDC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: _pickedFile != null
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          buildPickedImage(_pickedFile!),
                          Positioned(
                            bottom: 12,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(20, 15, 71, 0.85),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: _showImageSourceDialog,
                              icon: const Icon(Icons.refresh, color: Colors.white, size: 18),
                              label: const Text(
                                'Ganti Foto',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.account_circle,
                            size: 110,
                            color: Colors.black45,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF140F47),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                            onPressed: _showImageSourceDialog,
                            child: const Text(
                              'Upload / Ambil Foto KTP',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 160,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF140F47),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (_pickedFile == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Silakan upload/ambil foto KTP terlebih dahulu!'),
                      ),
                    );
                    return;
                  }

                  // Mengirimkan file KTP yang baru dipikirkan ke VerifikasiDataScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VerifikasiDataScreen(
                        jenisSurat: widget.jenisSurat,
                        ktpImageFile: _pickedFile,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Scan Data',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}