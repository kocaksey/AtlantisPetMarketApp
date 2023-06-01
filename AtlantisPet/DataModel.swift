//
//  DataModel.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 29.05.2023.
//




import Foundation

// MARK: - DataModelElement
struct DataModelElement: Codable {
    let kodu: Int?
    let açıklaması: String?
    let anaBirim: AnaBirim?
    let fiiliStok, gerçekStok: Stok?
    let grupKodu: GrupKodu?

    enum CodingKeys: String, CodingKey {
        case kodu = "Kodu"
        case açıklaması = "Açıklaması"
        case anaBirim = "Ana Birim"
        case fiiliStok = "Fiili Stok"
        case gerçekStok = "Gerçek Stok"
        case grupKodu = "Grup Kodu"
    }
}

enum AnaBirim: String, Codable {
    case adet = "ADET"
}

enum Stok: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Stok.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Stok"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum GrupKodu: String, Codable {
    case the0005_Proplan = "0005_Proplan"
}

typealias DataModel = [DataModelElement]
