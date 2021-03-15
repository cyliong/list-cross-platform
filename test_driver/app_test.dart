// @dart=2.9

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  final listTitleFinder = find.byValueKey('list_title');
  final addButtonFinder = find.byValueKey('add_button');
  final saveButtonFinder = find.byValueKey('save_button');
  final itemTextFieldFinder = find.byValueKey('item_text_field');

  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  test('Add an item to the list', () async {
    const newItem = 'Item 1';

    // Given I am on the list page
    expect(await driver.getText(listTitleFinder), 'List');

    // When I add a new item
    await driver.tap(addButtonFinder);
    await driver.tap(itemTextFieldFinder);
    await driver.enterText(newItem);
    await driver.tap(saveButtonFinder);

    // Then I should see the new item on the list
    await driver.waitFor(find.text(newItem), timeout: Duration(seconds: 5));
  });
}
