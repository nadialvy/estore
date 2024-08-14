//
//  Users.swift
//  estore
//
//  Created by Nadia Lovely on 12/08/24.
//

import SwiftUI

struct Users: View {
    @StateObject private var userVM = UserVM()
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(userVM.users, id: \.id){ user in
                    UserCard(userData: user)
                }
            }
            .navigationTitle("Users")
            .toolbar{
                ToolbarItem{
                    Button{
                        print("hi from edit button user")
                    } label : {
                        Text("Edit")
                            .foregroundStyle(.red)
                    }
                }
            }
            .task{
                await userVM.loadUsers()
            }
        }
    }
}

#Preview {
    Users()
}
