import SwiftUI
import UIKit
import Foundation

struct PlaceImageView: View {
    let name: String
    var cornerRadius: CGFloat = 12
    var aspectRatio: CGFloat = 1.0

    var body: some View {
        GeometryReader { proxy in
            let size = min(proxy.size.width, proxy.size.height)
            ZStack {
                if let uiImage = loadImage(named: name) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                        .clipped()
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.gray.opacity(0.15))
                        .frame(width: size, height: size)
                        .overlay(Image(systemName: "photo").foregroundColor(.secondary))
                }
            }
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
    }

    private func loadImage(named: String) -> UIImage? {
        let bundle = Bundle.main
        if let img = UIImage(named: named) { return img }
        if let img = UIImage(named: "Images/\(named)") { return img }

        for ext in ["jpg", "png"] {
            if let url = bundle.url(forResource: named, withExtension: ext) ??
                bundle.url(forResource: "Images/\(named)", withExtension: ext),
               let data = try? Data(contentsOf: url),
               let img = UIImage(data: data) {
                return img
            }
        }
        return nil
    }
}
