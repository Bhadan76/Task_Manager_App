import 'package:flutter/material.dart';

void Showsnackbarmessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
