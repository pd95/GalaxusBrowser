//
//  Product.swift
//  GalaxusBrowser
//
//  Created by Philipp on 19.03.22.
//

import Foundation


struct Product: Decodable {
    let id: String
    let name: String
    let productTypeName: String
    let brandName: String
    let averageRating: Double
    let totalRatings: Int
    let totalQuestions: Int
    let images: [ImageReference]
    let energyEfficiency: EnergyEfficiency
    let basePrice: VATMoney
    let offerPrice: VATMoney
    let salesInformation: SalesInformation

    struct ImageReference: Decodable {
        let url: URL
        let height: Int
        let width: Int
    }

    struct EnergyEfficiency: Decodable {
        let energyEfficiencyColorType: Int
        let energyEfficiencyLabelText: String
    }

    struct VATMoney: Decodable {
        let amountIncl: Double
        let amountExcl: Double
        let currency: String
        let fraction: Double
    }

    struct SalesInformation: Decodable {
        let numberOfItems: Int
        let numberOfItemsSold: Int
        let isEndingSoon: Bool
        let validFrom: Date
    }
}

#if DEBUG
extension Product {
    static let exampleData = """
    {
        "id": "PROD_18483740",
        "productId": 18483740,
        "name": "Smart (mit Wireless-Charger)",
        "nameProperties": "",
        "productTypeId": 1645,
        "productTypeName": "Tischlampe",
        "brandId": 7010,
        "brandName": "Hansa",
        "averageRating": 3.98,
        "totalRatings": 47,
        "totalQuestions": 4,
        "isProductSet": false,
        "images": [{
            "url": "https://static.digitecgalaxus.ch/Files/5/5/1/6/5/1/9/6/LED_SMART_BLACK_2.jpg",
            "height": 2147483647,
            "width": 2147483647,
        }, {
            "url": "https://static.digitecgalaxus.ch/Files/5/5/1/6/5/1/9/7/LED_SMART_BLACK_DETAIL_01.jpg",
            "height": 2147483647,
            "width": 2147483647,
        }, {
            "url": "https://static.digitecgalaxus.ch/Files/5/5/1/6/5/1/9/8/LED_SMART_BLACK_DETAIL_02.jpg",
            "height": 2147483647,
            "width": 2147483647,
        }, {
            "url": "https://static.digitecgalaxus.ch/Files/5/5/1/6/5/1/9/9/LED_SMART_BLACK_DETAIL_03.jpg",
            "height": 2147483647,
            "width": 2147483647,
        }, {
            "url": "https://static.digitecgalaxus.ch/Files/5/5/1/6/5/2/0/0/LED_SMART_BLACK_DETAIL_04.jpg",
            "height": 2147483647,
            "width": 2147483647,
        }],
        "energyEfficiency": {
            "energyEfficiencyColorType": 5,
            "energyEfficiencyLabelText": "E",
            "energyEfficiencyLabelSigns": "",
            "energyEfficiencyImage": null,
        },
        "hasVariants": false,
        "smallDimensions": true,
        "basePrice": {
            "amountIncl": 179,
            "amountExcl": 166.20,
            "currency": "CHF",
            "fraction": 0.077,
        },
        "offerPrice": {
            "amountIncl": 129,
            "amountExcl": 119.78,
            "currency": "CHF",
            "fraction": 0.077,
        },
        "salesInformation": {
            "numberOfItems": 20,
            "numberOfItemsSold": 7,
            "isEndingSoon": false,
            "validFrom": "2022-03-18T23:00:00Z",
        },
    }
    """.data(using: .utf8)!

    static let example = try! JSONDecoder.standard.decode(Product.self, from: exampleData)
}
#endif

extension JSONDecoder {
    static let standard: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .useDefaultKeys

        return decoder
    }()
}
