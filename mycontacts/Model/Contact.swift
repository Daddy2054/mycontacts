//
//  Contact.swift
//  mycontacts
//
//  Created by Jean on 12/06/25.
//

import Foundation
import SwiftData

@Model
class Contact: Identifiable {
    // Required fiiel
    var firstName: String
    var lastName: String
    var email: String

    //Additional fields
    var phoneNumber: String = ""
    var address: String = ""

    //Optional Image
    @Attribute(.externalStorage)
    var avatar: Data?

    // Full name
    var fullName: String {
        "\(firstName) \(lastName)"
    }

    init(
        firstName: String = "",
        lastName: String = "",
        email: String = "",
        phoneNumber: String = "",
        address: String = "",
        avatar: Data? = nil,
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.address = address
        self.avatar = avatar
    }

    // Check if all input strings are empty
    func isEmpty() -> Bool {
        firstName.isEmpty && lastName.isEmpty && email.isEmpty
            && phoneNumber.isEmpty && address.isEmpty
    }

}
