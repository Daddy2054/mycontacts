//
//  SplashScreenView.swift
//  mycontacts
//
//  Created by Jean on 14/06/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var scalEffect = 0.8
    
    
    var body: some View {
       VStack {
            if isActive {
               ContactListView()
                    .modelContainer(for: Contact.self)
           } else {
                    Image(systemName: "person.crop.circle.fill.badge.plus")
                   .resizable()
                   .scaledToFit()
                   .frame(width: 100, height: 100)
                   .foregroundStyle(.blue)
                   .scaleEffect(scalEffect)
                   .onAppear {
                       withAnimation(.easeInOut(duration: 1)) {
                           self.scalEffect = 1
                       }
                       DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                           self.isActive = true
                       }
                   }
                 Text("Welcome to Contacts")
                   .font(.largeTitle)
                   .bold()
                   .foregroundStyle(.primary)
                   .padding(.top,16)
           }
        }
       .onAppear {
           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
               withAnimation{
                   isActive = true
               }
               
           }
       }
    }
}

#Preview {
    SplashScreenView()
}
