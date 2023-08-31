//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Dawid Ciuła on 30/08/2023.
//

import UIKit

class ViewController: UIViewController, PickerHandlerDelegate {
    
    var allCurrencies = ["-", "PLN", "EUR", "USD"]
    
    var firstCurrencyPickerHandler: CurrencyPickerHandler?
    var secondCurrencyPickerHandler: CurrencyPickerHandler?
    
    @IBOutlet var firstCurrencyPicker: UIPickerView!
    @IBOutlet var secondCurrencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstCurrencyPickerHandler = CurrencyPickerHandler(currencies: allCurrencies, picker: firstCurrencyPicker)
        secondCurrencyPickerHandler = CurrencyPickerHandler(currencies: allCurrencies, picker: secondCurrencyPicker)
        
        firstCurrencyPicker.delegate = firstCurrencyPickerHandler
        firstCurrencyPicker.dataSource = firstCurrencyPickerHandler
        
        secondCurrencyPicker.delegate = secondCurrencyPickerHandler
        secondCurrencyPicker.dataSource = secondCurrencyPickerHandler
        
        firstCurrencyPickerHandler?.delegate = self
        secondCurrencyPickerHandler?.delegate = self
    }
    
    func didCurrencySelected(currency: String, inPicker picker: CurrencyPickerHandler) {
        if picker === firstCurrencyPickerHandler {
            secondCurrencyPickerHandler?.updateAvailableCurrencies(excluding: currency)
        } else if picker === secondCurrencyPickerHandler {
            firstCurrencyPickerHandler?.updateAvailableCurrencies(excluding: currency)
        }
    }
}
