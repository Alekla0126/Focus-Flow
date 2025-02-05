# 📝 Focus Flow - To-Do List App

## Table of Contents
1. [Features](#-features)
2. [Screenshots](#-screenshots)
3. [Tech Stack](#-tech-stack)
4. [Getting Started](#-getting-started)
5. [Project Structure](#-project-structure)
6. [API Integration](#-api-integration)
7. [Unit Testing](#-unit-testing)
8. [To-Do List](#-to-do-list)
9. [Author](#-author)
10. [License](#-license)

---

## ✨ Features

✅ **Task Management**  
- Add, edit, delete, and search tasks effortlessly.  
- Mark tasks as **completed** or **pending** with a single tap.  

✅ **Persistent Storage**  
- **CoreData** integration ensures tasks are **saved and restored** even after closing the app.  

✅ **API Integration**  
- On first launch, tasks are **fetched from** [DummyJSON API](https://dummyjson.com/todos).  
- Offline? No worries! **Stored tasks** will be available even without an internet connection.  

✅ **Multithreading for Performance**  
- Operations like **loading, saving, deleting, and searching** are handled in **background threads** using **GCD/NSOperation**.  
- UI remains **smooth and responsive** while data processes run in the background.  

✅ **Modern UI & UX**  
- **Dark mode optimized** with a **black-themed UI**.  
- **Custom animations & smooth transitions** for an engaging user experience.  
- **Gesture-friendly controls** for quick task management.  

✅ **VIPER Architecture** *(Bonus Requirement)*  
- **Separation of Concerns**: View, Interactor, Presenter, Entity, and Router.  
- Highly **scalable, testable**, and **maintainable**.  

✅ **Unit Tests**  
- Core functionalities are tested to **ensure reliability**.  

✅ **Xcode 15 Compatibility**  
- Built with **Swift 5.9** and optimized for **iOS 17**.

---

## 📸 Screenshots
🔜 *(Add screenshots here to showcase the app!)*

---

## 🛠️ Tech Stack
- **SwiftUI** - Modern UI framework  
- **CoreData** - Persistent task storage  
- **Combine** - Reactive programming  
- **GCD / NSOperation** - Multithreading for smooth performance  
- **VIPER** - Clean modular architecture  
- **XCTest** - Unit testing for reliability

---

## 🚀 Getting Started

### 🔧 Installation

1. **Clone the repository:**  
   ```sh
   git clone https://github.com/yourusername/FocusFlow.git
   ```
2. **Open the project in Xcode 15.**
3. **Install dependencies (if any):**
   ```sh
   pod install  # (If using CocoaPods)
   ```
4. **Run the app** on iOS Simulator or a real device.

### 📂 Project Structure

```
FocusFlow/
│── Modules/
│   ├── Tasks/
│   │   ├── View/
│   │   ├── Interactor/
│   │   ├── Presenter/
│   │   ├── Entity/
│   │   ├── Router/
│   ├── Shared/
│   │   ├── Components/
│   │   ├── Extensions/
│── Resources/
│── Tests/
│── FocusFlow.xcodeproj
│── README.md
```

*Key Design Pattern:* **VIPER** - Each module is split into View, Interactor, Presenter, Entity, and Router for better scalability and testability.

### 📡 API Integration

Focus Flow fetches tasks from **DummyJSON API** on first launch.

Example API Response:

```json
{
  "todos": [
    {
      "id": 1,
      "todo": "Complete SwiftUI project",
      "completed": false
    }
  ]
}
```

After fetching, tasks are stored in CoreData for offline access.

### ✅ Unit Testing

Unit tests cover:
- Task creation, deletion, and editing
- API fetching & CoreData persistence
- UI responsiveness and background operations

*Run tests with:*

⌘ + U  *(Command + U in Xcode)*

---

## 📌 To-Do List

### 🚀 Future Improvements:
- iCloud Sync to access tasks across devices
- Reminders & Notifications for upcoming tasks
- Widgets for quick task previews

---

## 👨‍💻 Author

**[Your Name]** – iOS Developer  
**Portfolio:** [yourwebsite.com](https://yourwebsite.com)  
**Twitter:** [@yourhandle](https://twitter.com/yourhandle)

---

## 📜 License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

🔥 Enjoy using Focus Flow? Give it a ⭐ on GitHub! 🚀
