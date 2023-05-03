import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:material_button_assist/src/assists/utils.dart';

class AddIcon extends DartAssist {
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

      if (supportedIdentifier == SupportedIdentifier.icon ||
          supportedIdentifier == SupportedIdentifier.tonalIcon) return;

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Add icon',
        priority: addOrRemoveIconPriority,
      );

      changeBuilder.addDartFileEdit((builder) {
        if (supportedIdentifier == SupportedIdentifier.tonal) {
          builder.addSimpleReplacement(
            node.constructorName.sourceRange,
            'FilledButton.tonalIcon',
          );
        } else {
          builder.addSimpleInsertion(
            node.constructorName.sourceRange.end,
            '.icon',
          );
        }

        var existIcon = false;

        node.argumentList.arguments.forEach((argument) {
          if (argument is NamedExpression) {
            if (argument.name.label.name == 'child') {
              builder.addSimpleReplacement(
                argument.name.sourceRange,
                'label:',
              );
            }

            if (argument.name.label.name == 'icon') {
              existIcon = true;
            }
          }
        });

        if (!existIcon) {
          builder.addSimpleInsertion(
            node.argumentList.arguments.last.sourceRange.end,
            ', icon: Icon(Icons.abc)',
          );
        }
      });
    });
  }
}
