# 🤷 Oops!List - The Sarcastic To-Do App

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey.svg)](https://flutter.dev/)

> *"The best time to do a task was yesterday. The second best time is... well, maybe tomorrow?"*

A Flutter-based to-do list app with a unique sarcastic personality that judges your productivity (or lack thereof). Because sometimes you need a little sass to get things done! 😏

[🔗 **Download APK from Google Drive**](https://drive.google.com/file/d/1Phxo8_GrY8myirUVs-1K86FsdunVi3wQ/view?usp=drive_link)

---

## 📱 Screenshots

### Light Mode
| Splash Screen | Home Screen | Add Task |
|:---:|:---:|:---:|
| ![Splash](screenshots/splash.png) | ![Home Light](screenshots/home_light.png) | ![Add Task Light](screenshots/add_task_light.png) |

| Calendar View | Task Details | Profile |
|:---:|:---:|:---:|
| ![Calendar Light](screenshots/calendar_light.png) | ![Details Light](screenshots/details_light.png) | ![Profile Light](screenshots/profile_light.png) |

### Dark Mode
| Home Screen | Task Filters | Statistics |
|:---:|:---:|:---:|
| ![Home Dark](screenshots/home_dark.png) | ![Filters Dark](screenshots/filters_dark.png) | ![Stats Dark](screenshots/stats_dark.png) |

---

## ✨ Features

### 🎯 Core Functionality
- ✅ **Create, Read, Update, Delete (CRUD)** - Full task management
- 📅 **Date-based Tasks** - Set due dates for all your tasks
- ✔️ **Mark as Complete** - Toggle task completion status
- 🔍 **Smart Filtering** - Filter by All, Today, Upcoming, Overdue, or Completed
- 💾 **Offline Storage** - All data persists locally using Hive
- 🗑️ **Swipe to Delete** - Intuitive gesture-based deletion

### 🎨 UI/UX Features
- 🌓 **Dark/Light Theme** - Toggle between themes with smooth transitions
- 📊 **Progress Tracking** - Visual progress bar showing completion rate
- 📆 **Calendar Integration** - Beautiful calendar view with task markers
- 🏆 **Achievement System** - Sarcastic badges based on your productivity
- ⚠️ **Overdue Indicators** - Clear visual warnings for overdue tasks
- 🎭 **Sarcastic Personality** - Witty messages and comments throughout

### 📱 Screens

1. **Splash Screen** - Animated welcome screen
2. **Home Screen** - Main task list with filters and progress tracking
3. **Add Task Screen** - Create new tasks with date picker
4. **Edit Task Screen** - Modify existing tasks
5. **Task Detail Screen** - View complete task information
6. **Calendar Screen** - Monthly calendar view with task markers
7. **Profile Screen** - User statistics, settings, and achievements

---

## 🛠️ Tech Stack

### Framework & Language
- **Flutter** 3.0+ - Cross-platform mobile framework
- **Dart** 3.0+ - Programming language

### State Management
- **Provider** - Simple and efficient state management

### Local Storage
- **Hive** - Fast, lightweight NoSQL database
- **Hive Flutter** - Hive integration for Flutter

### UI/UX Libraries
- **Table Calendar** - Interactive calendar widget
- **Material 3** - Modern Material Design components
- **Intl** - Date formatting and internationalization

### Architecture
- **MVVM Pattern** - Model-View-ViewModel architecture
- **Widget Composition** - Reusable, modular widgets
- **Clean Code** - Well-organized project structure

![Flutter](https://img.shields.io/badge/Flutter-Framework-blue)
![Hive](https://img.shields.io/badge/Local_DB-Hive-yellow)
![Provider](https://img.shields.io/badge/State_Management-Provider-green)
![UI](https://img.shields.io/badge/Design-Material_3-red)

---

## 📦 Project Structure

```
lib/
├── main.dart                      # App entry point
├── models/
│   ├── task_model.dart           # Task data model
│   └── task_model.g.dart         # Generated Hive adapter
├── providers/
│   ├── task_providers.dart       # Task state management
│   └── theme_provider.dart       # Theme state management
├── screens/
│   ├── splash_screen.dart        # Animated splash screen
│   ├── home_screen.dart          # Main task list screen
│   ├── add_task_screen.dart      # Create new task
│   ├── edit_task_screen.dart     # Edit existing task
│   ├── task_detail_screen.dart   # Task details view
│   ├── calendar_screen.dart      # Calendar view
│   └── profile_screen.dart       # User profile & stats
└── widgets/
    ├── main_navigation.dart      # Bottom navigation wrapper
    ├── bottom_nav_bar.dart       # Bottom navigation bar
    ├── header_section.dart       # Home screen header
    ├── filter_chips_row.dart     # Task filter chips
    ├── task_list.dart            # Task list container
    ├── task_tile.dart            # Individual task card
    ├── calendar_header.dart      # Calendar screen header
    ├── calendar_view.dart        # Calendar widget
    ├── selected_day_task_list.dart # Calendar task list
    └── empty_day_placeholder.dart  # Empty state widget
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Android Studio / VS Code
- iOS Simulator (for iOS development) or Android Emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/AniketS1712/oops-list.git
   cd oops-list
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters** (if needed)
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Building for Release

#### Android APK
```bash
flutter build apk --release
```

#### Android App Bundle
```bash
flutter build appbundle --release
```

#### iOS
```bash
flutter build ios --release
```

---

## 📋 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  provider: ^6.1.1
  
  # Local Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # UI/Date
  intl: ^0.19.0
  table_calendar: ^3.0.9
  
  # Theme Persistence (Optional)
  shared_preferences: ^2.2.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  hive_generator: ^2.0.1
  build_runner: ^2.4.7
```

---

## 💡 How to Use

### Adding a Task
1. Tap the **red floating action button** (+)
2. Enter task title (required)
3. Add optional description
4. Select a due date
5. Tap **"Save Task"**

### Managing Tasks
- **Tap** a task to view full details
- **Check** the checkbox to mark as complete
- **Swipe left** to delete a task
- **Long press** for quick actions (alternative delete)

### Filtering Tasks
Use the filter chips to view:
- **All** - Every task you've created
- **Today** - Tasks due today
- **Upcoming** - Future tasks
- **Overdue** - Past due tasks (with warnings!)
- **Completed** - Finished tasks

### Calendar View
- View tasks organized by date
- Tap dates to see tasks for that day
- Blue dots indicate days with tasks
- Switch between month/week views

### Profile & Stats
- View completion percentage
- Check total, completed, pending, and overdue counts
- Toggle dark/light theme
- Clear all tasks (nuclear option!)

---

## 🎭 The Sarcastic Personality

Oops!List isn't your typical productivity app. It features witty, sarcastic messages throughout:

### Random Greetings
- *"Still pretending to be productive?"*
- *"Back again? Didn't finish yesterday's list?"*
- *"Motivation level: buffering..."*
- *"Oh look, someone's trying!"*

### Achievement Badges
- **80%+ completion**: *"Overachiever! 🎉 Who are you and what did you do with the real you?"*
- **60-79%**: *"Not Bad! 👍 Keep this up and people might think you're productive!"*
- **40-59%**: *"Trying... Sort Of 🤷 Baby steps count... I guess?"*
- **20-39%**: *"Room for Improvement 😅 At least you showed up!"*
- **<20%**: *"Professional Procrastinator 🏆 Mastered the art of doing nothing!"*

### Success Messages
- *"Task added! Will you actually do it? 🤔"*
- *"Task updated! Still gonna procrastinate? 😏"*
- *"Task deleted. Out of sight, out of mind! 🗑️"*

---

## 🎨 Design Philosophy

### Color Scheme
- **Primary**: Red Accent (#FF5252) - For that "urgent" feeling
- **Background**: Dynamic (light/dark)
- **Cards**: Elevated surfaces with subtle shadows
- **Accents**: Color-coded status indicators

### UI Principles
- **Material Design 3** - Modern, clean aesthetics
- **Consistent Spacing** - 8px base grid system
- **Rounded Corners** - 12-16px border radius for cards
- **Smooth Animations** - 300ms transitions
- **Clear Hierarchy** - Bold headings, readable body text

### Accessibility
- High contrast ratios
- Large touch targets (48x48 minimum)
- Clear visual feedback
- Semantic widget structure

---

## 🐛 Known Issues

Currently, there are no known critical bugs. However:

- Theme preference doesn't persist after app restart (optional fix available)
- Calendar performance may degrade with 1000+ tasks
- No cloud sync (local storage only)

---

## 🤝 Contributing

Contributions are welcome! Whether it's:
- 🐛 Bug fixes
- ✨ New features
- 📝 Documentation improvements
- 🎨 UI/UX enhancements
- 😏 More sarcastic messages!

### How to Contribute

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Code Style
- Follow [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable names
- Comment complex logic
- Keep widgets small and focused

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2024 [Aniket Singhal]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 👨‍💻 Author

**[Aniket Singhal]**
- GitHub: [@AniketS1712](https://github.com/AniketS1712)
- LinkedIn: [Aniket Singhal](https://www.linkedin.com/in/aniket-singhal-554b7a2b2)
- Email: ssinghalaniket@gmail.com

---

## 🔗 Links

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [Material Design 3](https://m3.material.io/)
- [Hive Database](https://docs.hivedb.dev/)
- [Provider Package](https://pub.dev/packages/provider)

---

## 💬 Support

If you like this project, please:
- ⭐ Star this repository
- 🐛 Report bugs via [Issues](https://github.com/AniketS1712/oops-list/issues)
- 💡 Suggest features via [Discussions](https://github.com/AniketS1712/oops-list/discussions)
- 📢 Share with friends!

---

## 📝 Changelog

### Version 1.0.0 (Current)
- ✅ Initial release
- ✅ Full CRUD functionality
- ✅ Task filtering and calendar view
- ✅ Dark/Light theme support
- ✅ Statistics and progress tracking
- ✅ Sarcastic personality throughout

---

<div align="center">

### Made with ❤️ and a lot of ☕

**"Remember: The best time to do a task was yesterday. The second best time is... well, maybe tomorrow?"** 😏

[⬆ Back to Top](#-oopslist---the-sarcastic-to-do-app)

</div>