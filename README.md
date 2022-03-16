# list-cross-platform
This is a simple cross-platform list mobile app 
(to-do list, tasks, shopping list, recipes, and the like) 
written in Dart using the Flutter framework, 
for both Android and iOS platforms.

It showcases the implementation of CRUD operations 
with various Flutter programming techniques and patterns, including:
- State management with `provider` and the MVVM pattern 
  (`ChangeNotifier`, `ChangeNotifierProvider`, `Consumer`)
- Data access layer with Active Record pattern 
  (simplify data model creation using generics and inheritance)
- Database migration
- Store key-value data using `shared_preferences`
- Form validation with `GlobalKey<FormState>` and `FormFieldValidator`
- Singleton pattern with factory constructor
- Repository pattern
- Asynchronous programming with `Future`, `async` and `await`
- Migration to sound null safety
- Simplify collection creation using spread operator and collection if

## Features
- Display a list of items (`ListView`, `ListTile`)
- Input form for adding and editing items (`Form`, `TextFormField`)
- Swipe to delete items (`Dismissible`)
- Display delete confirmation dialog based on settings (`AlertDialog`)
- Manage preferences with the Settings page
- Store items in device's SQLite database using data model 
  (Active Record pattern, `sqflite`)

## Integration Test
The project also includes a sample implementation of integration test. 
The test scenario is written in behavior-driven development (BDD) style, 
to map to business specification created in Gherkin or 
Given-When-Then format.

To run the test, execute the following command from 
the root of the project:
```
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/app_test.dart
```

## State Management
The project is using the `provider` package and MVVM pattern to manage
the app state. Alternatively, an implementation using the BLoC pattern
can be found on the 
[bloc](https://github.com/cyliong/list-cross-platform/tree/bloc) branch.

## Dependencies
- sqflite
- shared_preferences
- provider
- flutter_driver
- integration_test

## Requirements
- Flutter 2.10.3 or higher
- Dart 2.16.1 or higher
