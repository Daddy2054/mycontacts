//
//  ContactListView.swift
//  mycontacts
//
//  Created by Jean on 12/06/25.
//

import SwiftData
import SwiftUI

struct ContactListView: View {
    @Environment(\.modelContext) private var modelContext

    // MARK: Queries

    // MARK: First  name
    @Query(sort: \Contact.firstName, order: .forward)
    private var contactsByFirstName: [Contact]

    //MARK: Last name
    @Query(sort: \Contact.lastName, order: .forward)
    private var contactsByLastName: [Contact]

    //MARK: Phone number
    @Query(sort: \Contact.phoneNumber, order: .forward)
    private var contactsByPhoneNumber: [Contact]

    // MARK: State variables
    @State private var searchText: String = ""
    @State private var selectedSortOrder: SortOrder = .firstName
    @State private var isSortOrderReversed: Bool = false
    @State private var isAdvancedShown: Bool = false
    @State private var showMore: Bool = false
    @State private var currentContact: Contact = Contact()
    @State private var showEditView: Bool = false
    @State private var selectedFilter: Filter = .none

//    // MARK:  Sorted Contacts
//    var sortedContacts: [Contact] {
//        let baseContacts: [Contact]
//        switch selectedSortOrder {
//        case .firstName:
//            baseContacts = contactsByFirstName
//        case .lastName:
//            baseContacts = contactsByLastName
//        case .phoneNumber:
//            baseContacts = contactsByPhoneNumber
//        }
//        return isSortOrderReversed ? baseContacts.reversed() : baseContacts
//    }
    // MARK: Filter and Predicate  -advanced  Queries
    @Query(
        filter: #Predicate<Contact> {
            $0.email.contains("@example.com")
        }
    ) private var contactsWithExampleDomain: [Contact]

    @Query(
        filter: #Predicate<Contact> {
            !$0.phoneNumber.isEmpty
        }
    ) private var contactsWitPhoneNumbers: [Contact]

    @Query(
        filter: #Predicate<Contact> {
            $0.lastName.starts(with: "A")
        }
    ) private var contactsStartingWithA: [Contact]

    // MARK:  Filtered Contacts
    // TODO: Implement Filtered Contacts
    var filteredContacts: [Contact] {
        let baseContacts: [Contact]
        switch selectedSortOrder {
        case .firstName:
            baseContacts = contactsByFirstName
        case .lastName:
            baseContacts = contactsByLastName
        case .phoneNumber:
            baseContacts = contactsByPhoneNumber
        }

        var theFilterContacts: [Contact]
        switch selectedFilter {
        case .none:
            theFilterContacts = baseContacts
        case .exampleDomain:
            theFilterContacts = contactsWithExampleDomain
        case .withPhoneNumber:
            theFilterContacts = contactsWitPhoneNumbers
        case .startingWithA:
            theFilterContacts = contactsStartingWithA
        }
        
        // MARK: Reverse
        if isSortOrderReversed {
            theFilterContacts = theFilterContacts.reversed()
        }
        if searchText.isEmpty {
            return theFilterContacts
        } else {
            return theFilterContacts.filter { contact in
                contact.firstName.localizedCaseInsensitiveContains(searchText)
                    || contact.lastName
                        .localizedCaseInsensitiveContains(searchText)
                    || contact.address
                        .localizedCaseInsensitiveContains(searchText)
                    || contact.email
                        .localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    // TODO: Apply search filtering
    var body: some View {
        NavigationStack {
            VStack {
                if !filteredContacts.isEmpty {
                TextField("Search Contacts", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                    SortAndToggleView(
                        selectedSortOrder: $selectedSortOrder,
                        isSortOrderReversed: $isSortOrderReversed
                    )
                    
                    if isAdvancedShown {
                        FilterPickerView(selectedFilter: $selectedFilter)
                    }
                }
                // MARK: List
                if filteredContacts.isEmpty {
                    ContentUnavailableView(
                        "Enter a New Contact",
                        systemImage: "person.crop.circle.badge.xmark"
                    )

                } else {
                    
             
                List {
                    ForEach(filteredContacts) { contact in
                        ContactRowItemView(contact: contact, showMore: showMore)
                            .onTapGesture {
                                currentContact = contact
                                showEditView.toggle()
                            }

                    }
                    .onDelete { indexSet in
                        indexSet
                            .forEach { index in
                                modelContext.delete(filteredContacts[index])
                            }
                        do {
                            try modelContext.save()
                        } catch {
                            print("Failed to save context: \(error)")
                        }
                    }
                }
                }   }
            .sheet(
                isPresented: $showEditView,
                content: {
                    ContactFormView(contact: $currentContact) {
                        newContact in
                        modelContext.insert(currentContact)

                        try? modelContext.save()
                    }
                }
            )
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showMore.toggle()
                    } label: {
                        Label(
                            "Advanced",
                            systemImage: showMore ? "text.book.closed" : "book"
                        )
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        isAdvancedShown.toggle()
                        if !isAdvancedShown {
                            selectedSortOrder = .firstName
                            selectedFilter = .none
                        }
                    } label: {
                        Label(
                            "Advanced",
                            systemImage: isAdvancedShown
                                ? "wand.and.stars"
                                : "wand.and.stars.inverse"
                        )
                    }
                    // MARK: Add
                    Button {
                        currentContact = Contact()
                        showEditView.toggle()
                    } label: {
                        Label(
                            "Add Contact",
                            systemImage: "plus"
                        )
                    }

                }
            }
        }
    }
}

#Preview {
    ContactListView()
        .modelContainer(for: Contact.self)
}
