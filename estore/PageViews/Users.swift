//
//  Users.swift
//  estore
//
//  Created by Nadia Lovely on 12/08/24.
//

import SwiftUI

struct Users: View {
    @StateObject private var userVM = UserVM()
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(userVM.users, id: \.id){ user in
                    UserCard(userData: user)
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Users")
            .toolbar{
                ToolbarItem{
                    EditButton()
                    .foregroundColor(.red)
                }
            }
            .task{
                await userVM.loadUsers()
            }
        }
    }
    
    private func delete(offsets: IndexSet) {
        userVM.users.remove(atOffsets: offsets)
    }
}

#Preview {
    Users()
}
