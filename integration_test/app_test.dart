import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:items/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final listTitleFinder = find.byWidgetPredicate((widget) =>
      widget is AppBar &&
      widget.title is Text &&
      (widget.title as Text).data == 'List');
  final addButtonFinder = find.byKey(Key('add_button'));
  final saveButtonFinder = find.byKey(Key('save_button'));
  final itemTextFieldFinder = find.byKey(Key('item_text_field'));

  testWidgets('Add an item to the list', (tester) async {
    const newItem = 'Item 1';

    app.main();
    await tester.pumpAndSettle();

    // Given I am on the list page
    expect(listTitleFinder, findsOneWidget);

    // When I add a new item
    await tester.tap(addButtonFinder);
    await tester.pumpAndSettle();
    await tester.tap(itemTextFieldFinder);
    await tester.enterText(itemTextFieldFinder, newItem);
    await tester.tap(saveButtonFinder);
    await tester.pumpAndSettle();

    // Then I should see the new item on the list
    expect(find.text(newItem), findsOneWidget);
  });
}
