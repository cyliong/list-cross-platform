# list-cross-platform
This is a simple cross-platform list mobile app 
(to-do list, tasks, shopping list, recipes, and the like) 
written in Dart using the Flutter framework, 
for both Android and iOS platforms.

It showcases the implementation of CRUD operations 
with various Flutter programming techniques and patterns, including:
- State management with BLoC pattern (`StreamController`, `Stream`, `StreamSink`, 
provider using `InheritedWidget`)
- Data access layer with Active Record pattern 
(simplify data model creation using generics and inheritance)
- Singleton pattern with factory constructor
- Asynchronous programming with `Future`, `Stream`, `async` and `await`

## Features
- Display a list of items (`StreamBuilder`, `ListView`, `ListTile`)
- Input dialog for adding and editing items (`AlertDialog`)
- Swipe to delete items (`Dismissible`)
- Store items in device's SQLite database using data model (Active Record pattern, `sqflite`)

## Integration Test
The project also includes a sample implementation of integration test. The test scenario is written in behavior-driven development (BDD) style, to map to business specification created in Gherkin or Given-When-Then format.

To run the test, execute the following command from the root of the project:

`flutter drive --target=test_driver/app.dart`

## Dependencies
- sqflite
- flutter_driver

## Requirements
- Flutter 1.22.0 or higher
- Dart 2.10.0 or higher

