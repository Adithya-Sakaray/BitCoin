import UIKit

class ViewController: UIViewController,UIPickerViewDataSource {
   
    
    
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        super.viewDidLoad()
        
    }
    
    //deciding number of columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //deciding number of rows in picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}


extension ViewController:UIPickerViewDelegate {
    //deciding the elements in the rows
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.userArray[row]
    }
    
    
    
    //adding functionality to the picker
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
        
    }
}


extension ViewController:CoinManagerDelegate {
    
    func didUpdateRate(_ coinManager: CoinManager, model: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = "\(model.rateString(model.rate))"
            self.currencyLabel.text = "\(model.currencyCode)"
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
