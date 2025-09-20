import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class UserGajal {
  final int? id;
  final String title;
  final String content;
  final DateTime createdAt;

  UserGajal({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory UserGajal.fromMap(Map<String, dynamic> map) {
    return UserGajal(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  // Initialize file-based storage system
  Future<void> initializeDatabase() async {
    try {
      print('Initializing file-based storage system...');

      // Test file storage
      final testGajal = UserGajal(
        title: 'Test Gajal',
        content: 'This is a test gajal for storage verification.',
        createdAt: DateTime.now(),
      );

      final testId = await insertGajalFallback(testGajal);
      print('Test gajal inserted to file with ID: $testId');

      // Delete the test gajal
      await deleteGajalFallback(testId);
      print('Test gajal deleted from file successfully');

      print('File-based storage system ready!');
    } catch (e) {
      print('Storage system initialization failed: $e');
      // Even if this fails, let the app continue
    }
  }

  Future<int> insertGajal(UserGajal gajal) async {
    // Use only file storage to completely avoid plugin issues
    print('Using file storage for saving gajal');
    return await insertGajalFallback(gajal);
  }

  Future<List<UserGajal>> getAllGajals() async {
    // Use only file storage to completely avoid plugin issues
    return await getAllGajalsFallback();
  }

  Future<int> updateGajal(UserGajal gajal) async {
    // Use only file storage to completely avoid plugin issues
    return await updateGajalFallback(gajal);
  }

  Future<int> deleteGajal(int id) async {
    // Use only file storage to completely avoid plugin issues
    return await deleteGajalFallback(id);
  }

  // File-based storage methods (no plugins required)
  Future<File> _getGajalsFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/user_gajals.json');
  }

  Future<int> insertGajalFallback(UserGajal gajal) async {
    try {
      final file = await _getGajalsFile();
      String gajalsJson = '[]';

      if (await file.exists()) {
        final content = await file.readAsString();
        // Handle empty file or whitespace-only content
        gajalsJson = content.trim().isEmpty ? '[]' : content;
      }

      // Additional safety check for JSON parsing
      List<dynamic> gajals;
      try {
        gajals = json.decode(gajalsJson);
      } catch (e) {
        print('Invalid JSON in file, resetting to empty array: $e');
        gajals = [];
        // Reset file with empty array
        await file.writeAsString('[]');
      }

      final newId = gajals.length + 1;
      final gajalWithId = UserGajal(
        id: newId,
        title: gajal.title,
        content: gajal.content,
        createdAt: gajal.createdAt,
      );

      gajals.add(gajalWithId.toMap());
      await file.writeAsString(json.encode(gajals));
      print('Gajal saved to file with ID: $newId');
      return newId;
    } catch (e) {
      print('Error saving to file: $e');
      rethrow;
    }
  }

  Future<List<UserGajal>> getAllGajalsFallback() async {
    try {
      final file = await _getGajalsFile();
      String gajalsJson = '[]';

      if (await file.exists()) {
        final content = await file.readAsString();
        // Handle empty file or whitespace-only content
        gajalsJson = content.trim().isEmpty ? '[]' : content;
      }

      // Additional safety check for JSON parsing
      List<dynamic> gajals;
      try {
        gajals = json.decode(gajalsJson);
      } catch (e) {
        print('Invalid JSON in file, returning empty list: $e');
        return [];
      }

      return gajals.map((json) => UserGajal.fromMap(json)).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      print('Error loading from file: $e');
      return [];
    }
  }

  Future<int> updateGajalFallback(UserGajal gajal) async {
    try {
      final file = await _getGajalsFile();
      String gajalsJson = '[]';

      if (await file.exists()) {
        final content = await file.readAsString();
        // Handle empty file or whitespace-only content
        gajalsJson = content.trim().isEmpty ? '[]' : content;
      }

      // Additional safety check for JSON parsing
      List<dynamic> gajals;
      try {
        gajals = json.decode(gajalsJson);
      } catch (e) {
        print('Invalid JSON in file, resetting to empty array: $e');
        gajals = [];
        await file.writeAsString('[]');
      }

      // Find and update the gajal
      for (int i = 0; i < gajals.length; i++) {
        if (gajals[i]['id'] == gajal.id) {
          gajals[i] = gajal.toMap();
          break;
        }
      }

      await file.writeAsString(json.encode(gajals));
      print('Gajal updated in file');
      return 1; // Return 1 to indicate success
    } catch (e) {
      print('Error updating in file: $e');
      rethrow;
    }
  }

  Future<int> deleteGajalFallback(int id) async {
    try {
      final file = await _getGajalsFile();
      String gajalsJson = '[]';

      if (await file.exists()) {
        final content = await file.readAsString();
        // Handle empty file or whitespace-only content
        gajalsJson = content.trim().isEmpty ? '[]' : content;
      }

      // Additional safety check for JSON parsing
      List<dynamic> gajals;
      try {
        gajals = json.decode(gajalsJson);
      } catch (e) {
        print('Invalid JSON in file, resetting to empty array: $e');
        gajals = [];
        await file.writeAsString('[]');
      }

      // Remove the gajal with matching ID
      gajals.removeWhere((gajal) => gajal['id'] == id);

      await file.writeAsString(json.encode(gajals));
      print('Gajal deleted from file');
      return 1; // Return 1 to indicate success
    } catch (e) {
      print('Error deleting from file: $e');
      rethrow;
    }
  }
}
