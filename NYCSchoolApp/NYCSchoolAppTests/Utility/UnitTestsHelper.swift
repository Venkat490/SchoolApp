//
//  UnitTestsHelper.swift
//  NYCSchoolAppTests
//
//  Created by venkat Reddy on 06/02/25.
//

import Foundation
@testable import NYCSchoolApp

enum GetSchoolsMockFileType: String {
    case succes =  "Get_School_success.json"
    case failure
}

class UnitTestsHelper {
    func getSchoolsResponse(mockFileType: GetSchoolsMockFileType) -> [NYCSchool]? {
        guard let array = getArray(from: mockFileType.rawValue) else { return [] }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: array, options: [])
            let response = try JSONDecoder().decode([NYCSchool].self, from: jsonData)
            return response
        } catch {
            print("Error decoding schools data: \(error)")
            return []
        }
    }

    func getArray(from mockResponseFile: String) -> [[String: Any]]? {
        let mockData = Bundle(for: type(of: self)).readCOntentsOfFile(mockResponseFile)
        guard let data = mockData else { return nil }
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            return jsonObject as? [[String: Any]] // Expect an array of dictionaries
        } catch {
            print("Error serializing JSON: \(error)")
            return nil
        }
    }
}
