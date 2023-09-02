// ViewController.swift
// CurrencyConverter
//
// Created by Dawid Ciuła on 30/08/2023.
//

import UIKit

class ViewController: UIViewController, PickerHandlerDelegate {
    
    let apiConnection = APIConnection()
    
    var allCurrencies = ["PLN", "CAD", "USD", "EGP", "RUB", "CZK"]
    
    var exchangeRates: [String: Double] = [:]
    
    var firstCurrencyPickerHandler: CurrencyPickerHandler?
    var secondCurrencyPickerHandler: CurrencyPickerHandler?
    
    @IBOutlet var quantityTextField: UITextField!
    @IBOutlet var firstCurrencyPicker: UIPickerView!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var secondCurrencyPicker: UIPickerView!
    @IBAction func convertCurrencyButtonTapped(_ sender: Any) {
        convertCurrency()
    }
    
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
        
        apiConnection.fetchExchangeRates { result in
            switch result {
            case .success(let exchangeRatesResponse):
                self.exchangeRates = exchangeRatesResponse.rates
                print("Otrzymano kursy walut:\(exchangeRatesResponse.rates)")
            case .failure(let error):
                print("Wystąpił błąd: \(error.localizedDescription)")
            }
        }
    }
    
    func didCurrencySelected(currency: String, inPicker picker: CurrencyPickerHandler) {
        if picker === firstCurrencyPickerHandler {
            secondCurrencyPickerHandler?.updateAvailableCurrencies(excluding: currency)
        } else if picker === secondCurrencyPickerHandler {
            firstCurrencyPickerHandler?.updateAvailableCurrencies(excluding: currency)
        }
    }
    
    func convertCurrency() {
        guard let amountString = quantityTextField.text, let amount = Double(amountString) else {
            print("Nieprawidłowa wartość wprowadzona")
            return
        }

        let fromCurrency = allCurrencies[firstCurrencyPicker.selectedRow(inComponent: 0)]
        let toCurrency = allCurrencies[secondCurrencyPicker.selectedRow(inComponent: 0)]


        if fromCurrency == toCurrency {
            resultLabel.text = amountString
            return
        }

        let fromRate: Double = fromCurrency == "EUR" ? 1.0 : (exchangeRates[fromCurrency] ?? 1.0)
        let toRate: Double = toCurrency == "EUR" ? 1.0 : (exchangeRates[toCurrency] ?? 1.0)

        var convertedAmount: Double = 0.0


        if fromCurrency == "EUR" {
            convertedAmount = amount * toRate
        }

        else if toCurrency == "EUR" {
            convertedAmount = amount / fromRate
        }

        else {
            let amountInEUR = amount / fromRate
            convertedAmount = amountInEUR * toRate
        }

        resultLabel.text = String(format: "%.10f", convertedAmount)
    }



}

