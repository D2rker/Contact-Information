import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'second_page.dart';

class ContactFormPage extends StatefulWidget {
  @override
  _ContactFormPageState createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  FlutterSoundRecorder? _audioRecorder;
  late String _audioFilePath;

  @override
  void initState() {
    super.initState();
    _audioRecorder = FlutterSoundRecorder();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await _audioRecorder!.openRecorder();
    _audioFilePath = '${(await getTemporaryDirectory()).path}/recording.wav';
    await Permission.microphone.request();
    _startRecording();
  }

  Future<void> _startRecording() async {
    await _audioRecorder!.startRecorder(
      toFile: _audioFilePath,
      codec: Codec.pcm16WAV,
    );
  }

  Future<void> _stopRecording() async {
    await _audioRecorder!.stopRecorder();
  }

  @override
  void dispose() {
    _audioRecorder!.closeRecorder();
    _audioRecorder = null;
    super.dispose();
  }

  void _navigateToSecondPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondPage(
          name: _nameController.text,
          age: int.parse(_ageController.text),
          audioFilePath: _audioFilePath,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Form - Step 1'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Enter your name'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Type your age'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _navigateToSecondPage,
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
