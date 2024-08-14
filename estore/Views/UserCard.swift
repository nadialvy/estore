//
//  UserCard.swift
//  estore
//
//  Created by Nadia Lovely on 14/08/24.
//

import SwiftUI

struct UserCard: View {
    var userData: UserModel
    var body: some View {
        HStack(){
            AsyncImage(url: URL(string: userData.avatar)){ image in
                image
                    .resizable()
                    .frame(width: 82, height: 82)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
                    .frame(width: 82, height: 82)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading){
                Text(userData.name)
                    .foregroundStyle(.red)
                    .font(.title2)
                Text(userData.email)
                    .foregroundStyle(.gray)
                    .padding(.vertical, 2)
                Text(userData.role)
                    .foregroundStyle(.gray)
            }
        }
        .padding()
    }
}

#Preview {
    UserCard(
        userData: UserModel(
            id: 1,
            email: "test@gmail.com",
            password: "pass123",
            name: "Shella",
            role: "USER",
            avatar: "https://i.imgur.com/LDOO4Qs.jpg",
            creationAt: "2024-08-12T23:30:58.000Z",
            updatedAt: "2024-08-12T23:30:58.000Z"
        )
    )
}
