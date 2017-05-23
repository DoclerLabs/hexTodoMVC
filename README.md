# hexTodoMVC

TodoMVC applications built with hexMachina framework.
*Find more information about hexMachina on [hexmachina.org](http://hexmachina.org/)*

## Dependencies

* [hexCore](https://github.com/DoclerLabs/hexCore)
* [hexReflection](https://github.com/DoclerLabs/hexReflection)
* [hexAnnotation](https://github.com/DoclerLabs/hexAnnotation)
* [hexInject](https://github.com/DoclerLabs/hexInject)
* [hexDSL](https://github.com/DoclerLabs/hexDSL)
* [hexMVC](https://github.com/DoclerLabs/hexMVC)
* [hexService](https://github.com/DoclerLabs/hexService)

## How to compile

In terminal : 
```bash
# check out the repo
git clone https://github.com/DoclerLabs/hexTodoMVC.git hexTodoMVC && cd hexTodoMVC/
# create a local haxelib repo, and donwnload dependencies
haxelib newrepo && haxelib install haxelib.json
# build project
haxe build-js.hxml
# open HTML in a browser
open index.html
```

## test online demo 

https://doclerlabs.github.io/hexTodoMVC/
