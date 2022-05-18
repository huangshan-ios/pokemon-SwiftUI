//
//  View+Extensions.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 15/05/2022.
//

import Combine
import SwiftUI

extension View {
    func showErrorAlert(_ error: Binding<CommonUIError?>) -> some View {
        self.alert(item: error) { error in
            Alert(
                title: Text("You got an error"),
                message: Text(error.message),
                dismissButton: .default(Text("Got it!"))
            )
        }
    }
    
}
