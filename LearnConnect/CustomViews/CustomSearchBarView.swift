//
//  CustomSearchBarView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 23.11.2024.
//

import SwiftUI

struct CustomSearchBarView: View {
    
    @AppStorage("isDarkMode") private var darkMode = false
    @Binding var text: String
    var searchDisabled: Bool = false
    
    var body: some View {
        ZStack {
            TextField("", text: $text, prompt: Text(" 🔍 Search Course").foregroundColor(.gray)
                .foregroundColor(darkMode ? .white : .black)
                .font(.system(size: 16)))
                .textFieldStyle(.plain)
                .padding(.all, 10)
                .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.appBackground))
                .autocorrectionDisabled(true)
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .disabled(searchDisabled)
        }
    }
}

#Preview {
    CustomSearchBarView(text: .constant("asasdad"))
}
