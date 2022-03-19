//
//  ProductView.swift
//  GalaxusBrowser
//
//  Created by Philipp on 19.03.22.
//

import SwiftUI

struct ProductView: View {

    private let productName: String
    private let brandName: String

    private let productTypeName: String
    private let imageURL: URL

    private let numberOfItems: Int
    private let numbersRemaining: Int

    private let basePrice: String
    private let offerPrice: String

    private let energyEfficiency: String

    private let averageRating: Double
    private let totalRatings: Int

    private let targetURL: URL

    init(product: Product) {
        self.productName = product.name
        self.brandName = product.brandName
        self.productTypeName = product.productTypeName
        self.imageURL = product.images.first!.url

        self.numberOfItems = product.salesInformation.numberOfItems
        self.numbersRemaining = product.salesInformation.numberOfItems - product.salesInformation.numberOfItemsSold

        let currency = product.offerPrice.currency

        self.offerPrice = product.offerPrice.amountIncl.currencyFormatted(currency: currency)
        self.basePrice = product.basePrice.amountIncl.currencyFormatted(currency: currency)

        self.energyEfficiency = product.energyEfficiency.energyEfficiencyLabelText

        self.averageRating = product.averageRating
        self.totalRatings = product.totalRatings

        self.targetURL = URL(string: "https://www.galaxus.ch/de/s14/product/\(product.id)")!
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(productTypeName)
                .font(.callout)
                .foregroundColor(Color("linkTextColor"))

            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                #if DEBUG
                Image("liveshopping")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                #else
                ProgressView()
                #endif
            }

            SalesInformationView(
                numberOfItems: numberOfItems,
                numberRemaining: numbersRemaining
            )
            .padding(.bottom, 1)

            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .firstTextBaseline) {
                    Text("\(offerPrice)").font(.headline)
                    Text("statt \(basePrice)").font(.caption2)
                    Spacer()
                    EnergyLabel(efficiency: energyEfficiency)
                }

                Text("**\(brandName)** \(productName)")
                    .font(.title3)
            }

            StarRatingView(averageRating: averageRating, totalRatings: totalRatings)
                .padding(.top, 1)
        }
        .onTapGesture {
            UIApplication.shared.open(targetURL)
        }
        .padding()
    }

    struct EnergyLabel: View {
        let efficiency: String

        var body: some View {
            Text(efficiency)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.vertical, 2)
                .padding(.trailing, 8)
                .frame(maxWidth: 48, alignment: .trailing)
                .background(
                    Rectangle()
                        .fill(Color("energyEfficency\(efficiency)"))
                )
        }
    }

    struct SalesInformationView: View {
        let numberOfItems: Int
        let numberRemaining: Int

        var body: some View {

            VStack(alignment: .leading) {
                Text("**noch \(numberRemaining)** von \(numberOfItems) Stück")
                    .font(.caption2)

                ProgressView(value: Double(numberRemaining), total: Double(numberOfItems))
                    .accentColor(Color("amountRemainingBar"))
            }
        }
    }

    struct StarRatingView: View {
        let averageRating: Double
        let totalRatings: Int

        var body: some View {
            HStack {
                HStack(spacing: 0) {
                    ForEach(1...5, id: \.self) { star in
                        Image(systemName: "star.fill")
                            .foregroundColor(
                                averageRating.rounded() >= Double(star) ? .primary : .primary.opacity(0.25))
                    }
                    .imageScale(.small)
                }

                Text("\(totalRatings)")
                    .foregroundColor(.secondary)
            }
        }
    }
}


#if DEBUG
struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product: .example)
            .border(Color.black)
            .padding()
    }
}
#endif
