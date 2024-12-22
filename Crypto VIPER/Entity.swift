import Foundation


struct Crypto: Codable { // internetten çektiğimiz verileri işlerken 'Decodable' kullanıyoruz.
    let currency: String
    let price: String
}
