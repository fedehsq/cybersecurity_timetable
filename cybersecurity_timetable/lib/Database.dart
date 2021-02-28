import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Lesson.dart';

class MyDatabase {
  Future<Database> _database;

  Future<void> runDatabase() async {
    // Avoid errors caused by flutter upgrade.
    WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.
    _database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'lesson_database.db'),
      // When the database is first created, create a table to store object.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE lesson(n_hour TEXT PRIMARY KEY, name TEXT, start TEXT, "
              "end TEXT, abbreviazione TEXT, color INTEGER)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<void> insertLesson(Lesson lesson) async {
    // Get a reference to the database.
    final Database db = await _database;
    // Insert the Lesson into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'lesson',
      lesson.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertLessons(List<Lesson> lessons) async {
    // Get a reference to the database.
    final Database db = await _database;
    // Insert the Lesson into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    for (var lesson in lessons) {
      await db.insert(
        'lesson',
        lesson.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Lesson>> getLessons() async {
    // Get a reference to the database.
    final Database db = await _database;

    // Query the table for all The Lessons.
    final List<Map<String, dynamic>> maps = await db.query('lesson');

    // Convert the List<Map<String, dynamic> into a List<Lesson>.
    return List.generate(maps.length, (i) {
      return Lesson(
          maps[i]['n_hour'],
          maps[i]['name'],
          maps[i]['start'],
          maps[i]['end'],
          maps[i]['abbreviazione'],
          Color(maps[i]['color']),
      );
    });
  }
}
/*
    Future<void> updateLesson(Lesson dog) async {
    // Get a reference to the database.
      final db = await database;
    // Update the given Lesson.
      await db.update(
        'dogs',
        dog.toMap(),
    // Ensure that the Lesson has a matching id.
        where: "id = ?",
    // Pass the Lesson's id as a whereArg to prevent SQL injection.
        whereArgs: [dog.id],
      );
    }
    Future<void> deleteLesson(int id) async {
    // Get a reference to the database.
      final db = await database;
    // Remove the Lesson from the database.
      await db.delete(
        'dogs',
    // Use a `where` clause to delete a specific dog.
        where: "id = ?",
    // Pass the Lesson's id as a whereArg to prevent SQL injection.
        whereArgs: [id],
      );
    }
    var fido = Lesson(
      id: 0,
      name: 'Fido',
      age: 35,
    );
    // Insert a dog into the database.
    await insertLesson(fido);
    // Print the list of dogs (only Fido for now).
    print(await dogs());
    // Update Fido's age and save it to the database.
    fido = Lesson(
      id: fido.id,
      name: fido.name,
      age: fido.age + 7,
    );
    await updateLesson(fido);
    // Print Fido's updated information.
    print(await dogs());
    // Delete Fido from the database.
    await deleteLesson(fido.id);
    // Print the list of dogs (empty).
    print(await dogs());
  }
*/