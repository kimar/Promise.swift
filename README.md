[![Twitter: @Kidmar](https://img.shields.io/badge/contact-@Kidmar-blue.svg?style=flat)](https://twitter.com/Kidmar)
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/LocativeHQ/Locative-iOS/blob/master/LICENSE.md)
[![Build Status](https://travis-ci.org/kimar/Promise.swift.svg?branch=master)](https://travis-ci.org/kimar/Promise.swift)

# Promise.swift

## tl;dr
A very simple Swift 3.0 Promise library I've written while on the plane using my iPad and Playgrounds.

Writte in just 33 lines of code.

## Usage

Rather simple and more for reference than actually to be used is this very simple implementation of a *Promise* framework.

**Succeeding**

```
Promise<String> { resolve, reject in 
	resolve("Bazingaaaa!")
}.then { result in 
	print(result)
}
```

**Failing** 

```
Promise<String> { resolve, reject in 
	reject(Error.AnError)
}.fail { error in 
	print("An error occured \(error)")
}
```

**Chaining**

```
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
