import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class InvoiceQrDialog extends StatelessWidget {
  final String headerTitle;
  final String? typeTitle;
  final String? data;
  final String? scanType;
  final String? date;
  final VoidCallback? copyAction;
  final VoidCallback? shareAction;
  final VoidCallback? saveAction;
  final VoidCallback? backAction;
  final MobileScannerController controller;
  const InvoiceQrDialog({
    super.key,
    this.backAction,
    required this.headerTitle,
    this.typeTitle,
    this.data,
    this.scanType,
    this.date,
    this.copyAction,
    this.shareAction,
    this.saveAction,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.start();

        return true;
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: Colors.blueAccent, width: 1.2),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔹 Header
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: backAction,
                  ),
                  const Spacer(),
                  Text(
                    headerTitle,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(flex: 2),
                ],
              ),

              const SizedBox(height: 12),

              // 🔹 QR Info Card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0xff4338CA),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: Text(
                        typeTitle ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Content
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(data ?? '', style: TextStyle(fontSize: 13)),
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 🔹 Meta Info
              _infoRow('Scan Type', scanType ?? ''),
              _infoRow('Date', date ?? ''),

              const SizedBox(height: 20),

              // 🔹 Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _actionButton(Icons.copy, 'Copy', action: copyAction),
                  _actionButton(Icons.share, 'Share', action: shareAction),
                  _actionButton(Icons.save_alt, 'Save', action: saveAction),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$title ', style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  static Widget _actionButton(
    IconData icon,
    String label, {
    VoidCallback? action,
  }) {
    return OutlinedButton.icon(
      onPressed: action,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
