import Foundation

public enum BaseEncoding: UInt8 {
    case identity          = 000 // null
    case base1             = 049 // 1
    case base2             = 048 // 0
    case base8             = 055 // 7
    case base10            = 057 // 9
    case base16            = 102 // f
    case base16Upper       = 070 // F
    case base32            = 098 // b
    case base32Upper       = 066 // B
    case base32Pad         = 099 // c
    case base32PadUpper    = 067 // C
    case base32Hex         = 118 // v
    case base32HexUpper    = 089 // V
    case base32HexPad      = 116 // t
    case base32HexPadUpper = 084 // T
    case base58Flickr      = 090 // Z
    case base58BTC         = 122 // z
    case base64            = 109 // m
    case base64URL         = 117 // u
    case base64Pad         = 077 // M
    case base64URLPad      = 085 // U
}

extension String {

    init?(multibaseEncoding data: Data, inBase base: BaseEncoding) {
        let byteString = [base.rawValue] + data
        let stringBaseEncoding = String(bytes: [base.rawValue], encoding: String.Encoding.utf8)!

        switch base {
        case .identity:
            self = String(bytes: byteString, encoding: String.Encoding.utf8)!
        case .base16:
            self = stringBaseEncoding + String(base16Encoding: data)
        case .base16Upper:
            self = stringBaseEncoding + String(base16Encoding: data).uppercased()
        case .base32Pad:
            self = stringBaseEncoding + String(base32Encoding: data).lowercased()
        case .base32PadUpper:
            self = stringBaseEncoding + String(base32Encoding: data).uppercased()
        case .base32HexPad:
            self = stringBaseEncoding + String(base32HexEncoding: data).lowercased()
        case .base32HexPadUpper:
            self = stringBaseEncoding + String(base32HexEncoding: data).uppercased()
        case .base58BTC:
            self = stringBaseEncoding + String(base58Encoding: data, alphabet: Base58String.btcAlphabet)
        case .base58Flickr:
            self = stringBaseEncoding + String(base58Encoding: data, alphabet: Base58String.flickrAlphabet)
        case .base64Pad:
            self = stringBaseEncoding + data.base64EncodedString()
        case .base64URLPad:
            self = stringBaseEncoding + data.base64URLPadEncodedString()
        default:
            return nil
        }
    }

   public var baseEncoding: BaseEncoding {
        let base = Array(self.utf8)[0]
        return BaseEncoding(rawValue: base)!
    }

}

extension Data {

    init?(multibaseDecoding multibaseString: String) {
        let byteString = Data(multibaseString.utf8)
        let base = BaseEncoding(rawValue: byteString[0])!
        let string = String(bytes: byteString[1...], encoding: String.Encoding.utf8)!

        switch base {
        case .identity:
            self = byteString[1...]
        case .base16, .base16Upper:
            guard let decoded = Data(base16Decoding: string) else {
                return nil
            }
            self = decoded
        case .base32Pad, .base32PadUpper:
            guard let decoded = Data(base32Decoding: string) else {
                return nil
            }
            self = decoded
        case .base32HexPad, .base32HexPadUpper:
            guard let decoded = Data(base32HexDecoding: string) else {
                return nil
            }
            self = decoded
        case .base58BTC:
            guard let decoded = Data(base58Decoding: string, alphabet: Base58String.btcAlphabet) else {
                return nil
            }
            self = decoded
        case .base58Flickr:
            guard let decoded = Data(base58Decoding: string, alphabet: Base58String.flickrAlphabet) else {
                return nil
            }
            self = decoded
        case .base64Pad:
            guard let decoded = Data(base64Encoded: string) else {
                return nil
            }
            self = decoded
        case .base64URLPad:
            guard let decoded = Data(base64URLPadEncoded: string) else {
                return nil
            }
            self = decoded
        default:
            return nil
        }
    }

}
