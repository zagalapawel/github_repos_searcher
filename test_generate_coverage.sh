flutter test --reporter expanded --coverage
OUTPUT=`lcov --remove coverage/lcov.info \
"lib/dio_provider.dart" \
"lib/api/**.dart" \
"lib/l10n/*.dart" \
"lib/router/**.dart" \
"lib/models/*/*.g.dart" \
"lib/models/*.g.dart" \
"lib/model/*.g.dart" \
"lib/screens/*/*_screen.dart" \
"lib/screens/*/widgets/*/*.dart" \
"lib/screens/*/*_route.dart" \
"lib/widgets/**.dart" \
"lib/environment/**.dart" \
"lib/application/**.dart" \
"lib/injector_container.dart" \
"lib/domain_injector.dart" \
"lib/remote_injector.dart" \
"lib/presentation.dart" \
"lib/extensions/*" \
"lib/common/**.dart" -o coverage/lcov_cleaned.info`
genhtml coverage/lcov_cleaned.info -o ../../coverage/$1-html