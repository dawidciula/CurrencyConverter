//
//  exchangeCurrencyPickerViewHandler.swift
//  CurrencyConverter
//
//  Created by Dawid Ciuła on 30/08/2023.
//

import UIKit

class exchangeCurrencyPickerViewHandler: NSObject, UIPickerViewDelegate, UIPickerViewDataSource
{
    var dataArray: [String]
    
    init(data: [String]) {
           self.dataArray = data
           super.init()
       }
    
    var didSelectedItem: ((String) -> Void)?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedItem = dataArray[row]
        didSelectedItem?(selectedItem)
    }
    
    
}
