//
//  ContactRowItemView.swift
//  mycontacts
//
//  Created by Jean on 12/06/25.
//

import SwiftUI

struct ContactRowItemView: View {
    let contact: Contact
    let showMore: Bool
    var showAddressPhoneButton: Bool {
        !contact.phoneNumber.isEmpty || !contact.address.isEmpty
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                // MARK: Avatar
                AvatarContactView(contact: contact)

                NameAndEmailView(contact: contact)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            if showMore {
                VStack(alignment: .leading, spacing: 10) {
                    if !contact.phoneNumber.isEmpty {
                        HStack {
                            Image(systemName: "phone.fill")
                                .foregroundStyle(.blue)
                            Text(contact.phoneNumber)
                                .foregroundStyle(.primary)
                        }

                    }
                    if !contact.address.isEmpty {
                        HStack {
                            Image(systemName: "house.fill")
                                .foregroundStyle(.blue)
                            Text(contact.address)
                                .foregroundStyle(.primary)

                                .lineLimit(3)
                        }

                    }
                }

            }
        }
    }
}

#Preview {
    ContactRowItemView(
        contact: .init(
            firstName: "John",
            lastName: "Doe",
            email: "john.doe@example.com",
            phoneNumber: "123-456-7890",
            address: "123, Main St, Springfield, IL",
            avatar: nil
        ),
        showMore: true
    )
    .padding()
}
