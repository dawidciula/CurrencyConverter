//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Dawid Ciuła on 30/08/2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var currentCurrencyPickerView: UIPickerView!
    
    var currentCurrencyPickerViewHandler: currentCurrencyPickerViewHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currentCurrencyPickerViewHandler = CurrencyConverter.currentCurrencyPickerViewHandler()
        
        currentCurrencyPickerView.delegate = currentCurrencyPickerViewHandler
        currentCurrencyPickerView.dataSource = currentCurrencyPickerViewHandler
    }
    

}

