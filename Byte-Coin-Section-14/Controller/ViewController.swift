//
//  ViewController.swift
//  Byte-Coin-Section-14
//
//  Created by Abdurahman on 8.12.2023.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {
    //Need to change this to a var to be able to modify its properties.
    var coinManager = CoinManager()
    
    // CoinManagerDelegate
    //When the coinManager gets the price it will call this method and pass over the price and currency.
    func didUpdateCoin(lastPrice: Double) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = String(format: "%.2f", lastPrice)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    // UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    // UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyLabel.text = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        coinManager.delegate = self
    }


}

