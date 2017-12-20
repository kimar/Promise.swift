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

## License

See [LICENSE.md](LICENSE.md)