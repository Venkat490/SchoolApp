//
//  SchoolDetailScreen.swift
//  NYCSchoolApp
//
//  Created by venkat Reddy on 06/02/25.
//

import SwiftUI

struct SchoolDetailScreen: View {
    let school: NYCSchool
    var body: some View {
        VStack(alignment: .leading) {
            Text(school.description ?? "")
                .accessibilityIdentifier("DetailDescription")
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SchoolDetailScreen(school: NYCSchool(schoolName: "ABC", city: "3434", description: "Test School"))
}
