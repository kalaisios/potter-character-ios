//
//  CharacterDetailView.swift
//  PotterCharacters
//
//  Created by Kalaiyarasan on 29/07/25.
//

import SwiftUI

struct CharacterDetailView: View {
    let index: Int
    @StateObject private var viewModel: CharacterDetailViewModel = CharacterDetailViewModel()

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else if let character = viewModel.character {
                characterView(with: character)
            } else if viewModel.error != nil {
                ErrorMessageView(text: AppConstants.Error.unableToFetchData)
            }
        }
        .task {
            await viewModel.fetchCharacterDetails(with: index)
        }
    }

    private func characterView(with character: PotterCharacter) -> some View {
        ScrollView {
            VStack(spacing: 20) {
                imageView(with: character.image)
                informationView(for: character)
                if let children = character.children, !children.isEmpty {
                    childrenView(for: children)
                }
                otherDetailsView(for: character)
            }
        }
        .navigationTitle(character.fullName ?? AppConstants.character)
    }

    @ViewBuilder
    private func imageView(with image: String?) -> some View {
        if let image = viewModel.character?.image, let imageURL = URL(string: image) {
            AsyncImage(url: imageURL, content: { image in
                image.resizable()
            }, placeholder: {
                Image(systemName: "person.circle")
                    .resizable()
                    .foregroundColor(.gray)
            })
            .frame(width: 180, height: 180)
            .clipShape(Circle())
        }
    }

    private func informationView(for character: PotterCharacter) -> some View {
        VStack(spacing: 10) {
            Text(character.fullName ?? "")
                .font(.headline)
            Text(character.nickname ?? "")
                .font(.subheadline)
            Text(character.birthdate ?? "")
                .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
        )
        .padding(.horizontal, 30)
    }

    private func childrenView(for children: [String]) -> some View {
        VStack {
            Text(AppConstants.children)
                .bold()
            Spacer()
                .frame(height: 10)
            ForEach(children, id: \.self) { child in
                Text(child)
                    .italic()
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
        )
        .padding(.horizontal, 30)
    }

    private func otherDetailsView(for character: PotterCharacter) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Group {
                HStack {
                    Text(AppConstants.interpretedBy).bold()
                    Text(character.interpretedBy ?? "")
                    Spacer()
                }
                HStack {
                    Text(AppConstants.hogwartsHouse).bold()
                    Text(character.hogwartsHouse ?? "")
                    Spacer()
                }
            }
            .font(.body)
        }
        .padding(.horizontal, 30)
    }
}

#Preview {
    CharacterDetailView(index: 1)
}
