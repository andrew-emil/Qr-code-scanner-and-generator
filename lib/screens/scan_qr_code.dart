import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  String _qrResult = 'Scanned data will appear here';
  String _launchQrRes = '';

  bool _isURL(String qrRes) {
    Uri? uri = Uri.tryParse(qrRes);
    return uri != null &&
        (uri.isAbsolute && (uri.hasScheme || uri.hasAuthority));
  }


  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      setState(() => _launchQrRes = 'Couldn\'t launch URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan Qr Code',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: _isURL(_qrResult)
                  ? () => _launchURL(_qrResult)
                  : () {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_launchQrRes.isNotEmpty
                              ? _launchQrRes
                              : 'Invalid URL'),
                          duration: const Duration(seconds: 4),
                        ),
                      );
                    },
              child: Text(
                _qrResult == '-1' ? 'Scanned data will appear here' : _qrResult,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  decoration: _isURL(_qrResult)
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () async {
                var res = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const SimpleBarcodeScannerPage(),
                  ),
                );
                setState(() => _qrResult = res.toString());
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                    Theme.of(context).colorScheme.onPrimary),
              ),
              child: const Text(
                'Scan QR Code',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
