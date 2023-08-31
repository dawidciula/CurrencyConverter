//
//  currentCurrencyPickerViewHandler.swift
//  CurrencyConverter
//
//  Created by Dawid Ciuła on 30/08/2023.
//

import UIKit

protocol PickerHandlerDelegate: AnyObject
{
    func didCurrencySelected(currency: String, inPicker picker: CurrencyPickerHandler)
}

class CurrencyPickerHandler: NSObject, UIPickerViewDelegate, UIPickerViewDataSource
{
    weak var delegate: PickerHandlerDelegate?
       let initialCurrencies: [String]
       var currencies: [String]
       weak var picker: UIPickerView?
       
       init(currencies: [String], picker: UIPickerView) {
           self.initialCurrencies = currencies
           self.currencies = currencies
           self.picker = picker
           super.init()
       }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedItem = currencies[row]
        print(selectedItem)
        delegate?.didCurrencySelected(currency: selectedItem, inPicker: self)
    }
    
    func updateAvailableCurrencies(excluding currency: String) {
           if currency == "-" {
               currencies = initialCurrencies
           } else {
               currencies = initialCurrencies.filter { $0 != currency }
           }
           picker?.reloadAllComponents()
       }
    
}
