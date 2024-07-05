import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'answers_page.dart';

class SecondPage extends StatefulWidget {
  final String name;
  final int age;
  final String audioFilePath;

  SecondPage({required this.name, required this.age, required this.audioFilePath});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  File? _selfieFile;
  Position? _position;

  Future<void> _pickSelfie() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );

    if (image != null) {
      _selfieFile = File(image.path);
      _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {});
    }
  }

  Future<void> _submitForm() async {
    // Save selfie and recording to local storage
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String imagePath = '${appDir.path}/selfie.png';
    final String audioPath = '${appDir.path}/recording.wav';

    // Save selfie
    if (_selfieFile != null) {
      await _selfieFile!.copy(imagePath);
    }

    // Save recording
    final recordingFile = File(widget.audioFilePath);
    await recordingFile.copy(audioPath);

    // Save JSON data
    final Map<String, dynamic> data = {
      "Name": widget.name,
      "Q1": widget.age,
      "Q2": imagePath,
      "recording": audioPath,
      "submit_time": DateTime.now().toString(),
    };
    final String jsonString = jsonEncode(data);
    final File jsonFile = File('${appDir.path}/answers.json');
    await jsonFile.writeAsString(jsonString);

    // Navigate to answers page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AnswersPage(data)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Form - Step 2'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _pickSelfie,
                child: Text('Upload your selfie'),
              ),
              SizedBox(height: 20),
              if (_selfieFile != null && _position != null)
                Text('Selfie captured at: ${_position!.latitude}, ${_position!.longitude}'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
