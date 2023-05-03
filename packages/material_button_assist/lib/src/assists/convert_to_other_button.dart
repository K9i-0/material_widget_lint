import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const convertToOtherButtonPriority = 26;

enum MaterialButtonType {
  elevated(
    buttonName: 'ElevatedButton',
    constructorName: 'ElevatedButton',
    priority: convertToOtherButtonPriority,
    typeChecker: TypeChecker.fromName(
      'ElevatedButton',
      packageName: 'flutter',
    ),
  ),
  filled(
    buttonName: 'FilledButton',
    constructorName: 'FilledButton',
    priority: convertToOtherButtonPriority,
    typeChecker: TypeChecker.fromName(
      'FilledButton',
      packageName: 'flutter',
    ),
  ),
  filledTonal(
    buttonName: 'FilledTonalButton',
    constructorName: 'FilledButton.tonal',
    priority: convertToOtherButtonPriority,
    typeChecker: TypeChecker.fromName(
      'FilledButton',
      packageName: 'flutter',
    ),
  ),
  outlined(
    buttonName: 'OutlinedButton',
    constructorName: 'OutlinedButton',
    priority: convertToOtherButtonPriority,
    typeChecker: TypeChecker.fromName(
      'OutlinedButton',
      packageName: 'flutter',
    ),
  ),
  text(
    buttonName: 'TextButton',
    constructorName: 'TextButton',
    priority: convertToOtherButtonPriority,
    typeChecker: TypeChecker.fromName(
      'TextButton',
      packageName: 'flutter',
    ),
  );

  const MaterialButtonType({
    required this.buttonName,
    required this.constructorName,
    required this.priority,
    required this.typeChecker,
  });
  final String buttonName;
  final String constructorName;
  final int priority;
  final TypeChecker typeChecker;
}

TypeChecker getBaseType({
  required MaterialButtonType? exclude,
}) {
  return TypeChecker.any(
    MaterialButtonType.values
        .where((e) => e != exclude)
        .map((e) => e.typeChecker),
  );
}

final filledButtonType = TypeChecker.any([
  MaterialButtonType.filled.typeChecker,
  MaterialButtonType.filledTonal.typeChecker,
]);

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
