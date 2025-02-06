//
//  SchoolRow.swift
//  NYCSchoolApp
//
//  Created by venkat Reddy on 06/02/25.
//

import SwiftUI

struct SchoolRow: View {
    let school: NYCSchool
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(school.schoolName ?? "")
                .font(.headline)
            Text(school.city)
                .font(.subheadline)
        }
        .accessibilityIdentifier("SchoolRow_\(school.id)")
        .padding()
    }
}

#Preview {
    SchoolRow(school: NYCSchool(schoolName: "ABC School",
                                city: "Newyork",
                                description: "My School"))
}
