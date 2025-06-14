//
//  AvatarView.swift
//  mycontacts
//
//  Created by Jean on 13/06/25.
//

import SwiftUI

struct AvatarContactView: View {
    let contact: Contact
    var body: some View {
        if let avatarData = contact.avatar,
            let uiImage = UIImage(data: avatarData)
        {
            Image(uiImage: uiImage)
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
                    Text(contact.fullName.prefix(1))
                        .font(.largeTitle)
                        .foregroundStyle(.blue)
                        .bold()
                }
                .padding(.trailing, 10)
        }
    }
}

#Preview {
    AvatarContactView(contact: .init(firstName: "Jean", lastName: "Dupont", email: "jean@dupont.fr", phoneNumber: "+33-612-345-678", address: "123 rue de la Paix", avatar: nil))
}