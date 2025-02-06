# SchoolApp
This is a schools app to fetch NYC schools using swiftUI

This App displays the NewYork State school names and the location. The app fetches the data from the public API using a clear and responsive user interface.

## Features

- **Fetch School data**: Fetches and displays the school info for the New York State
- **MVVM Architecture**: Utilizes the Model-View-ViewModel (MVVM) pattern for a clean and testable codebase.
- **SOLID Principles**: Built with SOLID principles to ensure scalability, maintainability, and separation of concerns.
- **Comprehensive Testing**: Includes both unit tests and UI tests for reliable performance and quality assurance.

## Architecture

The app follows the **MVVM** with **Clean** architecture, ensuring separation between business logic, UI, and data management:

- **NYCSchoolModel**: Represents School data. Currently, we are just fetching school name, location city and description
- **NYCSchoolViewModel**: Manages data fetching, processing by Connecting with the UseCase, and binding to the UI.
- **UseCases**: App Built with Clean Architecture by using UseCases ( The dependencies are managed using resolver framework)
- **SchoolListScreen**: Displays school information and fetches whenever the the screen is loaded

## Code Quality

The app is built according to **SOLID principles**:
- **Single Responsibility Principle (SRP)**: Each class and component has a single responsibility.
        SchoolListScreen: Responsible for Displaying School Info for such as name & location
        SchoolDetailScreen : Responible to Provide School description in more detailed way
- **Open/Closed Principle (OCP)**: ** NYCSchoolModel** can be extended for adding more info from the Service if needed
- **Liskov Substitution Principle (LSP)**: **NetWorkClient**  is used to abstract only required method **fetchData**. This protocol can be used to create other Network Clients
- **Interface Segregation Principle (ISP)**: **HTTPClient** is the interface which segregated with only required method.
- **Dependency Inversion Principle (DIP)**: **MockGetSchoolsService** is created from protocol **SchoolServiceProtocol** this way writing unitTests is more straight forward 

## Network
**HTTPClient** is the class responsible for fetching data from api "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
**FetchSchoolDataUseCase** and SchoolServiceProtocol are useful to write more modular code and from the viewModel we just initialize UseCase to call API

## ErrorHandling
When there is a case of failure we will be showing the alert for the user.

## Testing

### Unit Tests
The app includes XCTests for:
- **NYCSchoolViewModel**: where it covers both success and failure scenarios. For the Unit tests app using mock json and mock classes to communicate.
- **NYCSchoolAppUITests** : Executes test case of UI Elements of SchoolListScreen

## Package Dependencies
This App using Resolver framework to support dependency injection
Dependency Injection frameworks support the Inversion of Control design pattern.

