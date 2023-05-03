# material_button_assist
material_button_assist is an assistant that makes using [Common buttons] easier.

## Getting started

material_button_assist is implemented using [custom_lint]. As such, it uses custom_lint's installation logic.

Long story short:

- Add both material_button_assist and custom_lint to your `pubspec.yaml`:
  ```yaml
  dev_dependencies:
    custom_lint:
    material_button_assist:
  ```
- Enable `custom_lint`'s plugin in your `analysis_options.yaml`:

  ```yaml
  analyzer:
    plugins:
      - custom_lint
  ```

## Features



[Common buttons]: https://m3.material.io/components/buttons/overview
[custom_lint]: https://pub.dev/packages/custom_lint