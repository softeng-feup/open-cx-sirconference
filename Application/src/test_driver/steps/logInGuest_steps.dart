import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:gherkin/gherkin.dart';

class IInScreen extends Given1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
    final locator = find.byValueKey(input1);
    var text = await world.driver.getText(locator, timeout: Duration(seconds: 2));
    expect(text, input1);
  }

  @override
  RegExp get pattern => RegExp(r"I am in the {string} screen");
}

class ITapButton extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
    final locator = find.byValueKey(input1);
    await world.driver.tap(locator);
  }

  @override
  RegExp get pattern => RegExp(r"I tap the {string} button");
}

class IExpectLogIn extends Then2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1, String input2) async {
    final locator = find.byValueKey(input1);
    var text = await world.driver.getText(locator, timeout: Duration(seconds: 2));
    expect(text, input2);
  }

  @override
  RegExp get pattern => RegExp(r"I expect to be logged in as {string} {string}");
}


