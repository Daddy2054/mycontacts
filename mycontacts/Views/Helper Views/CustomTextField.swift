//
//  CustomTextField.swift
//  mycontacts
//
//  Created by Jean on 12/06/25.
//

import SwiftUI

struct CustomTextField: View {
    let title: String
    let hint: String
    @Binding var value: String
    var onChange: () -> Void
    @FocusState private var isActive: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption2)
            TextField(hint, text: $value)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .autocorrectionDisabled(true)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isActive ? .blue : .gray.opacity(0.5),
                        lineWidth: 1.5)
                    ).focused(
                        $isActive
                    )
                
        }
    }
}

#Preview {
    CustomTextField(
        title: "First Name",
        hint: "Enter First Name",
        value: .constant("Name"),
        onChange: {}
    ).padding()
}
