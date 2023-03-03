import Foundation

protocol CoinManagerDelegate {
    func didUpdateRate(_ coinManager:CoinManager , model:CoinModel)
    func didFailWithError(error:Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "D5AB7039-E4E3-4881-BE68-ED7EAD308AF8"
    var delegate:CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    let userArray = ["Australian dollar",
                     "Brazilian real",
                     "Canadian dollar",
                     "Chinese yuan renminbi",
                     "Euro",
                     "British pound sterling",
                     "Hong Kong dollar",
                     "Indonesian Rupiah",
                     "Israeli New Shekel",
                     "Indian Rupee",
                     "Japanese Yen",
                     "Mexican peso",
                     "Norwegian krone",
                     "New Zealand dollar",
                     "Polish Zloty",
                     "Romanian currency",
                     "Russian Ruble",
                     "Swedish krona",
                     "Singapore Dollar ",
                     "United States Dollar",
                     "South African Rand",]
    
    func getCoinPrice(for currency:String){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performequest(with: urlString)
    }
    
    
    
    func performequest(with URLString:String) {
        
        if let url = URL(string: URLString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    parseJSON(data: safeData)
                }
            }
            
            task.resume()
        }
        
    }
    
    func parseJSON(data:Data){
        
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let rate = decodedData.rate
            let currencyCode = decodedData.asset_id_quote
            let coinModel = CoinModel(rate: rate, currencyCode: currencyCode)
            delegate?.didUpdateRate(self, model:coinModel)
        } catch {
            delegate?.didFailWithError(error: error)        }
        
    }
    
}
