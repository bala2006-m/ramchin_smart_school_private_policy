import 'dart:html' as html;

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Privacy Policy - Ramchin Smart School',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const PrivacyPolicyPage(),
    );
  }
}

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  final String _policyText = _defaultPolicy;

  void _printOrSavePdf() {
    // For web, window.print() opens print dialog where user can Save as PDF.
    html.window.print();
  }

  void _copyToClipboard() async {
    try {
      if (html.window.navigator.clipboard != null) {
        await html.window.navigator.clipboard!.writeText(_policyText);
      } else {
        // Fallback for older browsers
        final textArea = html.TextAreaElement();
        textArea.value = _policyText;
        html.document.body!.append(textArea);
        textArea.select();
        html.document.execCommand('copy');
        textArea.remove();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Privacy policy copied to clipboard')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to copy: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Privacy Policy'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: isWide ? 800 : double.infinity,
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(child: _buildPolicyCard()),
        ),
      ),
    );
  }

  Widget _buildPolicyCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SelectableText(
              _policyText,
              style: const TextStyle(fontSize: 14, height: 1.45),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Tooltip(
                  message: 'Print or save as PDF',
                  child: ElevatedButton(
                    onPressed: _printOrSavePdf,
                    child: const Text('Print / Save'),
                  ),
                ),
                const SizedBox(width: 10),
                Tooltip(
                  message: 'Copy policy text to clipboard',
                  child: ElevatedButton(
                    onPressed: _copyToClipboard,
                    child: const Text('Copy'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

const String _defaultPolicy = '''Privacy Policy for Ramchin Smart School

Welcome to Ramchin Smart School. This Privacy Policy explains how we collect, use, and protect personal information for students, parents, teachers, and school staff when using our Attendance Management App.

1. Information We Collect
- Personal Information: student name, date of birth, gender, photo; parent or guardian contact information; teacher and staff contact info.
- Attendance Data: presence/absence records, timestamps, notes.
- Device & Technical Information: device type, OS, app version, IP address for security.

2. How We Use Information
We use data to manage attendance, generate reports, and improve our services.

3. Data Sharing
We do not sell personal information. We may share data with schools, authorized staff, third-party service providers (hosting, analytics), and law enforcement if required.

4. Data Security
We use appropriate technical and organizational measures, including encryption in transit and at rest, and access controls. No system is 100% secure.

5. Data Retention
We retain data only as long as necessary for the purposes described or as required by law. Schools may configure retention periods.

6. Your Rights
You may request access, correction, deletion, or portability of your data by contacting support.

7. Children's Privacy
We take special care to protect children's data and only collect information as required by schools with appropriate consent.

8. Contact
For questions, contact: ramchintech@gmail.com
''';
