# Linguality client for mobile apps


## Getting Started

## Github Actions
https://github.com/albert-gee/linguality-mobile/actions
https://www.geeksforgeeks.org/flutter-building-and-releasing-apk-using-github-actions/ - build apk


## Testing
flutter test integration_test/bot_test.dart

### Code Metrics
https://pub.dev/packages/dart_code_metrics
https://habr.com/ru/company/wrike/blog/552012/

#### Analyze
Reports code metrics, rules and anti-patterns violations. To execute the command, run

`flutter pub run dart_code_metrics:metrics analyze lib`

#### Check unnecessary nullable parameters
`flutter pub run dart_code_metrics:metrics check-unnecessary-nullable lib`

#### Check unused files
`flutter pub run dart_code_metrics:metrics check-unused-files lib`


#### Check unused code
`flutter pub run dart_code_metrics:metrics check-unused-code lib`
