//
//  WrapText.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

import SwiftUI

struct WrapText: View {

    @State private var truncated: Bool = false

    private var text: String
    var hasTrimText: Bool

    init(_ text: String, hasTrimText: Bool) {
        self.text = text
        self.hasTrimText = hasTrimText
    }

    private func determineTruncation(_ geometry: GeometryProxy) {
        let total = self.text.boundingRect(
            with: CGSize(
                width: geometry.size.width,
                height: .greatestFiniteMagnitude
            ),
            options: .usesLineFragmentOrigin,
            attributes: [.font: UIFont.systemFont(ofSize: 11)],
            context: nil
        )

        if total.size.height > geometry.size.height {
            self.truncated = true
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(self.text)
                .font( .systemCustom(size: 12, weight: .regular))
                .lineLimit(hasTrimText ? 3: nil)
                .background(GeometryReader { geometry in
                    Color.clear.onAppear {
                        self.determineTruncation(geometry)
                    }
                })

            if self.truncated && self.hasTrimText {
                Text(NSLocalizedString("seeMore", comment: "seeMore"))
                    .font( .systemCustom(size: 12, weight: .semibold))
            }
        }
    }

}
