
Generates font-file (.otf) and icons-file (.dart) to use in project from svg-icons. 


## Features 

- Custom input and output path 
- Possibility to use more then one icon's pack

## Usage

To use this package store folder with icon's svg in your target project. 

After package import create following files. 

1. **"icons_generator.yaml"** with following structure 
```
icons:
  [
    { className: *required class name*, sourceFolderPath: *path to folder with svg-files* },
    { className: *required class name*, sourceFolderPath: *path to folder with svg-files* },
  ]
outputFontPath: *path to folder where you want to place font-file (.otf)*
outputFilePath: *path to folder where you want to place icons-file (.dart)*
```

2. in **"build.yaml"** add following lines 
```
targets:
  $default:
    builders:
      flutter_icons_generator|iconBuilder:
        options:
          icons_config:
            "./flutter_icons_generator.yaml" #path to icons_generator.yaml you created earlier 
```

To start generator use  ```flutter pub run build_runner build``` in terminal.

## Example
For this example svg-files stored in "./assets/icons/" folder.

Example of "icons_generator.yaml" content 
```
icons:
  [
    { className: ActionIcons, sourceFolderPath: ./assets/icons/test1 },
    { className: NavigationIcons, sourceFolderPath: ./assets/icons/test2 },
  ]
outputFontPath: ./assets/icon_fonts
outputFilePath: lib/theme
```

build.yaml content example 

```
targets:
  $default:
    builders:
      flutter_icons_generator|iconBuilder:
        options:
          icons_config:
            "./flutter_icons_generator.yaml"
```

After running ```flutter pub run build_runner build``` you will have files "action_icons.otf", "navigation_icons.otf" in folder ./assets/icon_fonts and "action_icons.dart" and "navigation_icons.dart" in folder lib/theme. 

Full usage example you may find in [example](https://github.com/darialvznd/flutter_icons_generator/tree/main/example) folder

