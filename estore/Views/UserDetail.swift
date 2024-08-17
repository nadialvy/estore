//
//  UserDetail.swift
//  estore
//
//  Created by Nadia Lovely on 17/08/24.
//

import SwiftUI

struct UserDetail: View {
    var user: UserModel
    var body: some View {
        VStack{
            Text("User Info")
                .fontWeight(.medium)
                .font(.title3)
                .padding(.top, 24)
            AsyncImage(url: URL(string: user.avatar)){ image in
                image
                    .resizable()
                    .frame(width: 180, height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } placeholder: {
                ProgressView()
                    .frame(width: 180, height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            Text(user.name)
                .fontWeight(.medium)
            Text(user.email)
                .foregroundStyle(.gray)
            Spacer()
            
        }

    }
}

#Preview {
    UserDetail(
        user: UserModel(
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
