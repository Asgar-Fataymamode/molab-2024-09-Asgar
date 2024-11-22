# Week 1 - Football Match Simulation in Swift

Overview:
Over several hours this week (around **5 hours**), I have been learning the **Swift programming language**. Specifically, I've focused on understanding syntax, functions, and how to structure simple projects.

Resources I've Used:
- [Swift Guided Tour Documentation](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/guidedtour/)
- [Quick Swift Tutorial by YouTube (CodeWithChris)](https://www.youtube.com/watch?v=n5X_V81OYnQ&t=604s&pp=ygUUc3dpZnQgcXVpY2sgdHV0b3JpYWw%3D)
- [Another Swift Basics Video Tutorial (CodeWithChris)](https://www.youtube.com/watch?v=CwA1VWP0Ldw&pp=ygUUc3dpZnQgcXVpY2sgdHV0b3JpYWw%3D)


Description:
This project is a **Football Match Simulator** built in Swift using **Xcode Playground**. The project simulates a full football match where goals, fouls, and cards are randomly generated. The game tracks and displays the score in real-time and includes visual animations like goal celebrations and showing yellow or red cards for fouls.

Features:
- **Randomized match events**: goals, fouls, and no event occurrences.
- **Displays the current score** after each goal.
- **Goal celebration animation** with emojis.
- **Yellow and red card display** for fouls.
- **Real-time event simulation** with a delay.

What I Learned from the Project:
- How to structure and organize a Swift project.
- Handling arrays and looping through data structures to simulate events.
- Using emojis to create fun animations within the console.
- Applying Swift functions with parameters to simulate complex events.
- Understanding how to push and organize projects on GitHub.


# Week 2 - Football ASCII Image Display

Overview: This week, I spent around **3 hours** continuing to learn **Swift**. I built upon the foundational knowledge I gained in Week 1 and applied it to a new project. This project focused on loading and displaying images created using ASCII text in a Swift Playground. 

Description:
The task was to display a series of football-related ASCII images in order, with descriptions preceding each image. The ASCII art files (like the stadium, players, and goal) were stored in a resources folder, and the playground loads and displays them sequentially.

Features:
- **Sequential display of ASCII images** representing a football match.
- **Descriptions** are shown before each image, providing context.
- **Images sourced from the resources folder**: ASCII files were loaded dynamically and displayed.
- **Simple code structure**: Functions were used to read from text files and print ASCII art to the console.

What I Learned from the Project:
- How to organize external resources (like `.txt` files) in an Xcode Playground.
- Loading and displaying data (ASCII art) from external text files in Swift.
- Using Swift functions to handle repetitive tasks such as displaying text and images in sequence.


# Week 3 - Football Random Facts App

Overview:
The **Football Clubs and Random Facts App** is a simple SwiftUI-based application that displays random football facts and images for some of the most famous football clubs in the world. 

Features:
- **Random Fact Generation**: Each football club has a list of facts and corresponding images. When the user selects a club and presses the **"Generate Random Fact"** button, a random fact about the club is displayed alongside an image.
- **Clubs Included**: The app includes the following football clubs:
  - Chelsea
  - Manchester United
  - Liverpool
  - Arsenal
 
# Week 4 - Football Trivia Game

Overview:
The **Football Trivia Game** is an application that challenges users with trivia questions related to both **club-level** and **international football**. 

Features:
- **Club and International Trivia**: The app offers two categories of trivia questions: **Club Level Trivia** and **International Level Trivia**. Users can select their preferred category from the home screen.
- **Multiple-Choice Questions**: Each trivia question provides users with **four possible answers**. Users must select the correct answer to proceed to the next question.
- **Images for Context**: Each trivia question is accompanied by an image relevant to the topic, enhancing user engagement.
- **Countdown Timer**: A **15-second countdown timer** is displayed for each question, challenging users to respond quickly before time runs out.
- **Correct and Incorrect Feedback**: Upon selecting an answer, the correct answer is highlighted in **green** and incorrect answers in **red**, giving immediate visual feedback.
- **Game Over and Celebration Screens**: If a user answers all questions correctly, a **congratulations message** with a **confetti animation** is displayed. If the user runs out of time or selects an incorrect answer, they are presented with a **Game Over** message.
- **Restart Option**: After completing the trivia (either by winning or losing), users are presented with an option to **restart** and play again.

# Week 5 - Updated Football Trivia Game (Version 2)

Overview:
The **Football Trivia Game** is an application that challenges users with trivia questions related to both **club-level** and **international football**. 

Features:
- Improved Football Trivia Game, with high scores and achievements, showcasing data storage

# Week 6 - Updated Football Trivia Game (Version 3)

Features
- Improved Football Trivia Game, with data storage dealing with JSON objects
- Implemented a login system, where users log in with their usernames
- The high scores of each user is saved, as well as the highest score achieved.
- Whenever a user logs in, the latter can view his high score in a leaderboard compared to the scores achieved by everyone else

# Week 7 - Football Diary

Features
- Allow users to create a digital album of football-related images and memories.
- Users can upload football images, add descriptions, and apply image filters to customize each page of the album.
- This project showcases image manipulation.
- Users can also add new pages and delete existing ones in this football diary book.



# Week 8 - ExpressEmojis

Features:
This app leverages face mesh technology to recognize and respond to various facial expressions in real-time. By identifying key expressions such as smiling, being angry, shocked, sad etc the app provides an interactive and fun experience by generating corresponding emojis on the screen. This dynamic emoji overlay feature allows users to see expressive emojis appear instantly as their facial expressions change, creating an engaging and entertaining experience.


# Week 9 - Implementing Firebase Backend for Final Project

1. User Data and Profiles
- **Firebase Authentication** secures user accounts and enables seamless cross-device syncing.
- **Firestore** stores user profiles, preferences, and training history for personalized recommendations.

2. Training Logs and Progress Tracking
- **Firestore** records daily training logs, including completed drills, reps, and notes, to power analytics and visual progress reports.

3. Drill Library and Modules
- The drill library and modules are stored in **Firestore**, categorized by skill type and difficulty level for easy retrieval and updates.

4. Goals, Challenges, and Leaderboards
- **Firestore** tracks user-defined goals, achievements, and leaderboard standings.
- **Firebase Realtime Database** ensures leaderboards and community challenge rankings update in real time.

5. Push Notifications and Reminders
- **Firebase Cloud Messaging** sends personalized reminders, motivational alerts, and progress updates.

6. Analytics and Insights
- **Firebase Analytics** monitors user engagement, providing insights into skill usage, favorite drills, and progress trends.
- **Firebase ML** enhances AI-driven recommendations for drills and training plans.

---


# Week 10 - Final Project Proposal: *MasterKick*

## Problem
Aspiring footballers often struggle to reach their full potential due to the absence of structured and personalized training programs tailored to their individual needs. Most resources available today are generic, leaving players without a clear path to track progress, stay motivated, or improve specific skills systematically. Additionally, maintaining consistent practice and achieving measurable goals becomes challenging without proper guidance and insights. This gap prevents many passionate players from mastering the skills they need to excel.

## App Idea
*MasterKick*—"Master Every Kick, Reach Every Goal"—is the ultimate all-in-one football training companion designed to empower aspiring footballers. The app combines cutting-edge technology, interactive tools, and gamification to revolutionize how players train and improve. By offering personalized training plans, tracking progress, and fostering a competitive yet supportive community, *MasterKick* ensures users stay motivated, focused, and on track to achieve their dreams of becoming top-notch footballers.

## Key Features

1. User Profiles and Personalization
- Users create detailed profiles with information such as age, skill level, preferred position, and training goals.
- *MasterKick* tailors specific training recommendations based on user profiles, ensuring every drill and goal is relevant to their needs.

2. Goals and Challenges
- Users can set personal goals (e.g., "Improve passing accuracy by 20%") and track their progress through visual indicators.
- Weekly and monthly challenges, such as completing specific drills or achieving milestones, motivate users to push their limits.
- Unlockable achievements provide rewards for consistency, skill improvement, and goal completion.

3. Training Modules and Drill Library
- A robust library of football drills and training modules categorized into shooting, dribbling, passing, agility, and fitness.
- Each drill includes video demonstrations, step-by-step instructions, and tips to ensure proper execution.
- Progressive difficulty levels allow users to gradually enhance their skills as they advance.

4. Interactive Training Log and Analysis
- A daily log enables users to record completed drills, reps, time spent, and notes about their performance.
- Skill-specific graphs and analytics visualize user progress over time, helping identify strengths and areas for improvement.

5. Smart Reminders and Notifications
- Customizable reminders based on training schedules ensure users remain consistent in their practice.
- Notifications celebrate goal milestones and deliver weekly/monthly progress summaries, keeping users motivated and engaged.

6. Leaderboards and Community Engagement
- Leaderboards allow users to compare their progress with friends or other app users, fostering a sense of community and healthy competition.
- Weekly or monthly competitions rank users based on activity levels, completed drills, and skill improvements.
- Automated progress reports summarize key training stats, such as completed drills, time spent, and skills improved.

7. Interactive Gamification
- Gamified elements include badges, unlockable levels, and rewards for consistency and milestones.
- Community challenges encourage group participation, motivating users to compete or collaborate with peers.

8. Advanced Data Visualization
- Graphs and dashboards display progress for each skill category, helping users identify patterns and adjust their focus.
- Performance trends guide users toward balanced improvement across all skills.

9. Social Features
- Users can create training groups, join communities, and participate in team challenges.
- A mentor feature connects users with experienced players or trainers for advice and motivation.

10. Database and Firebase Usage
- User Data and Profiles
- Training Logs and Progress Tracking
- Goals, Challenges, and Leaderboards
- Push Notifications and Reminders


Homepage


![homepage](https://github.com/Asgar-Fataymamode/molab-2024-09-Asgar/blob/main/Week%2010/Images/homepage.png)


Sign-Up Page

![signup1](https://github.com/Asgar-Fataymamode/molab-2024-09-Asgar/blob/main/Week%2010/Images/signup1.png)

![signup2](https://github.com/Asgar-Fataymamode/molab-2024-09-Asgar/blob/main/Week%2010/Images/signup2.png)

Progress Tracker

![progress_tracker](https://github.com/Asgar-Fataymamode/molab-2024-09-Asgar/blob/main/Week%2010/Images/progress.png)

Goals

![goals](https://github.com/Asgar-Fataymamode/molab-2024-09-Asgar/blob/main/Week%2010/Images/goals.png)

Leaderboard

![leaderboard](https://github.com/Asgar-Fataymamode/molab-2024-09-Asgar/blob/main/Week%2010/Images/leaderboard.png)

List of skills we can learn

![skills](https://github.com/Asgar-Fataymamode/molab-2024-09-Asgar/blob/main/Week%2010/Images/SkillsList.png)


Example of one skill

![skill]([https://github.com/Asgar-Fataymamode/molab-2024-09-Asgar/blob/main/Week%2010/Images/SkillsList.png](https://github.com/Asgar-Fataymamode/molab-2024-09-Asgar/blob/main/Week%2010/Images/SkillEx.png))

Profile

![profile](https://github.com/Asgar-Fataymamode/molab-2024-09-Asgar/blob/main/Week%2010/Images/profile.png)
