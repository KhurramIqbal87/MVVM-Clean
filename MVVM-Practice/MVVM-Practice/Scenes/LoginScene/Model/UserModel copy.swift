final public class BinanceCryptoCurrencyModel: Codable {

    public var symbol: String? = nil
    public var price: String? = nil
    enum CodingKeys: String, CodingKey {
        case symbol = "symbol"
        case price = "price"
    }
}
