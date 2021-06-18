//
//  ViewController.swift
//  BitChange
//
//  Created by Aleksey Fedorov on 16.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coingManager = CoinManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coingManager.delegate = self
    }
}
    
//MARK: CoinManager
    
 extension ViewController: CoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
                    self.coinLabel.text = price
                    self.currencyLabel.text = currency
                }
    }
    
    func didFailWithError(error: Error) {
        print(error)
     }
    }
    
//MARK: - UIPicker
    
 extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //MARK
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coingManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coingManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectCurrency = coingManager.currencyArray[row]
        coingManager.getCoinPrice(for: selectCurrency)
    }
    }



