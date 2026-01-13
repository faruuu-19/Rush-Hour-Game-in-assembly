# Taxi Game – Assembly Language Project

## Table of Contents
1. Project Overview  
2. Technical Architecture  
3. Game Features and Mechanics  
4. User Interface Design  
5. Implementation Details  
6. Game Manual  
7. Conclusion  

---

## 1. Project Overview

### 1.1 Introduction
This project is a **Taxi Simulation Game** developed in **x86 Assembly Language** using the **Irvine32 library**. The player controls a taxi on a grid-based map, picks up passengers, avoids obstacles, and delivers them to destinations while maximizing score.

**Key Focus**
- Strategic navigation  
- Score maximization  
- Real-time collision handling  
- Multiple game modes and difficulty levels  

### 1.2 Project Objectives
- Demonstrate proficiency in x86 assembly programming  
- Implement complex game logic with AI-controlled vehicles  
- Design an engaging user experience using ASCII graphics  
- Implement save and load functionality  
- Integrate sound effects and background music  

### 1.3 Development Environment
- **Language:** x86 Assembly (MASM)  
- **Library:** Irvine32.inc  
- **Audio:** winmm.lib  
- **Platform:** Windows  
- **Grid Size:** 20 × 20 cells  
- **Graphics:** ASCII art with colors  

---

## 2. Technical Architecture

### 2.1 Memory Organization

**Main Data Storage**
- Grid array: 400 bytes (20 × 20)  
- Player data: position, color, score, timers  
- Passenger data: up to 5 passengers  
- NPC cars: up to 5 AI vehicles  
- Game state: mode, difficulty, level, lives, timers  

### 2.2 Core Data Structures

**Grid Symbols**
- `.` Empty space  
- `C` Player taxi  
- `P` Passenger  
- `D` Destination  
- `H` House obstacle  
- `T` Tree obstacle  
- `X` Hurdle obstacle  
- `R` Rock obstacle  
- `O` NPC car  
- `$` Coin  

### 2.3 Key Algorithms

**Pathfinding (BFS)**
- Ensures passengers can reach destinations  
- Guarantees generated levels are solvable  
- Validates all placements  

**Collision Detection**
- Real-time detection for all movements  
- Damage varies by taxi color  
- Handles static and moving obstacles  

**AI Movement**
- NPC cars move in straight paths  
- Reverse direction when blocked  
- Automatic obstacle avoidance  

**Level Generation**
- Random house blocks (3–6 cells)  
- Passengers placed at least 5 cells apart  
- BFS verification for reachability  

---

## 3. Game Features and Mechanics

### 3.1 Game Modes

**Standard Mode**
- Classic gameplay  
- High-score focused  
- Player-selected difficulty  

**Career Mode**
- 10 progressive levels  
- Level 1 target: 50 points  
- Each level increases target by 50 points  
- Increasing difficulty per level  

**Time Attack Mode**
- Time-limited gameplay  
- Options: 30s / 60s / 120s  
- Score as much as possible  

**Endless Mode**
- Start with 3 lives  
- Each collision removes 1 life  
- Game ends at 0 lives  

### 3.2 Taxi Color System

**Red Taxi**
- Slower speed (500 ms per move)  
- Takes 50% less damage  
- Best for defensive play  

**Yellow Taxi**
- Faster speed (100 ms per move)  
- Normal damage  
- Best for aggressive play  

### 3.3 Difficulty Levels

**Easy**
- Coins: 8–10  
- Passengers: 2–5  
- Few obstacles  
- NPC speed: slow (1500 ms)  

**Standard**
- Coins: 5–7  
- Passengers: 2–5  
- Medium obstacles  
- NPC speed: medium (1000 ms)  

**Hard**
- Coins: 3–5  
- Passengers: 3–4  
- Many obstacles  
- NPC speed: fast (700 ms)  

### 3.4 Scoring System

**Earn Points**
- Drop off passenger: +10  
- Collect coin: +10  

**Lose Points**
- Hit passenger: -5  
- Hit hurdle/tree: -4 (yellow) / -2 (red)  
- Hit house: -3  
- Hit NPC car: -2 (yellow) / -3 (red)  
- Hit rock: -2  

### 3.5 Dynamic Difficulty
- Every 2 passenger drop-offs increase NPC speed  
- Speed increases by 100 ms  
- Minimum NPC speed: 300 ms  

---

## 4. User Interface Design

### 4.1 Game Board Display
- Grid-based display with 9 × 9 characters per cell  
- Colored ASCII representations for all entities  

### 4.2 HUD Elements
- Score display  
- Passenger status  
- Mode-specific indicators (level, time, lives)  

### 4.3 Pause Screen
=== GAME PAUSED ===
Press 'P' to resume
Press 'C' to save and exit
### 4.4 Leaderboard
- Displays top 10 scores  
- Persistent across sessions  

---

## 5. Implementation Details

### 5.1 Sound System
- Uses Windows `PlaySoundA` API  
- Includes effects for actions, collisions, and background music  

### 5.2 Save System
- File: `username_save.txt`  
- Stores complete game state  
- One save per user  
- Loadable from main menu  

### 5.3 Leaderboard System
- File: `highscores.txt`  
- Stores top 10 scores  
- Automatically sorted  
- Highest score per user retained  

### 5.4 Key Procedures
- `draw_fullgrid`: renders entire grid  
- `draw_cell`: updates single cell  
- `move_other_cars`: NPC AI movement  
- `check_adj_psngr`: passenger pickup detection  
- `IsReachable`: BFS solvability check  
- `check_career_progress`: level progression  

### 5.5 Input Controls
- Arrow keys: movement  
- Space: pickup / drop-off  
- P: pause  
- C: save and exit  
- X: exit without saving  

---

## 6. Game Manual

### 6.1 Getting Started
1. Enter username (max 20 characters)  
2. View instructions  
3. Start a new game  

### 6.2 Controls Reference

| Key | Action |
|---|---|
| ↑ | Move up |
| ↓ | Move down |
| ← | Move left |
| → | Move right |
| Space | Pickup / Drop-off |
| P | Pause |
| C | Save & Exit |
| X | Exit |

### 6.3 How to Play
1. Locate a passenger  
2. Move adjacent and press Space  
3. Deliver to green destination  
4. Collect coins and avoid obstacles  

### 6.4 Strategy Tips
- Plan routes ahead  
- Red taxi for obstacles  
- Yellow taxi for speed  
- Observe NPC movement patterns  

### 6.5 Save and Load
- Manual save only  
- New saves overwrite old ones  
- Load from main menu  

---

## 7. Conclusion

### 7.1 Achievements
- Fully featured game in x86 assembly  
- AI-controlled NPC vehicles  
- ASCII graphics system  
- Save/load and leaderboard functionality  
- Multiple game modes  

### 7.2 Challenges Solved
- Memory management in assembly  
- BFS pathfinding  
- Collision detection  
- File I/O handling  
- Real-time timing systems  

### 7.3 Skills Gained
- Advanced x86 assembly programming  
- Low-level game development  
- Algorithm implementation  
- Windows API integration  
- Debugging complex systems  

### 7.4 Future Enhancements
- Improved AI using A*  
- Animation system  
- Additional challenges and modes  

### 7.5 Demo Video
C__Users_v o s t r o_source_repos_Project7_Debug_Project7.exe 2025-12-03 20-47-57.mp4
