//
//  NYCSchoolViewModel.swift
//  NYCSchoolApp
//
//  Created by venkat Reddy on 06/02/25.
//

import Foundation
import Combine
import Resolver

class NYCSchoolViewModel: ObservableObject {
    @Published var schools: [NYCSchool] = []
    private var getSchoolsTask: Task<Void, Never>?

    private var cancellables = Set<AnyCancellable>()
    @Injected private var fetchSchoolsDataUseCase: FetchSchoolDataUseCaseProtocol
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String?

    init() {
        fetchSchools()
    }
}

extension NYCSchoolViewModel {
    func fetchSchools() {
        isLoading = true
        fetchSchoolsDataUseCase()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.handleError(error: error)
                case .finished:
                    print("finished execution")
                }

            }, receiveValue: { [weak self] schools in
                self?.handleSchoolsResponse(response: schools)
            })
            .store(in: &cancellables)
    }
    
    private func handleSchoolsResponse(response: [NYCSchool]) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = false
            self?.schools = response
        }
    }
    
    private func handleError(error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = false
            self?.showError = true
            self?.errorMessage = error.localizedDescription
        }
    }
}
