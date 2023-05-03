import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:material_button_assist/src/assists/utils.dart';

class RemoveIcon extends DartAssist {
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
      if (createdType == null || !allButtonType.isExactlyType(createdType)) {
        return;
      }

      final simpleIdentifier = node.constructorName.name;
      final supportedIdentifier = getSupportedIdentifier(simpleIdentifier);

      if (supportedIdentifier == null ||
          supportedIdentifier == SupportedIdentifier.tonal) return;

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Remove icon',
        priority: addOrRemoveIconPriority,
      );

      changeBuilder.addDartFileEdit((builder) {
        if (supportedIdentifier == SupportedIdentifier.tonalIcon) {
          builder.addSimpleReplacement(
            node.constructorName.sourceRange,
            'FilledButton.tonal',
          );
        } else {
          builder.addSimpleReplacement(
            node.constructorName.sourceRange,
            node.constructorName.type.name.name,
          );
        }

        node.argumentList.arguments.forEach((argument) {
          if (argument is NamedExpression) {
            if (argument.name.label.name == 'label') {
              builder.addSimpleReplacement(
                argument.name.sourceRange,
                'child:',
              );
            }

            if (argument.name.label.name == 'icon') {
              builder.addDeletion(
                SourceRange(
                  argument.sourceRange.offset,
                  argument.sourceRange.length +
                      (argument.endToken.next?.lexeme == ',' ? 1 : 0),
                ),
              );
            }
          }
        });
      });
    });
  }
}
