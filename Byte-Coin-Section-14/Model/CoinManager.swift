//
//  CoinManager.swift
//  Byte-Coin-Section-14
//
//  Created by Abdurahman on 8.12.2023.
//

import Foundation

let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""

protocol CoinManagerDelegate {
    func didUpdateCoin(lastPrice: Double)
    
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
        
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    //Create an optional delegate that will have to implement the delegate methods.
    //Which we can notify when we have updated the price.
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        //print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString:String){
        //  1. Create a Url:
                if let url = URL(string: urlString) {
                    // 2. Create a URLSession:
                    let session = URLSession(configuration: .default)
                    // 3. Give the session a task:
                    let task = session.dataTask(with: url) { data, response, error in
                        if error != nil {
                            self.delegate?.didFailWithError(error: error!)
                            return
                        }
                        if let safeData = data {
                            //let dataString = String(data: safeData, encoding: .utf8)
                            //print(dataString!)
                            if let lastCoinPrice = self.parseJSON(safeData){
                                //Call the delegate method in the delegate (ViewController) and pass along the necessary data.
                                self.delegate?.didUpdateCoin(lastPrice: lastCoinPrice)
                            }
                        }
                    }
                    // 4. Start the task:
                    task.resume()
                }
    }
    
    func parseJSON(_ coinData: Data) -> Double? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let rate = decodedData.rate
            return rate
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    

    
}
