import Foundation

extension Data {

    init?(base64URLPadEncoded string: String) {
        let base64PadEncoded = string
            .replacingOccurrences(of: "_", with: "/")
            .replacingOccurrences(of: "-", with: "+")
        self.init(base64Encoded: base64PadEncoded)
    }

    init?(base64URLPadEncoded data: Data) {
        guard let string = String(data: data, encoding: .utf8) else {
            return nil
        }
        self.init(base64URLPadEncoded: string)
    }

    func base64URLPadEncodedString() -> String {
        return self.base64EncodedString()
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "+", with: "-")
    }

    func base64URLPadEncodedData() -> Data {
        return self.base64URLPadEncodedString().data(using: .utf8)!
    }

}
