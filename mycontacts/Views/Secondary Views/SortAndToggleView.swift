//
//  SortAndToggleView.swift
//  mycontacts
//
//  Created by Jean on 12/06/25.
//

import SwiftUI

struct SortAndToggleView: View {

    @Binding var selectedSortOrder: SortOrder
    @Binding var isSortOrderReversed: Bool

    var degrees: CGFloat {
        isSortOrderReversed ? 180 : 0
    }
    
    var body: some View {
        HStack {
            Picker("Sort By", selection: $selectedSortOrder) {
                Text("First Name").tag(SortOrder.firstName)
                Text("Last Name").tag(SortOrder.lastName)
                Text("Phone Number").tag(SortOrder.phoneNumber)
            }.pickerStyle(SegmentedPickerStyle())
            
            Image(systemName: "arrowshape.down.fill")
                .foregroundStyle(.blue)
                .rotationEffect(.degrees(degrees))
                .animation(.spring, value: isSortOrderReversed)
                .onTapGesture {
                    isSortOrderReversed.toggle()
                }
        }
        .padding()
    }
}

#Preview {
    SortAndToggleView(
        selectedSortOrder: .constant(.firstName),
        isSortOrderReversed: .constant(true)
    )
}
