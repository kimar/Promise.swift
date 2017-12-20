typealias Resolver<T> = (
    _ resolve: (T) -> Void,
    _ reject: (Error) -> Void
) -> Void

public class Promise<T> {
    let resolver: Resolver<T>

    init(_ resolver: @escaping Resolver<T>) {
        self.resolver = resolver
    }
    
    func then(_ closure: (T) -> Void) {
        resolver({ value in closure(value) }, { _ in })
    }
    
    func then<U>(_ closure: (T) -> Promise<U>) -> Promise<U> {
        var promise: Promise<U>?
        resolver({ value in promise = closure(value) }, { _ in })
        return Promise<U> { resolve, reject in
            promise?.then { result in
                resolve(result)
            }
            promise?.fail { error in
                reject(error)
            }
        }
    }
    
    func fail(_ closure: (Error) -> Void) {
        resolver({ _ in }, { error in closure(error) })
    }
}

