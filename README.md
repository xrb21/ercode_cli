# Ercode CLI

The package is used to generate CRUD code in Flutter, complete with models and repositories. The generation process is based on a JSON config file.

### Installation

```
// install
pub global activate ercode_cli 

// activate package
flutter pub global activate ercode_cli
```

### Init Generator

``` 
ercode init
```

##### add config pada material app di file `lib/main.dart`

```
navigatorKey: Get.navigatorKey,
builder: EasyLoading.init(),
```

example:
```
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Book',
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.navigatorKey, // add this
      builder: EasyLoading.init(), // add this
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BookView(),
    );
  }
}
```
### Generate Code

example create module book with json config at `generator/book.json` :

```
{
    "name": "book",
    "fields": [
        {
            "name": "id",
            "type": "int",
            "primary": true,
            "hidden": true
        },
        {
            "name": "cover",
            "type": "String",
            "input": "image",
            "list": true
        },
        {
            "name": "name",
            "type": "String",
            "input": "text",
            "list": true
        },
        {
            "name": "author",
            "type": "String",
            "input": "text",
            "list": true
        },
        {
            "name": "genre",
            "type": "String",
            "input": "text"
        },
        {
            "name": "release_year",
            "type": "String",
            "input": "text"
        },
        {
            "name": "description",
            "type": "String",
            "input": "text"
        }
    ]
}

```

to generate code run command:
```
ercode create generator/book.json
```