import Foundation
import Base32

public extension String {

    public init(base32Encoding data: Data) {
        self = Base32.base32Encode(data)
    }

    public init(base32HexEncoding data: Data) {
        self = Base32.base32HexEncode(data)
    }

}

public extension Data {

    public init?(base32Decoding base32String: String) {
        guard let x = Base32.base32DecodeToData(base32String) else {
            return nil
        }
        self = x
    }

    public init?(base32HexDecoding base32String: String) {
        guard let x = Base32.base32HexDecodeToData(base32String) else {
            return nil
        }
        self = x
    }
}
