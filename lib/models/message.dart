import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message {
  final String message;
  final String id;
  final Timestamp createdAt;

  Message({required this.id, required this.message, required this.createdAt});

  factory Message.fromJson(Map<String, dynamic> jsonData) {
    return Message(
      id: jsonData['id'] ?? '',
      message: jsonData['messages'] ?? '',
      createdAt: jsonData['date'] ?? Timestamp.now(),
    );
  }

  get imageUrl => null;
}
