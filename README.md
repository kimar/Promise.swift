# Promise.swift

[![Twitter: @Kidmar](https://img.shields.io/badge/contact-@Kidmar-blue.svg?style=flat)](https://twitter.com/Kidmar)
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/LocativeHQ/Locative-iOS/blob/master/LICENSE.md)
[![Build Status](https://travis-ci.org/kimar/Promise.swift.svg?branch=master)](https://travis-ci.org/kimar/Promise.swift)
![Xcode 8.2+](https://img.shields.io/badge/Xcode-8.2%2B-blue.svg)
![iOS 8.0+](https://img.shields.io/badge/iOS-8.0%2B-blue.svg)
![Swift 3.0+](https://img.shields.io/badge/Swift-3.0%2B-orange.svg)

## tl;dr
A very simple Swift 3.0 Promise library I've written while on the plane using my iPad and Playgrounds.

Writte in just 33 lines of code.

## Usage

Rather simple and more for reference than actually to be used is this very simple implementation of a *Promise* framework.

**Succeeding**

```swift
Promise<String> { resolve, reject in 
	resolve("Bazingaaaa!")
}.then { result in 
	print(result)
}
```

**Failing** 

```swift
Promise<String> { resolve, reject in 
	reject(Error.AnError)
}.fail { error in 
	print("An error occured \(error)")
}
```

**Chaining**

```swift
Promise<String> { resolve, reject in 
	resolve(1)
}.then { result -> Promise<Int> in 
	return Promise<Int> { resolve, reject in 
		resolve(result + 1)
	}
}.then { result -> Promise<Int> in 
	return Promise<Int> { resolve, reject in 
		resolve(result + 1)
	}
}.then { result in 
	print(result) // 3
}
```

## License

See [LICENSE.md](LICENSE.md)
