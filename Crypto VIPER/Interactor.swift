import Foundation

// Class, protocol
// talks to -> presenter

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func downloadCryptos()
}

class CryptoInteractor: AnyInteractor {
    
    var presenter: (any AnyPresenter)?
    
    func downloadCryptos(){
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                
                self?.presenter?.interactorDidDownloadCrpto(result: .failure(NetworkError.NetworkFailed))
                
                return
            }
            
            do{
                
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interactorDidDownloadCrpto(result: .success(cryptos)) // presenter ile ilişkileniyor.
                
            }catch{
                
                self?.presenter?.interactorDidDownloadCrpto(result: .failure(NetworkError.ParsingFailed))
                
            }
        }
        task.resume()
    }
    
}
