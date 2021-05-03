# list-cross-platform
This is a simple cross-platform list mobile app 
(to-do list, tasks, shopping list, recipes, and the like) 
written in Dart using the Flutter framework, 
for both Android and iOS platforms.

It showcases the implementation of CRUD operations 
with various Flutter programming techniques and patterns, including:
- State management with BLoC pattern 
  (`StreamController`, `Stream`, `StreamSink`, provider using `InheritedWidget`)
- Data access layer with Active Record pattern 
  (simplify data model creation using generics and inheritance)
- Database migration
- Store key-value data using `shared_preferences`
- Form validation with `GlobalKey<FormState>` and `FormFieldValidator`
- Singleton pattern with factory constructor
- Repository pattern
- Asynchronous programming with `Future`, `Stream`, `async` and `await`
- Migration to null safety

## Features
- Display a list of items (`StreamBuilder`, `ListView`, `ListTile`)
- Input form for adding and editing items (`Form`, `TextFormField`)
- Swipe to delete items (`Dismissible`)
- Store items in device's SQLite database using data model 
  (Active Record pattern, `sqflite`)
- Manage preferences with the Settings page

## Integration Test
The project also includes a sample implementation of integration test. 
The test scenario is written in behavior-driven development (BDD) style, 
to map to business specification created in Gherkin or Given-When-Then format.

To run the test, execute the following command from the root of the project:
```
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/app_test.dart
```

## Dependencies
- sqflite
- shared_preferences
- flutter_driver
- integration_test

## Requirements
- Flutter 2.0.6 or higher
- Dart 2.12.0 or higher
