# Ercode CLI

Ercode CLI is an application to facilitate the process of creating Flutter applications faster, easier, and more simple. Ercode CLI will generate a module's code based on a JSON configuration.

### Installation

```
// install
dart pub global activate ercode_cli 

// or with flutter
flutter pub global activate ercode_cli

// command use
ercode
```

### Init Generator

``` 
ercode init
```
Setting URL API and token(optional) in file `lib/helpers/constants.dart` :
```
const baseUrl = '';
const apiToken = '';
```

### Generate Code

example create module <b>book</b> with json config at `generator/book.json` :

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
            "list": true
        },
        {
            "name": "genre"
        },
        {
            "name": "release_year",
            "type": "int"
        },
        {
            "name": "description"
            
        }
    ]
}

```

to generate code run command:
```
ercode generate generator/book.json
```

#### Paramaters Module
| Key       | Required  | Default       | Description   |   
| --------  | -------   | -------       | -------       |
| name      | true      |               | Module name   |
| api       |           | same with name| endpoint API  |
| model     |           | same with name| Model name    |
| only      |           |               | The list of modules that will be generated: `model, repository, list, add, detail`. If this is empty, then all of them will be generated.   |
| fields    | true           |          | List of fields that will be generated. Please see the `Field` parameters for details.   |

#### Paramaters Field
| Key       | Required  | Default       | Description   |   
| --------  | -------   | -------       | -------       |
| name      | true      |               | Field name   |
| type      | true      | String        | Data types in Flutter : `String, int, bool`  |
| input     |           | text          | Type of field on create page: `text, image`    |
| hidden   |           | false         | To indicate that this `field` will not appear on the create page |
| primary   |           | false         | Indicating this field as primary key  |
| list    |           |  false      |  Indicating this field will be shown on the list page   |