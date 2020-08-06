# list-cross-platform
This is a simple cross-platform list mobile app (to-do list, tasks, shopping list, recipes, and the like) showcasing the implementation of CRUD operations, written in Dart using the Flutter framework, for both Android and iOS platforms.

## Features
- Display a list of items (`FutureBuilder`, `ListView`, `ListTile`)
- Input dialog for adding and editing items (`AlertDialog`)
- Swipe to delete items (`Dismissible`)
- Store items in device's SQLite database using data model (Active Record pattern, `sqflite`)

## Data Access Layer
The project implements a data access layer with the Active Record pattern. It uses generics and inheritance to make the creation of data models easier.

## Integration Test
The project also includes a sample implementation of integration test. The test scenario is written in behavior-driven development (BDD) style, to map to business specification created in Gherkin or Given-When-Then format.

To run the test, execute the following command from the root of the project:

`flutter drive --target=test_driver/app.dart`

## Dependencies
- sqflite
- flutter_driver

## Requirements
- Flutter 1.20.0 or higher
- Dart 2.9.0 or higher

