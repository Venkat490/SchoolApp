//
//  Bundle+Extension.swift
//  NYCSchoolAppTests
//
//  Created by venkat Reddy on 06/02/25.
//

import Foundation

extension Bundle {
    
    func readCOntentsOfFile(_ file: String) -> Data? {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            return nil
        }
    }
}
