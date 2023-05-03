import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:material_button_assist/src/assists/utils.dart';

class ConvertToOtherButton extends DartAssist {
  ConvertToOtherButton({
    required this.targetType,
  });
  final MaterialButtonType targetType;
  late final baseType = getBaseType(
    exclude: targetType != MaterialButtonType.filled ? targetType : null,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    SourceRange target,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      // Select from "new" to the opening bracket
      if (!target.intersects(node.constructorName.sourceRange)) return;

      final createdType = node.constructorName.type.type;
      if (createdType == null || !baseType.isExactlyType(createdType)) {
        return;
      }

      final simpleIdentifier = node.constructorName.name;
      final isFilledButton = filledButtonType.isExactlyType(createdType);
      final isTonal =
          simpleIdentifier != null && simpleIdentifier.name == 'tonal';

      if (isFilledButton) {
        if (isTonal) {
          if (targetType == MaterialButtonType.filledTonal) return;
        } else {
          if (targetType == MaterialButtonType.filled) return;
        }
      }

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Convert to ${targetType.buttonName}',
        priority: targetType.priority,
      );

      changeBuilder.addDartFileEdit(
        (builder) {
          builder.addSimpleReplacement(
            node.constructorName.sourceRange,
            targetType.constructorName,
          );
        },
      );
    });
  }
}
