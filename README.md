# IDDOg
##### Challenge of IDWall

[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Twitter](https://img.shields.io/badge/twitter-@maclacerda-blue.svg?style=flat)](https://twitter.com/_maclacerda)


## Componentes utilizados

- [Alamofire](https://github.com/Alamofire/Alamofire) - Alamofire is an HTTP networking library written in Swift.
- [CodableAlamofire](https://github.com/Otbivnoe/CodableAlamofire) - Swift 4 introduces a new Codable protocol that lets you serialize and deserialize custom data types without writing any special code and without having to worry about losing your value types. 🎉
- [SwiftKeychain](https://github.com/evgenyneu/keychain-swift) - This is a collection of helper functions for saving text and data in the Keychain. As you probably noticed Apple's keychain API is a bit verbose. This library was designed to provide shorter syntax for accomplishing a simple task: reading/writing text values for specified keys
- [SDWebImage](https://github.com/SDWebImage/SDWebImage) - Asynchronous image downloader with cache support as a UIImageView category https://sdwebimage.github.io


## Requerimentos mínimos

- iOS 9.0+
- Xcode 10.2+

## Arquitetura
- MVVM-C (Model / View / ViewModel / Coordinator)
- Unit tests
- CI using [GitHub Actions](https://github.com/features/actions)

## Como rodar o projeto

### Carthage

Para o correto funcionamento do projeto abra o terminal e execute o comando abaixo:

```ogdl
carthage update --platform iOS
```

## Licença

IDDog é liberado sob a licença MIT.