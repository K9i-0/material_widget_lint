import 'package:analyzer/dart/ast/ast.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const convertToOtherButtonPriority = 27;
const addOrRemoveIconPriority = 27;

enum MaterialButtonType {
  elevated(
    buttonName: 'ElevatedButton',
    className: 'ElevatedButton',
    priority: convertToOtherButtonPriority,
    typeChecker: TypeChecker.fromName(
      'ElevatedButton',
      packageName: 'flutter',
    ),
  ),
  filled(
    buttonName: 'FilledButton',
    className: 'FilledButton',
    priority: convertToOtherButtonPriority,
    typeChecker: TypeChecker.fromName(
      'FilledButton',
      packageName: 'flutter',
    ),
  ),
  filledTonal(
    buttonName: 'FilledTonalButton',
    className: 'FilledButton',
    priority: convertToOtherButtonPriority,
    typeChecker: TypeChecker.fromName(
      'FilledButton',
      packageName: 'flutter',
    ),
  ),
  outlined(
    buttonName: 'OutlinedButton',
    className: 'OutlinedButton',
    priority: convertToOtherButtonPriority,
    typeChecker: TypeChecker.fromName(
      'OutlinedButton',
      packageName: 'flutter',
    ),
  ),
  text(
    buttonName: 'TextButton',
    className: 'TextButton',
    priority: convertToOtherButtonPriority,
    typeChecker: TypeChecker.fromName(
      'TextButton',
      packageName: 'flutter',
    ),
  );

  const MaterialButtonType({
    required this.buttonName,
    required this.className,
    required this.priority,
    required this.typeChecker,
  });
  final String buttonName;
  final String className;
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

final filledButtonType = TypeChecker.fromName(
  'FilledButton',
  packageName: 'flutter',
);

enum SupportedIdentifier {
  icon,
  tonal,
  tonalIcon,
}

extension SupportedIdentifierX on SupportedIdentifier? {
  bool get isTonal {
    switch (this) {
      case SupportedIdentifier.icon:
        return false;
      case SupportedIdentifier.tonal:
        return true;
      case SupportedIdentifier.tonalIcon:
        return true;
      default:
        return false;
    }
  }

  bool get hasIcon {
    switch (this) {
      case SupportedIdentifier.icon:
        return true;
      case SupportedIdentifier.tonal:
        return false;
      case SupportedIdentifier.tonalIcon:
        return true;
      default:
        return false;
    }
  }
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
