//
//  APIConnection.swift
//  CurrencyConverter
//
//  Created by Dawid Ciuła on 01/09/2023.
//

import Foundation
import Alamofire

struct ExchangeRates: Codable {
    let base: String
    let rates: [String: Double]
}

class APIConnection {

    func fetchExchangeRates(completion: @escaping (Result<ExchangeRates, Error>) -> Void) {
        let url = "http://api.exchangeratesapi.io/v1/latest?access_key=2c3a00654db43538452e05fb38e1e076"
        AF.request(url).responseDecodable(of: ExchangeRates.self) { response in
            switch response.result {
            case .success(let exchangeRates):
                print("Otrzymane dane: \(exchangeRates)")
                completion(.success(exchangeRates))
            case .failure(let error):
                print("Błąd podczas pobierania danych: \(error)")
                completion(.failure(error))
            }
        }
    }
}
