import Foundation

struct CoinModel {
    var rate:Double
    var currencyCode:String
    
    func rateString(_ rate:Double) -> String{
        return String(format: "%.2f", rate)
    }
}
