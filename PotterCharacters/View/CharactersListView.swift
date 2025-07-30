//
//  CharactersListView.swift
//  PotterCharacters
//
//  Created by Kalaiyarasan on 28/07/25.
//

import SwiftUI

struct CharactersListView: View {
    @StateObject private var viewModel = CharactersListViewModel()

    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let characters = viewModel.characters, !characters.isEmpty {
                VStack {
                    Text(AppConstants.potterCharacters)
                        .font(.title2)
                        .bold()
                    characterList(with: characters)
                }
            } else {
                ErrorMessageView(text: viewModel.errorMessage)
            }
        }
        .task {
            await viewModel.loadCharacters()
        }
    }

    private func characterList(with characters: [PotterCharacter]) -> some View {
        ScrollView {
            LazyVStack {
                ForEach(characters, id: \.index) { character in
                    if let index = character.index {
                        NavigationLink(destination: CharacterDetailView(index: index)) {
                            charctersView(with: character)
                                .padding(.horizontal)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    private func charctersView(with character: PotterCharacter) -> some View {
        VStack(alignment: .leading) {
            Text(character.fullName ?? "")
                .font(.headline)
                .bold()
            Text(character.nickname ?? "")
                .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

#Preview {
    CharactersListView()
}
