import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:http/http.dart' as http;
import 'package:clipboard_watcher/clipboard_watcher.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const SnapSyncApp());
}

class SnapSyncApp extends StatelessWidget {
  const SnapSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnapSync',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with ClipboardListener {
  String lastReceivedText = "Waiting for clipboard sync...";
  final TextEditingController targetIpController = TextEditingController();
  HttpServer? server;

  @override
  void initState() {
    super.initState();
    clipboardWatcher.addListener(this);
    clipboardWatcher.start();
    _startLocalServer();
  }

  void _startLocalServer() async {
    final router = Router();
    router.post('/sync-clipboard', (Request request) async {
      final payload = await request.readAsString();
      final data = jsonDecode(payload);
      final text = data['text'] ?? '';
      
      setState(() {
        lastReceivedText = text;
      });
      await Clipboard.setData(ClipboardData(text: text));
      return Response.ok('Synced');
    });

    server = await shelf_io.serve(router.call, InternetAddress.anyIPv4, 8080);
  }

  void _sendClipboard(String targetIp) async {
    final clipData = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipData?.text != null && targetIp.isNotEmpty) {
      try {
        await http.post(
          Uri.parse('http://$targetIp:8080/sync-clipboard'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'text': clipData!.text}),
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✨ Synced to target device!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    clipboardWatcher.removeListener(this);
    clipboardWatcher.stop();
    server?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('⚡ SnapSync')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: targetIpController,
              decoration: const InputDecoration(
                labelText: 'Target Device IP (e.g. 192.168.1.15)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => _sendClipboard(targetIpController.text),
              icon: const Icon(Icons.send_rounded),
              label: const Text('Send Copied Clipboard Now'),
            ),
            const SizedBox(height: 24),
            const Text('Last Synced Data:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(lastReceivedText),
            ),
          ],
        ),
      ),
    );
  }
}
