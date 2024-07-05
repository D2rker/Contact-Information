import 'dart:io';
import 'package:flutter/material.dart';

class AnswersPage extends StatelessWidget {
  final Map<String, dynamic> data;

  AnswersPage(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submitted Answers'),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildAnswerRow('Name:', data['Name'].toString()),
                  SizedBox(height: 8),
                  _buildAnswerRow('Age:', data['Q1'].toString()),
                  SizedBox(height: 8),
                  _buildAnswerImageRow('Image:', File(data['Q2'])),
                  SizedBox(height: 8),
                  _buildAnswerRow('Recording:', data['recording']),
                  SizedBox(height: 8),
                  _buildAnswerRow('Submission Time:', data['submit_time']),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnswerRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerImageRow(String title, File imageFile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        Flexible(
          child: Image.file(
            imageFile,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
