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
    @State private var showDeleteConfirmation = false
    @State private var deleteOffsets: IndexSet?
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(userVM.users, id: \.id){ user in
                    UserCard(userData: user)
                }
                .onDelete(perform: confirmDelete)
            }
            .navigationTitle("Users")
            .toolbar {
                ToolbarItem {
                    EditButton()
                        .foregroundColor(.red)
                }
            }
            .confirmationDialog("Are you sure you want to delete this item?", isPresented: $showDeleteConfirmation) {
                Button("Delete", role: .destructive) {
                    if let offsets = deleteOffsets {
                        delete(offsets: offsets)
                    }
                }
                Button("Cancel", role: .cancel) {
                    deleteOffsets = nil
                }
            }
            
            .task{
                await userVM.loadUsers()
            }
        }
    }
    
    private func confirmDelete(offsets: IndexSet) {
        deleteOffsets = offsets
        showDeleteConfirmation = true
    }
    
    private func delete(offsets: IndexSet) {
        userVM.users.remove(atOffsets: offsets)
        deleteOffsets = nil
    }}

#Preview {
    Users()
}
