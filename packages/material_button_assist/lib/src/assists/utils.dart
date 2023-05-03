import 'package:analyzer/dart/ast/ast.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const convertToOtherButtonPriority = 27;
const addOrRemoveIconPriority = 27;

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

final allButtonType = TypeChecker.any(
  MaterialButtonType.values.map((e) => e.typeChecker),
);

final filledButtonType = TypeChecker.any([
  MaterialButtonType.filled.typeChecker,
  MaterialButtonType.filledTonal.typeChecker,
]);

enum SupportedIdentifier {
  icon,
  tonal,
  tonalIcon,
}

SupportedIdentifier? getSupportedIdentifier(
    SimpleIdentifier? simpleIdentifier) {
  switch (simpleIdentifier?.name) {
    case 'icon':
      return SupportedIdentifier.icon;
    case 'tonal':
      return SupportedIdentifier.tonal;
    case 'tonalIcon':
      return SupportedIdentifier.tonalIcon;
  }

  return null;
}
