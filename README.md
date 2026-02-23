# Ledgerly
Ledgerly is a personal expense tracking iOS application built with **Swift** and **SwiftUI**. It allows users to add, view, categorize, and visualize their expenses with a modern, intuitive interface. Ledgerly also supports local persistence via **Core Data** and synchronization with a backend service.

## Why SwiftUI instead of UIKit
SwiftUI is used in Ledgerly for several reasons:
- **Declarative Syntax:** UI is defined in a clear and concise way, reducing boilerplate code.
- **Live Previews:** SwiftUI allows real-time previews, speeding up development and iteration.
- **Reactive and State-Driven:** The UI automatically updates when data changes, integrating seamlessly with Combine.
- **Cross-Platform Potential:** SwiftUI can be used across iOS, macOS, iPadOS, and watchOS with minimal changes.
- **uture-Proof:** Apple is heavily investing in SwiftUI as the standard for modern UI development.

## Features
### Expense Management**
- Add, edit, and delete expenses.
- Assign categories to expenses (Food, Transport, Bills, Other).
- Search and filter expenses by title or category.

### Data Persistence**
-Local storage using **Core Data**.
- Repository pattern ensures clean separation of data layer and business logic.

### Backend Integration**
- Fetches remote expenses from a public API for demonstration purposes.
- Synchronizes local expenses with remote data asynchronously.

### Visualizations**
- Displays expenses in a **bar chart** grouped by category using SwiftUI Charts.
- Animated feedback on saving new expenses with **Lottie**.

### Notifications**
- Daily reminders to record expenses using **UserNotifications**.

### Architecture & Patterns**
- MVVM (Model-View-ViewModel) architecture.
- Repository pattern for data management.
- Reactive filtering using **Combine**.

## Requirements
* iOS 17.0+
* Xcode 15+
* Swift 5.9+

## Project Structure
```
Ledgerly/
├─ LedgerlyApp.swift           #App entry point
├─ Data/
│  ├─ Network/                 #Networking layer
│  │  └─ NetworkService.swift
│  ├─ Persistence/             #Core Data stack & models
│  │  └─ CoreDataStack.swift
│  └─ Repositories/            #Expense repository
│     └─ ExpenseRepository.swift
├─ Domain/
│  ├─ Models/                  #Core domain models
│  │  └─ Expense.swift
│  └─ Repositories/            #Repository protocols
│     └─ ExpenseRepositoryProtocol.swift
├─ Presentation/
│  ├─ ViewModels/              #MVVM view models
│  │  └─ ExpenseListViewModel.swift
│  └─ Views/                   #SwiftUI views
│     ├─ LedgerlyTabView.swift
│     ├─ AddExpenseView.swift
│     ├─ CategoriesView.swift
│     ├─ ExpenseDetailView.swift
│     └─ ExpensesChartView.swift
```

## Why MVVM with Clean Architecture
Ledgerly uses MVVM combined with Clean Architecture to improve maintainability and testability:
1. Separation of Concerns:
    - Model: Represents the domain objects (Expense).
    - View: SwiftUI views are declarative and only handle UI presentation.
    - ViewModel: Handles business logic, input validation, and prepares data for the UI.

2. Clean Architecture Principles:
- Repositories abstract data sources (local or remote) from the rest of the app.
- Domain Layer defines protocols and models independent of the UI or persistence, making code modular and easier to test.

3. Benefits:
- Easier to maintain and scale.
- UI changes don't affect business logic.
- Facilitates unit testing without UI dependencies.

## Installation

1. Clone the repository:
```bash
   git clone https://github.com/AdrianMalmierca/Ledgerly
   cd ledgerly
```

2. Open the project in Xcode:
```bash
open Ledgerly.xcodeproj
```

3. Build and run on a simulator or device.

## Usage
- Launch the app and navigate through the **Expenses** and **Chart** tabs.
- Use the **+ button** to add a new expense.
- Filter expenses by category using the category grid.
- Sync local data with the remote backend by tapping **Sync**.

## Dependencies
- [**Lottie**](https://github.com/airbnb/lottie-ios)
    - For animated success feedback.
- SwiftUI Charts 
    - Built-in **Swift Charts** framework for visualizations.

## Future Improvements
- **Real Backend Integration:** Replace the placeholder API with a proper backend to persist user expenses across devices.
- **Authentication:** Add user accounts and secure login.
- **Recurring Expenses:** Support for automatic recurring expenses (e.g., monthly bills).
- **Advanced Analytics:** More detailed charts, trends, and category breakdowns.
- **Dark Mode Enhancements:** Optimize UI elements for better dark mode support.
- **Notifications Customization:** Allow users to set custom reminder times and frequencies.
- **Localization:** Support multiple languages for international users.
- **Expense Attachments:** Add the ability to attach receipts or images to expenses.


## What did I learn?
When I started to program with Swift I alwayd did using UIKit, that's why I wanted to do this project with SwiftUI, because It's gaining more and more importance in modern iOS app development. Although UIKit is still widely used, the market is currently shifting towards SwiftUI, though UIKit will continue to be used for legacy apps, for example. I've learned to work more effectively with this framework, as well as understand the structure of projects, since I've used the MVVM architecture with clean architecture.

## Author
Adrián Martín Malmierca

Computer Engineer & Mobile Applications Master's Student