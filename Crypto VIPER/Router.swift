import Foundation
import UIKit

// class, protocol
// EntryPoint


typealias Entrypoint = UIViewController & AnyView

protocol AnyRouter {
    var entry : Entrypoint? { get }
    static func startExecution() -> AnyRouter
}

class CryptoRouter: AnyRouter {
    
    var entry : Entrypoint?
    
    static func startExecution() -> any AnyRouter {
        
        let router = CryptoRouter()
        
        var view : AnyView = CryptoViewController()
        var presenter : AnyPresenter = CryptoPresenter()
        var interactor : AnyInteractor = CryptoInteractor()

        /// ----
        
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        router.entry = view as? Entrypoint
        
        return router
        
    }
    
}
