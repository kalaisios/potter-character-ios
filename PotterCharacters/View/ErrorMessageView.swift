//
//  ErrorMessageView.swift
//  PotterCharacters
//
//  Created by Kalaiyarasan on 30/07/25.
//

import SwiftUI

struct ErrorMessageView: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.title2)
    }
}

#Preview {
    ErrorMessageView(text: AppConstants.Error.unableToFetchData)
}
