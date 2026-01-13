
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