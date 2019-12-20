import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:gherkin/gherkin.dart';

class IEnterScreen extends Given1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
    final locator = find.byValueKey("log in as guest");
    await world.driver.tap(locator);
  }

  @override
  RegExp get pattern => RegExp(r"I enter the {string} screen");
}

class IInputCode extends When2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1, String input2) async {
    final locator = find.byValueKey(input1);
    await world.driver.tap(locator);
    await world.driver.enterText(input2,timeout: Duration(seconds: 2));
  }

  @override
  RegExp get pattern => RegExp(r"I input the {string} {string}");
}

class ITapButton2 extends And1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
    final locator = find.byValueKey(input1);
    await world.driver.tap(locator);
  }

  @override
  RegExp get pattern => RegExp(r"I tap the {string} button");
}

class IExpectGo extends Then2WithWorld<String, int, FlutterWorld> {
  @override
  Future<void> executeStep(String input1, int input2) async {
    final locator = find.byValueKey(input1);
    var text = await world.driver.getText(locator, timeout: Duration(seconds: 10));
    expect(text, "Session " + input2.toString());
  }

  @override
  RegExp get pattern => RegExp(r"I expect to go to the {string} {int}");
}


