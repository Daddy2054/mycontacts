//
//  AvatarView.swift
//  mycontacts
//
//  Created by Jean on 13/06/25.
//

import SwiftUI

struct AvatarView: View {
    let avatarImage: Image?
    let name: String

    var body: some View {
        if let avatarImage {
            avatarImage
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.gray, lineWidth: 1)
                }
                .padding(.trailing, 10)
        } else {
            Circle()
                .fill(.blue.opacity(0.2))
                .frame(width: 50, height: 50)
                .overlay {
                    Text(name.uppercased().prefix(1))
                        .font(.largeTitle)
                        .foregroundStyle(.blue)
                        .bold()
                }
                .padding(.trailing, 10)
        }
    }
}

#Preview {
    AvatarView(avatarImage: nil as Image?, name: "String"
               )
}
