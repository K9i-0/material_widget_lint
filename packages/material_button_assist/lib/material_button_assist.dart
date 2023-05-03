library material_button_assist;

import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:material_button_assist/src/assists/convert_to_other_button.dart';

PluginBase createPlugin() => _MaterialButtonAssist();

class _MaterialButtonAssist extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => const [];

  @override
  List<Assist> getAssists() => [
        ...MaterialButtonType.values
            .map((buttonType) => ConvertToOtherButton(targetType: buttonType))
            .toList(),
      ];
}
