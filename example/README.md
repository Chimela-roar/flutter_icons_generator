# example
Example of project that uses **flutter_icons_generator** for font generation 

- [icon_fonts folder](https://github.com/darialvznd/flutter_icons_generator/tree/main/example/assets/icon_fonts) contains .svg files that where used to create font 

 - [icons_builder.yaml](https://github.com/darialvznd/flutter_icons_generator/blob/main/example/icons_builder.yaml) is generator configuration where you need to specify .svg-files path, future class name and output font and dart-file paths. 

- [build.yaml](https://github.com/darialvznd/flutter_icons_generator/blob/main/example/build.yaml) is a builder configuration where you need to pass path to your **icons_builder.yaml**

After running ```flutter pub run build_runner build``` files in folders **./assets/icon_fonts** and **./lib/theme/** were created. 
After that we added generated font to **pubspec.yaml** so now we can use them in project 
```
flutter:
  fonts:
    - family: FirstIcons
      fonts:
        - asset: ./assets/icon_fonts/first_icons.otf```
