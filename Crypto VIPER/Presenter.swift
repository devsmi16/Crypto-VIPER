import Foundation

// Class, protocol
// Talks to -> interactor, router, view


enum NetworkError: Error {
    
    case NetworkFailed
    
    case ParsingFailed
    
}



protocol AnyPresenter {
    
    var router: AnyRouter? { get set}            // okunacak ve değiştirilecek şekilde dizayn ettik { get set}
    var interactor: AnyInteractor? { get set}
    var view: AnyView? { get set }
    
    func interactorDidDownloadCrpto(result: Result<[Crypto], Error>)
}

class CryptoPresenter: AnyPresenter {
    
    var router: (any AnyRouter)?
    var view: (any AnyView)?
    var interactor: (any AnyInteractor)?{
        didSet { // değer atanınca yapılacak işlemler
            interactor?.downloadCryptos()
        }
    }
    
    func interactorDidDownloadCrpto(result: Result<[Crypto], any Error>) {
        
        switch result {
        case .success(let crypto):
            view?.update(with: crypto)
            
        case .failure( _):
            view?.update(with: "Try Again...")
        }
    }
    
    
}
