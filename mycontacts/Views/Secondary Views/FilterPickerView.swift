//
//  FilterPickerView.swift
//  mycontacts
//
//  Created by Jean on 14/06/25.
//

import SwiftUI

struct FilterPickerView: View {
    @Binding var selectedFilter: Filter
    
    var body: some View {
Picker("Filter by", selection: $selectedFilter) {
    Text("Domain").tag(Filter.exampleDomain)
    Text("Has  Phone").tag(Filter.withPhoneNumber)
    Text("starts with 'A'").tag(Filter.startingWithA)
}.pickerStyle(SegmentedPickerStyle())
            .padding()
    }
}

#Preview {
    FilterPickerView(selectedFilter: .constant(.exampleDomain))
}
