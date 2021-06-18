//
//  CoinManager.swift
//  BitChange
//
//  Created by Aleksey Fedorov on 16.06.2021.
//

import Foundation
protocol CoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}
struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "C2D15899-D7C7-43EA-AEA0-070DC4DFFEFA"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
    
        if let url = URL(string: urlString) {
                    let session = URLSession(configuration: .default)
                    let task = session.dataTask(with: url) { (data, response, error) in
                        if error != nil {
                            print(error!)
                            return
                        }
                        if let dataString = data {
                            if let bitcoinPrice = self.parseJSON(dataString) {
                            let priceString = String(format: "%.2f", bitcoinPrice)
                            self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                            }
                        }
                        
                    }
                    task.resume()
                }
    }
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
                do {
                    
                    let decodedData = try decoder.decode(CoinData.self, from: data)
                    
                    let lastPrice = decodedData.rate
                    print(lastPrice)
                    return lastPrice
                    
                } catch {
                    delegate?.didFailWithError(error: error)
                    return nil
                }
    }
    
    
    

    
}
