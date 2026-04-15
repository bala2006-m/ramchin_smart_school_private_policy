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
    html.window.print();
  }

  void _copyToClipboard() async {
    try {
      if (html.window.navigator.clipboard != null) {
        await html.window.navigator.clipboard!.writeText(_policyText);
      } else {
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
                ElevatedButton(
                  onPressed: _printOrSavePdf,
                  child: const Text('Print / Save'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _copyToClipboard,
                  child: const Text('Copy'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

const String _defaultPolicy = '''
Privacy Policy for Ramchin Smart School

Welcome to Ramchin Smart School. This Privacy Policy explains how we collect, use, and protect personal information for students, parents, teachers, and school staff when using our Attendance Management App.

1. Information We Collect
- Personal Information: student name, date of birth, gender, and profile photo; parent or guardian contact information; teacher and staff contact details.
- Attendance Data: presence/absence records, timestamps, and notes.
- Device & Technical Information: device type, operating system, app version, and IP address for security purposes.

2. How We Use Information
We use collected data to:
- Manage student attendance
- Generate reports for schools
- Improve app functionality and performance

3. Data Sharing
We do NOT sell personal data. Data may be shared with:
- Schools and authorized staff
- Trusted service providers (hosting, analytics)
- Legal authorities if required by law

4. Data Security
We implement appropriate security measures including encryption and access control to protect user data.

5. Data Retention
We retain data only as long as necessary for operational and legal purposes. Schools may configure retention policies.

6. User Rights
Users may request access, correction, or deletion of their data by contacting support.

7. Children's Privacy
We prioritize children's data protection and only collect necessary information with proper authorization from schools and guardians.

8. Contact Us
For questions or concerns:
Email: ramchintech@gmail.com

9. Photo and Video Permissions
Our app may request access to the device camera and media storage strictly for core functionality such as:

- Capturing student profile photos
- Uploading images for identification and attendance verification

We ensure:
- Permissions are requested only when the user performs an action (e.g., taking or uploading a photo)
- No background access to photos or videos
- No use of media for advertising or tracking

All images are securely stored and accessible only to authorized school personnel.

We do NOT:
- Access media without user interaction
- Collect unnecessary photos or videos
- Use media data for analytics or ads
''';
