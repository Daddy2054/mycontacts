//
//  ContactFormView.swift
//  mycontacts
//
//  Created by Jean on 13/06/25.
//

import PhotosUI
import SwiftUI

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return range(of: emailRegex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
struct ContactFormView: View {
    @Environment(\.dismiss) var dismiss

    @Binding var contact: Contact
    let onSave: (Contact) -> Void
// ghagsfq  hgdsf@dghsfhsdgc.iii
    @State private var selectedImage: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var isImageError: Bool = false
    @State private var avatarData: Data?

    @FocusState private var focusedField: Field?

    // TODO: isEmailValid
    var isEmailValid: Bool {
        contact.email.isValidEmail() && !contact.email.isEmpty
    }
    var emailCaption: String {
        contact.email.isEmpty ? "* Email is required" : "Email invalid"
    }
    var emailCaptionColor: Color {
        contact.email.isEmpty ? .blue : .red
    }

    // Disable save button
    var disabled: Bool {
        contact.firstName.isEmpty || contact.lastName.isEmpty || !isEmailValid
    }

    enum Field {
        case firstName
        case lastName
        case email
        case phoneNumber
        case address
    }

    private func customTextField(
        title: String,
        hint: String,
        value: Binding<String>,
        field: Field,

    ) -> some View {
        CustomTextField(
            title: title,
            hint: hint,
            value: value,
            onChange: {},
        )
        .focused($focusedField, equals: field)

    }

    var body: some View {
        NavigationStack {
            // MARK: Form
            Form {
                // MARK: Required Information
                Section("Required Information") {
                    customTextField(
                        title: "First Name",
                        hint: "Enter first name",
                        value: $contact.firstName,
                        field: .firstName
                    )
                    customTextField(
                        title: "Last Name",
                        hint: "Enter last name",
                        value: $contact.lastName,
                        field: .lastName
                    )
                    VStack(alignment: .leading, spacing: 4) {
                        customTextField(
                            title: "Email Address",
                            hint: "Enter Email Address",
                            value: $contact.email,
                            field: .email
                        )
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.none)
                        if !isEmailValid {
                            Text(emailCaption)
                                .foregroundStyle(emailCaptionColor)
                                .font(.caption)
                                .fontWeight(.medium)
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .trailing
                                )

                        }

                    }
                }
                //MARK: Optional Information
                Section("Optional Information") {
                    customTextField(
                        title: "Phone Number",
                        hint: "Enter phone number",
                        value: $contact.phoneNumber,
                        field: .phoneNumber
                    )
                    .keyboardType(.phonePad)
                    customTextField(
                        title: "Address",
                        hint: "Enter address",
                        value: $contact.address,
                        field: .address
                    )

                }
                //MARK: Avatar
                Section("Avatar") {
                    PhotosPicker(
                        selection: $selectedImage,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        ZStack {
                            AvatarView(
                                avatarImage: avatarImage,
                                name: contact.firstName
                            )
                            .frame(maxWidth: .infinity, alignment: .leading)

                            Text("Choose an Avatar")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    Button("Remove Avatar"){
                        avatarImage =  nil
                        avatarData = nil
                    }
                    
                    .foregroundStyle(.red)
                }
                .onChange(of: selectedImage) { _, newValue in
                    loadImage(from: newValue)

                }

            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }.foregroundStyle(
                        .red
                    )
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        contact.avatar = avatarData
                        onSave(contact)
                        dismiss()
                    }
                    .disabled(disabled)
                }
            }
            .navigationTitle("Add Contact")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if let avatarData = contact.avatar,
                    let uiImage = UIImage(data: avatarData)
                {
                    avatarImage = Image(uiImage: uiImage)
                }
            }
        }
    }

    private func loadImage(from item: PhotosPickerItem?) {
        guard let item = item else { return }

        item.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let data, let uiImage = UIImage(data: data) {
                        self.avatarImage = Image(uiImage: uiImage)
                        self.avatarData = data
                        isImageError = false
                    } else {
                        isImageError = true
                    }

                case .failure:
                    isImageError = false
                }
            }
        }
    }
}

#Preview {
    ContactFormView(contact: .constant(Contact()), onSave: { _ in })
}
