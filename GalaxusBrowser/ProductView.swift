//
//  ProductView.swift
//  GalaxusBrowser
//
//  Created by Philipp on 19.03.22.
//

import SwiftUI

struct ProductView: View {

    let product: Product

    let imageURL: URL

    let basePrice: String
    let offerPrice: String

    init(product: Product) {
        self.product = product
        self.imageURL = product.images.first!.url

        let currency = product.offerPrice.currency

        self.offerPrice = product.offerPrice.amountIncl.currencyFormatted(currency: currency)
        self.basePrice = product.basePrice.amountIncl.currencyFormatted(currency: currency)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(product.productTypeName)
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

            SalesInformationView(salesInformation: product.salesInformation)

            Text("**\(offerPrice)** statt \(basePrice)")

            Text("**\(product.brandName)** \(product.name)")

            StarRatingView(averageRating: product.averageRating, totalRatings: product.totalRatings)
                .padding(.top, 1)
        }
        .padding()
    }

    struct SalesInformationView: View {
        let salesInformation: Product.SalesInformation

        var body: some View {
            let remaining = salesInformation.numberOfItems - salesInformation.numberOfItemsSold

            VStack(alignment: .leading) {
                Text("**noch \(remaining)** von \(salesInformation.numberOfItems) Stück")
                    .font(.caption2)

                ProgressView(value: Double(remaining), total: Double(salesInformation.numberOfItems))
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
