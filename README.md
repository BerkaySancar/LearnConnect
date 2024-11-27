# LearnConnect – [App Preview](#app-preview)
LearnConnect is a modern, video-based educational platform that allows users to enroll in courses, watch lesson videos, and manage their learning progress efficiently. This project was developed as a case study to demonstrate expertise in SwiftUI, MVVM architecture, and Core Data integration.

## Technologies Used
- **Language & Framework:** Swift and SwiftUI
- **iOS Version:** iOS 17.0+
- **Architecture:** MVVM with Coordinator pattern
- **Database:** Core Data for local data management, UserDefaults for API data caching
- **Firebase:** Authorization & Push Notification & Crashlytics
- **Testing:** Unit tests for critical functionalities
- **Video Management:** AVKit for video playback and progress tracking
- **Custom Components:** For reusable views
- **Useful and Highly Experienced UI/UX**
- **Mock API:** MockAPI.io for simulating course data during development

## Mock API Details
LearnConnect utilizes a custom API that I personally created using [MockAPI.io](https://mockapi.io) to simulate course data during development.

Below is an example of the JSON structure used:

```json
[
    {
        "createdAt": "2024-11-24T01:02:14.794Z",
        "name": "Mastering Minimalist Design: The Art of Less",
        "description": "Discover the principles of minimalist design and learn how to create impactful visuals with simplicity. Perfect for aspiring designers and enthusiasts.",
        "instructor": "Charlotte Nienow",
        "video": "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_20mb.mp4",
        "thumbnail": "https://www.ziflow.com/hubfs/Video%20proofing%20The%20process%2C%20features%2C%20and%20tools%20for%20creative%20teams.jpg",
        "category": "Design",
        "id": "1"
    },
    {
        "createdAt": "2024-11-24T10:59:40.555Z",
        "name": "Introduction to Python: Coding for Beginners",
        "description": "Learn the basics of Python programming with practical examples and exercises. A beginner-friendly guide to one of the most popular programming languages.",
        "instructor": "Yvette Wiza",
        "video": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
        "thumbnail": "https://dac.digital/wp-content/uploads/2023/07/1ud5eeycUbeH1kp1ln_gkJg-1200x680.jpe",
        "category": "Software",
        "id": "2"
    }
]
```

## Implemented Features
- **User Management:**
  - User registration and login with email and password.
  - View and manage user profiles.
  - Current logged in user management.
- **Course Management:**
  - List available courses dynamically.
  - Enroll in courses and track progress locally.
- **Video Player:**
  - Watch course videos with progress tracking.
  - Resume videos from the last watched timestamp.
- **Dark Mode Support:**
  - Full dark mode compatibility across the app.

## Bonus Features ✅
The following bonus features were implemented:
- ✅ **Category Filtering and Search:** Users can filter courses by category or search by keywords.
- ✅ **Favorites (Watchlist):** Users can mark courses as favorites for easy access.
- ✅ **Video Speed Control:** Users can adjust playback speed while watching videos.
- ✅ **Push Notifications:** Users receive notifications about new courses or events.

## Installation
1. Clone the repository:
    - git clone https://github.com/BerkaySancar/LearnConnect
    - Open the project on Xcode
    - Build and Run
  
# App Preview


https://github.com/user-attachments/assets/ffe37ebc-1bff-48e1-bb9d-3a720af4dad8



## Notifications
![learnNotification](https://github.com/user-attachments/assets/08fe4d6e-3698-459f-96ca-2227c5e85225)

## Login Management 


https://github.com/user-attachments/assets/b67b5a4a-2293-4656-813c-9090d3a70544





