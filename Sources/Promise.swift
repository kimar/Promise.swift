typealias Resolver<T> = (_ resolve: @escaping (T) -> Void, _ reject: @escaping (Error) -> Void) -> Void

struct Promise<T> {
    let resolver: Resolver<T>

    func then<U> (_ closure: @escaping (T) -> U) -> Promise<U> {
        return Promise<U> { resolve, reject in
            self.resolver({ result in resolve(closure(result)) }, { error in reject(error) })
        }
    }
    
    func then (_ closure: @escaping (T) -> Void) {
        self.resolver({ result in closure(result)}, { _ in })
    }
    
    func fail (_ closure: @escaping (Error) -> Void) {
        self.resolver({ _ in }, { error in closure(error)})
    }
}

