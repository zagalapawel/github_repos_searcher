# Because of this: https://github.com/flutter/flutter/issues/27997#issue-410722816
#!/bin/sh
file=test/real_coverage_test.dart
printf "// ignore_for_file: unused_import\n" >> $file
find lib -type f \( -iname "*.dart" ! -iname "*.g.dart" ! -iname "*.freezed.dart" ! -iname "generated_plugin_registrant.dart" ! -name "*_event.dart" ! -name "*_state.dart" \) | cut -c4- | awk -v package="$1" '{printf "import '\''package:%s%s'\'';\n", package, $1}' >> $file
printf "\nvoid main(){}" >> $file