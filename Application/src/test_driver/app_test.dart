import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'dart:async';
import 'steps/enterSession_steps.dart';
import 'steps/logInGuest_steps.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/features/**.feature")]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter()
    ] // you can include the "StdoutReporter()" without the message level parameter for verbose log information
    //..hooks = [HookPrepare()]
    ..stepDefinitions = [
      IInScreen(),
      ITapButton(),
      IExpectLogIn(),
      IEnterScreen(),
      IInputCode(),
      ITapButton2(),
      IExpectGo(),
    ]
    ..customStepParameterDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart"
    ..exitAfterTestRun = true; // set to false if debugging to exit cleanly
  // ..tagExpression = "@smoke" // uncomment to see an example of running scenarios based on tag expressions
  return GherkinRunner().execute(config);
}