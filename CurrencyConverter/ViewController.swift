//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Dawid Ciuła on 30/08/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let currenciesToExchange = ["PLN", "EUR", "USD"]
    lazy var firstPickerCurrency = currenciesToExchange
    lazy var secondPickerCurrency = currenciesToExchange
    
    
    
    @IBOutlet var currentCurrencyPickerView: UIPickerView!
    @IBOutlet var exchangeCurrencyPickerView: UIPickerView!
    
    var currentCurrencyPickerViewHandler: currentCurrencyPickerViewHandler!
    var exchangeCurrencyPickerViewHandler: exchangeCurrencyPickerViewHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currentCurrencyPickerViewHandler = CurrencyConverter.currentCurrencyPickerViewHandler(data: currenciesToExchange)
        exchangeCurrencyPickerViewHandler = CurrencyConverter.exchangeCurrencyPickerViewHandler(data: currenciesToExchange)
       
        currentCurrencyPickerView.delegate = currentCurrencyPickerViewHandler
        currentCurrencyPickerView.dataSource = currentCurrencyPickerViewHandler
        exchangeCurrencyPickerView.delegate = exchangeCurrencyPickerViewHandler
        exchangeCurrencyPickerView.dataSource = exchangeCurrencyPickerViewHandler
    }
    

}

