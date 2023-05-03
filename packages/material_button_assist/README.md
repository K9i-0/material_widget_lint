material_button_assist is an assistant that makes using [Common buttons] easier.

- [Getting started](#getting-started)
- [Features](#features)
  - [Convert to other button](#convert-to-other-button)
  - [Add icon](#add-icon)
  - [Remove icon](#remove-icon)

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


### Convert to other button
You can easily convert between five different buttons.
- Elevated button
- Filled button
- Filled tonal button
- Outlined button
- Text button

![Convert to other button sample](https://raw.githubusercontent.com/K9i-0/material_widget_lint/main/packages/material_button_assist/resources/convert-to-other-button.gif)

### Add icon
Add icons to the buttons and automatically update the field names as well.

![Add icon sample](https://raw.githubusercontent.com/K9i-0/material_widget_lint/main/packages/material_button_assist/resources/add-icon.gif)

### Remove icon
Remove icons from the buttons and automatically update the field names as well.

![Remove icon sample](https://raw.githubusercontent.com/K9i-0/material_widget_lint/main/packages/material_button_assist/resources/remove-icon.gif)

[Common buttons]: https://m3.material.io/components/buttons/overview
[custom_lint]: https://pub.dev/packages/custom_lint
