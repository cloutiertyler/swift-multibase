import Foundation
import Base32

extension Data {

    init?(base32Encoded string: String) {
        guard let data = Base32.base32DecodeToData(string) else {
            return nil
        }
        self = data
    }

    init?(base32Encoded data: Data) {
        guard let string = String(data: data, encoding: .utf8) else {
            return nil
        }
        self.init(base32Encoded: string)
    }

    func base32EncodedString() -> String {
        return Base32.base32Encode(self)
    }

    func base32EncodedData() -> Data {
        return self.base32EncodedString().data(using: .utf8)!
    }

}

extension Data {

    init?(base32HexEncoded string: String) {
        guard let data = Base32.base32HexDecodeToData(string) else {
            return nil
        }
        self = data
    }

    init?(base32HexEncoded data: Data) {
        guard let string = String(data: data, encoding: .utf8) else {
            return nil
        }
        self.init(base32HexEncoded: string)
    }

    func base32HexEncodedString() -> String {
        return Base32.base32HexEncode(self)
    }

    func base32HexEncodedData() -> Data {
        return self.base32HexEncodedString().data(using: .utf8)!
    }

}
