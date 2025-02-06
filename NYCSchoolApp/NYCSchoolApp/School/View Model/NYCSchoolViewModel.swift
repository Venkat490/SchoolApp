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
        
         #if DEBUG
          mockDataForUITests()
          #endif

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

extension NYCSchoolViewModel {
    
    func mockDataForUITests() {
        if ProcessInfo.processInfo.arguments.contains("MOCK_VIEWMODEL_DATA_LOADED") {
            self.isLoading = false
            let school = NYCSchool(
                            schoolName: "Test School",
                            city: "Test City",
                            description: "Test Description"
                        )
            self.schools = [school]
            return
        }
        else if ProcessInfo.processInfo.arguments.contains("MOCK_VIEWMODEL_DATA_LOADING") {
            self.isLoading = true
            sleep(10)
            self.schools = []
        }
        else if ProcessInfo.processInfo.arguments.contains("MOCK_VIEWMODEL_DATA_LOADING_FAILURE") {
            
            Fail<[NYCSchool], SchoolError>(error: .invalidResponse)
                .delay(for: .seconds(1), scheduler: RunLoop.main)
                .sink(receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    switch completion {
                        case .finished:
                            print("Call Invoke finished in Mock Datat Failure Loading Case")
                        case .failure(let error):
                            self?.showError = true
                            self?.errorMessage = "Test error message"
                    }
                }, receiveValue: { _ in })
                .store(in: &cancellables)
                return
        }
    }
}

extension NYCSchoolViewModel {
    var accessibilityIdentifierProgressView: String {
        AccessibilityIdentifiers.SchoolsListScreen.loadingIndicator
    }
    
    var accessibilityIdentifierList: String {
        AccessibilityIdentifiers.SchoolsListScreen.schoolsList
    }
    
    var accessibilityIdentifierDescription: String {
        AccessibilityIdentifiers.SchoolsDetailScreen.schoolDescription
    }
}
