//
//  SchoolListView.swift
//  NYCSchoolApp
//
//  Created by venkat Reddy on 06/02/25.
//

import SwiftUI

struct SchoolListScreen: View {
    @StateObject var viewModel = NYCSchoolViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    List(viewModel.schools, id: \.id) { school in
                        NavigationLink(destination: SchoolDetailScreen(school: school)) {
                            SchoolRow(school: school)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle("NYC High Schools")
        }
        .alert(viewModel.errorMessage ?? "", isPresented: $viewModel.showError, actions: {})
    }
}

#Preview {
    SchoolListScreen(viewModel: .init())
}
