import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:gherkin/gherkin.dart';

class IAmIn extends Given1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
    final locator = find.byValueKey("log in as guest");
    await world.driver.tap(locator);
    final locator2 = find.byValueKey("session code");
    await world.driver.tap(locator2);
    await world.driver.enterText("404",timeout: Duration(seconds: 2));
    final locator3 = find.byValueKey("Go");
    await world.driver.tap(locator3);
    final locator4 = find.byValueKey(input1);
    var text = await world.driver.getText(locator4, timeout: Duration(seconds: 10));
    expect(text, "Session 404");
  }

  @override
  RegExp get pattern => RegExp(r"I am in a {string}");
}

class IInputInField extends And2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1, String input2) async {
    final locator = find.byValueKey(input2);
    await world.driver.tap(locator);
    await world.driver.enterText(input1,timeout: Duration(seconds: 2));
  }

  @override
  RegExp get pattern => RegExp(r"I input {string} in the {string} field");
  }

class IExpectDisplayed extends Then2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1, String input2) async {
    final locator = find.byValueKey(input1);
    var text = await world.driver.getText(locator, timeout: Duration(seconds: 2));
    expect(text, input2);
  }

  @override
  RegExp get pattern => RegExp(r"I expect the {string} {string} to be displayed");
}


