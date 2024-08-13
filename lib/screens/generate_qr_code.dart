import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQrCode extends StatefulWidget {
  const GenerateQrCode({super.key});

  @override
  State<GenerateQrCode> createState() => _GenerateQrCodeState();
}

class _GenerateQrCodeState extends State<GenerateQrCode> {
  final TextEditingController _qrController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Generate Qr Code',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_qrController.text.isNotEmpty)
                QrImageView(
                  data: _qrController.text,
                  size: 200,
                  eyeStyle: const QrEyeStyle(
                      color: Colors.white, eyeShape: QrEyeShape.square),
                  dataModuleStyle: const QrDataModuleStyle(
                      color: Colors.white,
                      dataModuleShape: QrDataModuleShape.square),
                  // foregroundColor: Colors.white,
                ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  autocorrect: false,
                  controller: _qrController,
                  decoration: InputDecoration(
                    hintText: 'Generate QR Code',
                    hintStyle: const TextStyle(color: Colors.white24),
                    label: const Text('Generate QR Code'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Text(
                  'Generate QR Code',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
