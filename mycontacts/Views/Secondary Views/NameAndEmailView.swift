//
//  NameAndEmailView.swift
//  mycontacts
//
//  Created by Jean on 13/06/25.
//

import SwiftUI

struct NameAndEmailView: View {
    let contact: Contact
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(contact.fullName)
                .font(.headline)
                .foregroundStyle(.primary)
            Text(contact.email)
                .font(.subheadline)
                .foregroundStyle(.secondary)

        }
    }
}

#Preview {
    NameAndEmailView(
        contact: .init(
            firstName: "John",
            lastName: "Doe",
            email: "john.doe@example.com",
            phoneNumber: "123-456-7890",
            address: "123, Main St, Springfield, IL",
            avatar: nil
        )
    )
}
