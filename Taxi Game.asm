include irvine32.inc
includelib winmm.lib  
.data
rows equ 20
cols equ 20
cells equ rows * cols
cellWidth equ 8
cellHeight equ 3
max_other_cars equ 5
black equ 0
blue equ 1
green equ 2
cyan equ 3
red equ 4
magenta equ 5
brown equ 6
lightGray equ 7
darkGray equ 8
lightBlue equ 9
lightGreen equ 10
lightCyan equ 11
lightRed equ 12                      
lightMagenta equ 13
yellow equ 14
white equ 15
dirup equ 0
dirdown equ 1
dirleft equ 2
dirright equ 3
.data
menuTop byte "         *********************************************", 0
menuBot byte "         *********************************************", 0
menuSide byte "         **                                         **", 0
menuDiv byte "         **-----------------------------------------**", 0

taxiArt1 byte "        _____________        ", 0
taxiArt2 byte "       /|           |\       ", 0
taxiArt3 byte " ____ /_|   TAXI    |_\_____  ", 0

taxiArt4 byte "|____|__|___________|__|____| ", 0
taxiArt5 byte "  O O                  O O  ", 0
taxiArt6 byte "                              ", 0
gameTitle1 byte "  _____  _    _  _   ___    ___    _    __  __ ___  ", 0
gameTitle2 byte " |_   _|/_\  \ \/ / |_ _|  / __|  /_\  |  \/  | __| ", 0


gameTitle3 byte "   | | / _ \   ><    | |  | (_ | / _ \ | |\/| | _|      ", 0

gameTitle4 byte "   |_|/_/ \_\/_/\_\ |___|  \___|/_/ \_\|_|  |_|___|         ", 0
playerRow   dd 0
playerCol   dd 0
oldRow      dd 0
oldCol      dd 0

grid byte cells dup('.')
playerColor dd 0
housesToPlace dd 0

max_psngr equ 5
passengerRows dd max_psngr dup(0)
passengerCols dd max_psngr dup(0)
passengerDestRows dd max_psngr dup(0)
passengerDestCols dd max_psngr dup(0)
passengerCount dd 0
passengerInTaxi dd -1
playerScore sdword 0

otherCarCount dd 0
otherCarRows dd max_other_cars dup(0)
otherCarCols dd max_other_cars dup(0)
otherCarDirs dd max_other_cars dup(0)
otherCarStartRows dd max_other_cars dup(0)
otherCarStartCols dd max_other_cars dup(0)

otherCarEndRows dd max_other_cars dup(0)
otherCarEndCols dd max_other_cars dup(0)
otherCarColors dd max_other_cars dup(0)
invalidChoice byte "Invalid choice Try again.", 0 

availableColors dd blue, green, cyan, magenta, lightBlue, lightGreen, lightCyan, lightMagenta, white
numAvailableColors equ 9

tree1 byte "   ^    ",0
tree2 byte "  /|\   ",0
tree3 byte "   |    ",0

house1 byte "   /\   ",0
house2 byte "  /__\  ",0
house3 byte "  |__|  ",0

person1 byte "   o    ",0
person2 byte "  /|\   ",0
person3 byte "  / \   ",0

rock1 byte "   __   ",0
rock2 byte "  (  )  ",0
rock3 byte "   --   ",0
car1 byte "  ____  ",0
car2 byte " /_||_\ ",0
car3 byte "  o  o  ",0
hurdle1 byte "   []   ",0
hurdle2 byte "   []   ",0
hurdle3 byte "   []   ",0

destination1 byte "        ",0
destination2 byte "        ",0
destination3 byte "        ",0
coin1 byte "   __   ",0
coin2 byte "  |$$|  ",0
coin3 byte "   --   ",0
emptyLine byte "        ",0
dashesStr byte "--------",0
plusStr byte "+",0
barStr byte "|",0

scoreMsg byte "Score: ",0
passengerMsg byte " | Passenger in taxi: ",0
yesMsg byte "YES",0
noMsg byte " NO",0

inputChar byte ?
moveCounter dd 0
lastMoveTime dd 0
sent byte "enter any character to start",0

max_un_len equ 20
username byte max_un_len dup(0)
usernameLen dd 0
saveFilename byte "gamedata.txt", 0
userSaveFile byte 50 dup(0)
max_hs equ 10
highscoreNames byte max_hs * max_un_len dup(0)
highscoreValues SDWORD max_hs dup(0)
highscoreCount dd 0
highscoreFilename byte "highscores.txt", 0

fileHandle HANDLE ?
buffer byte 10000 dup(?)
bytesWritten dd ?
bytesRead dd ?
errorMsg1 byte "error creating save file!",0
errorMsg2 byte "error writing to save file!",0
loadSuccessMsg byte "Game loaded successfully!",0
noSaveMsg byte "No save file found. Starting new game...",0

usernamePrompt byte "Enter your username (max 20 chars): ",0
welcomeMsg byte "Welcome, ",0
exclamation byte "!",0

leaderboardTitle byte "=== LEADERBOARD - TOP 10 ===", 0
noScoresMsg byte "No scores yet. Be the first!", 0
rankMsg byte ". ", 0
scoreLabel byte " - Score: ", 0
newHighscoreMsg byte "NEW HIGH SCORE! Press any key...", 0
pressKeyMsg byte "Press any key to return to menu...", 0
isPaused dd 0          
pauseMsg byte "=== GAME PAUSED ===", 0
resumeMsg byte "Press 'P' to resume", 0
pauseSaveMsg byte "Press 'C' to save and exit", 0

controlsMsg1 byte "Controls: W/A/S/D - Move", 0
controlsMsg2 byte "Space - Pick/Drop Passenger", 0
controlsMsg3 byte "P - Pause Game", 0
controlsMsg4 byte "C - Save and Exit", 0
controlsMsg5 byte "X - Exit without saving", 0

playerMoveDelay dd 0
hhlb dd 0
colorPrompt byte "Choose your taxi color:", 0
coloropt byte "1 Red Taxi (slower, less damage from obstacles)", 0
coloropt2 byte "2 Yellow Taxi (faster, more damage from obstacles)", 0
coloropt3 byte "3 Random (Let fate decide)", 0
colorChoicePrompt byte "Enter your choice (1-3): ", 0
invalidColorMsg byte "Invalid choice! Try again.", 0
diff_easy equ 0
diff_std equ 1
diff_hard equ 2

curr_diff dd diff_std

difficultyPrompt byte "Choose difficulty level:", 0
diffOption1 byte "1. Easy (More coins, fewer obstacles, slower NPCs)", 0
diffOption2 db "2. Standard (Balanced gameplay)", 0
diffOption3 db "3. Hard (Fewer coins, more obstacles, faster NPCs)", 0
diffChoicePrompt db "Enter your choice (1-3): ", 0
invalidDiffMsg db "Invalid choice! Try again.", 0
coinsToPlace dd 6        
minpass dd 2       
maxPassengers dd 5       
hurdlesToPlace dd 4     
treesToPlace dd 2        
other_car2place dd 2    
npcMoveDelay dd 1000     
clickSound     db "sounds\click.wav", 0
pickupSound    db "sounds\pickup.wav", 0
dropSound      db "sounds\drop.wav", 0
crashSound     db "sounds\crash.wav", 0
coinSound      db "sounds\coin.wav", 0
endgameSound   db "sounds\endgame.wav", 0
pauseSound     db "sounds\pause.wav", 0
backgroundMusic db "sounds\background.wav", 0

SND_FILENAME equ 00020000h
SND_ASYNC equ 00000001h
SND_LOOP equ 00000008h
SND_NOSTOP equ 00000010h
SND_SYNC  equ 00000000h
mode_std equ 0
mode_career equ 1
mode_time equ 2
mode_endless equ 3
currentGameMode dd mode_std
gameTimer dd 0              
timeRemaining dd 120        
last_timer_update dd 0        
careerLevel dd 1            
careerTarget dd 50         
levelPassengers dd 0       

modeMenuTitle db " SELECT GAME MODE : ", 0
modeOption1 db "1. Standard Mode - Classic taxi gameplay", 0
modeOption2 db "2. Career Mode - Progress through levels", 0
modeOption3 db "3. Time Mode - Beat the clock (2 minutes)", 0
modeOption4 db "4. Endless Mode - Play until crash", 0
modeOption5 db "5. Back to Main Menu", 0
modePrompt db "Enter your choice (1-5): ", 0
levelMsg db "Level: ", 0
targetMsg db " | Target Score: ", 0
passengersMsg db " | Passengers: ", 0
levelCompleteMsg db "LEVEL COMPLETE! Press any key", 0
gameCompleteMsg db "ALL OBJECTIVES COMPLETE!", 0
careerCompleteMsg db "CONGRATULATIONS! You completed Career Mode!", 0

timeMsg db "Time: ", 0
secondsMsg db "s", 0
timeUpMsg db "TIME'S UP! Final Score: ", 0

endlessMsg db "Endless Mode - Lives: ", 0
livesRemaining dd 3
gameOverMsg db "GAME OVER! Final Score: ", 0
timeDifficultyPrompt db "Choose time limit:", 0
timeDiffOption1 db "1. Easy (2 minutes)", 0
timeDiffOption2 db "2. Medium (1 minute)", 0
timeDiffOption3 db "3. Hard (30 seconds)", 0
levelCompleteTitle db "=== LEVEL COMPLETE! ===", 0
levelCompleteScore db "Level Score: ", 0
nextLevelMsg db "Next Level Target: ", 0
levelChoicePrompt db "1. Continue to Next Level", 0
levelChoicePrompt2 db "2. Return to Main Menu", 0
levelChoiceInput db "Enter your choice (1-2): ", 0
invalidLevelChoice db "Invalid choice! Try again.", 0

timeDisplayRow db 105
timeDisplayCol db 0   

menuTitle db  " TAXI GAME ",0
menuOption1 db "1. Start New Game",0
menuOption2 db "2. Continue Saved Game",0
menuOption3 db "3. View Leaderboard",0
menuOption4 db "4. Instructions",0        
menuOption5 db "5. Exit",0                 
menuPrompt db "Enter your choice(1-5): ",0  

instructionsTitle db "INSTRUCTIONS", 0
instructions1 db "OBJECTIVE:", 0
instructions2 db "Pick up passengers (cyan people) and drop them at green destinations.", 0
instructions3 db "Collect coins ($) for bonus points. Avoid obstacles!", 0
instructions4 db " ", 0
instructions5 db "CONTROLS:", 0
instructions6 db "LEFT/RIGHT/UP/KEY - Move your taxi", 0
instructions7 db "SPACE   - Pick up/Drop off passenger", 0
instructions8 db "P - Pause game", 0
instructions9 db "C    - Save and exit to menu", 0
instructions10 db "X  - exit without saving", 0
instructions11 db " ", 0
instructions12 db "TAXI COLORS:", 0
instructions13 db "RED- slower, takes less damage from obstacles", 0
instructions14 db "YELLOW - faster, takes more damage from obstacles", 0
instructions15 db " ", 0
instructions16 db "SCORING:", 0
instructions17 db "+10 points - Drop off passenger", 0
instructions18 byte "+10 points - Collect coin", 0
instructions19 byte "-2 to -5   - Hit obstacles (depends on obstacle type)", 0
instructions20 byte " ", 0
instructions21 byte "press any key to return to menu", 0
psngr_dropped dd 0

.code

PlaySoundA PROTO,
pszSound:PTR byte ,
hmod:DWORD,
fdwSound:DWORD

play_click_sound proc
push eax
push ebx
push ecx

push SND_FILENAME OR SND_ASYNC OR SND_NOSTOP 
push 0                                         
push OFFSET clickSound                         

;    call PlaySoundA

pop ecx
pop ebx
pop eax
ret
play_click_sound endp

play_pickup_sound proc
push eax
push ebx
push ecx

push SND_FILENAME OR SND_ASYNC OR SND_NOSTOP
push 0
push OFFSET pickupSound
;    call PlaySoundA

pop ecx
pop ebx
pop eax
ret
play_pickup_sound endp


play_dropsoound proc
push eax
push ebx
push ecx

push SND_FILENAME OR SND_ASYNC OR SND_NOSTOP
push 0
push OFFSET dropSound
;    call PlaySoundA

pop ecx
pop ebx
pop eax
ret
play_dropsoound endp

play_crashsound proc
push eax
push ebx
push ecx

;INVOKE PlaySoundA, OFFSET crashSound, 0, SND_FILENAME OR SND_ASYNC

pop ecx
pop ebx
pop eax
ret
play_crashsound endp
play_sound_coin proc
push eax
push ebx
push ecx

;INVOKE PlaySoundA, OFFSET coinSound, 0, SND_FILENAME OR SND_ASYNC

pop ecx
pop ebx
pop eax
ret
play_sound_coin endp
endgame_Sound proc
push eax
push ebx
push ecx

; INVOKE PlaySoundA, OFFSET endgameSound, 0, SND_FILENAME OR SND_SYNC

pop ecx
pop ebx
pop eax
ret
endgame_Sound endp
play_pause_sound proc
push eax
push ebx
push ecx

;    INVOKE PlaySoundA, OFFSET pauseSound, 0, SND_FILENAME OR SND_ASYNC

pop ecx
pop ebx
pop eax
ret
play_pause_sound endp
play_bg_music proc
push eax
push ebx
push ecx

;    INVOKE PlaySoundA, OFFSET backgroundMusic, 0, SND_FILENAME OR SND_ASYNC OR SND_LOOP

pop ecx
pop ebx
pop eax
ret
play_bg_music endp

stop_sounds proc
push eax
push ebx
push ecx

;    INVOKE PlaySoundA, 0, 0, 0

pop ecx
pop ebx
pop eax
ret
stop_sounds endp

get_un proc
push eax
push ecx
push edx
push esi

call Clrscr
mov dh, 10
mov dl, 25
call Gotoxy

mov edx, OFFSET usernamePrompt
call WriteString

mov edx, OFFSET username
mov ecx, max_un_len - 1
call ReadString
mov usernameLen, eax
mov esi, eax
mov byte ptr username[esi], 0

pop esi
pop edx
pop ecx
pop eax
ret
get_un endp

BuildUserFilename proc
push eax
push ecx
push esi
push edi

mov edi, OFFSET userSaveFile
mov ecx, 50
xor al, al
rep stosb
mov esi, OFFSET username
mov edi, OFFSET userSaveFile
CopyUsernameLoop:
mov al, byte ptr [esi]
cmp al, 0
je CopyUsernameDone
mov byte ptr [edi], al
inc esi
inc edi
jmp CopyUsernameLoop

CopyUsernameDone:
mov byte ptr [edi], '_'
inc edi
mov byte ptr [edi], 's'
inc edi
mov byte ptr [edi], 'a'
inc edi
mov byte ptr [edi], 'v'
inc edi
mov byte ptr [edi], 'e'
inc edi
mov byte ptr [edi], '.'
inc edi
mov byte ptr [edi], 't'
inc edi
mov byte ptr [edi], 'x'
inc edi
mov byte ptr [edi], 't'
inc edi
mov byte ptr [edi], 0

pop edi
pop esi
pop ecx
pop eax
ret
BuildUserFilename endp

Initialize_hs proc
push eax
push ecx
push edi
mov dword ptr [highscoreCount], 0
mov edi, OFFSET highscoreValues
mov ecx, max_hs
xor eax, eax
ClearScoresLoop:
mov dword ptr [edi], 0
add edi, 4
loop ClearScoresLoop

mov edi, OFFSET highscoreNames
mov ecx, max_hs * max_un_len
xor al, al
rep stosb

pop edi
pop ecx
pop eax
ret
Initialize_hs endp
load_hs proc
push eax
push ebx
push ecx
push edx
push esi
push edi
call Initialize_hs
mov edx, OFFSET highscoreFilename
call OpenInputFile
mov fileHandle, eax
cmp eax, INVALID_HANDLE_VALUE
je LoadHighDone  

mov eax, fileHandle
mov edx, OFFSET buffer
mov ecx, 10000
call ReadFromFile
jc LoadHighError

mov eax, fileHandle
call CloseFile
mov esi, OFFSET buffer
xor edi, edi

LoadHighLoop:
cmp edi, max_hs
jge LoadHighDone
SkipLeadingWhitespace:
mov al, byte ptr [esi]
cmp al, 0
je LoadHighDone
cmp al, 0Ah
jne CheckSpace
inc esi
jmp SkipLeadingWhitespace
CheckSpace:
cmp al, ' '
jne StartReadingName
inc esi
jmp SkipLeadingWhitespace

StartReadingName:
mov eax, edi
mov edx, max_un_len
mul edx
push edi
mov edi, eax
add edi, OFFSET highscoreNames
ReadNameLoop:
mov al, byte ptr [esi]
inc esi
cmp al, 0Ah
je ReadNameDone
cmp al, 0
je ReadNameDone
cmp al, ' '
je ReadNameDone
mov byte ptr [edi], al
inc edi
jmp ReadNameLoop

ReadNameDone:
mov byte ptr [edi], 0
pop edi

SkipSpacesLoop:
cmp byte ptr [esi], ' '
jne SkipSpacesDone
inc esi
jmp SkipSpacesLoop

SkipSpacesDone:

call parse_snum
mov ebx, edi
shl ebx, 2
mov highscoreValues[ebx], eax

mov al, byte ptr [esi]
cmp al, 0Ah
jne CheckEnd
inc esi     

CheckEnd:
inc edi
inc dword ptr [highscoreCount]
jmp LoadHighLoop

LoadHighError:
mov eax, fileHandle
call CloseFile

LoadHighDone:
pop edi
pop esi
pop edx
pop ecx
pop ebx
pop eax
ret
load_hs endp

save_hs proc
push eax
push ebx
push ecx
push edx
push esi
push edi
mov edx, OFFSET highscoreFilename
call CreateOutputFile
mov fileHandle, eax
cmp eax, INVALID_HANDLE_VALUE
je SaveHighDone
mov edi, OFFSET buffer
xor esi, esi

SaveHighLoop:
cmp esi, dword ptr [highscoreCount]
jge SaveHighWrite

mov eax, esi
mov edx, max_un_len
mul edx
mov ebx, eax
add ebx, OFFSET highscoreNames

WriteUserLoop:
mov al, byte ptr [ebx]
cmp al, 0
je UserWriteDone
mov byte ptr [edi], al
inc ebx
inc edi
jmp WriteUserLoop

UserWriteDone:
mov byte ptr [edi], ' '
inc edi
mov eax, esi
shl eax, 2
mov eax, highscoreValues[eax]
call signed_to_str
mov byte ptr [edi], 0Ah
inc edi

inc esi
jmp SaveHighLoop

SaveHighWrite:
mov eax, edi
sub eax, OFFSET buffer
mov ecx, eax

mov eax, fileHandle
mov edx, OFFSET buffer
call WriteToFile
mov eax, fileHandle
call CloseFile

SaveHighDone:
pop edi
pop esi
pop edx
pop ecx
pop ebx
pop eax
ret
save_hs endp
check_update_hs proc
push eax
push ebx
push ecx
push edx
push esi
push edi

mov eax, dword ptr [playerScore]
cmp dword ptr [highscoreCount], max_hs
jl AlwaysInsert
mov ebx, max_hs - 1
shl ebx, 2
cmp eax, highscoreValues[ebx]
jle CheckHighDone  

AlwaysInsert:
xor esi, esi

FindPosLoop:
cmp esi, dword ptr [highscoreCount]
jge InsertAt

mov ebx, esi
shl ebx, 2
cmp eax, highscoreValues[ebx]
jg InsertAt

inc esi
jmp FindPosLoop

InsertAt:
mov ecx, dword ptr [highscoreCount]

cmp ecx, max_hs
jl NotAtMax

mov ecx, max_hs - 1
jmp StartShift

NotAtMax:
dec ecx

StartShift:


cmp ecx, esi
jl NoShift 

ShiftLoop:

cmp ecx, esi
jl NoShift

cmp ecx, max_hs - 1
jge SkipThisShift 

mov ebx, ecx
shl ebx, 2
mov eax, highscoreValues[ebx]
mov highscoreValues[ebx + 4], eax

push esi
push edi
push ecx

mov eax, ecx
mov edx, max_un_len
mul edx
mov esi, eax
add esi, OFFSET highscoreNames

mov edi, esi
add edi, max_un_len

push ecx
mov ecx, max_un_len
rep movsb
pop ecx

pop ecx
pop edi
pop esi

SkipThisShift:
dec ecx
jmp ShiftLoop

NoShift:
mov eax, dword ptr [playerScore]
mov ebx, esi
shl ebx, 2
mov highscoreValues[ebx], eax

push esi
mov eax, esi
mov edx, max_un_len
mul edx
mov edi, eax
add edi, OFFSET highscoreNames

mov esi, OFFSET username
mov ecx, max_un_len
rep movsb
pop esi

cmp dword ptr [highscoreCount], max_hs
jge CountAtMax
inc dword ptr [highscoreCount]

CountAtMax:
call save_hs
call Clrscr
mov dh, 10
mov dl, 20
call Gotoxy
mov eax, yellow
call SetTextColor
mov edx, OFFSET newHighscoreMsg
call WriteString
call ReadChar

CheckHighDone:
pop edi
pop esi
pop edx
pop ecx
pop ebx
pop eax
ret
check_update_hs endp

disp_leaderboard proc
push eax
push ebx
push ecx
push edx
push esi
push edi

call Clrscr
mov dh, 5
mov dl, 20
call Gotoxy

mov eax, yellow
call SetTextColor
mov edx, OFFSET leaderboardTitle
call WriteString
call Crlf
call Crlf

cmp dword ptr [highscoreCount], 0
jne ShowScores
mov dh, 8
mov dl, 20
call Gotoxy
mov eax, lightGray
call SetTextColor
mov edx, OFFSET noScoresMsg
call WriteString
jmp LeaderDone

ShowScores:
mov esi, 0
mov dh, 8

ShowScoreLoop:
cmp esi, dword ptr [highscoreCount]
jge LeaderDone

cmp esi, max_hs
jge LeaderDone

mov dl, 20
call Gotoxy
mov eax, lightCyan
call SetTextColor
mov eax, esi
inc eax
call WriteDec
mov edx, OFFSET rankMsg
call WriteString

mov eax, white
call SetTextColor
mov eax, esi
mov edx, max_un_len
mul edx
mov ebx, eax
add ebx, OFFSET highscoreNames
mov edx, ebx
call WriteString
mov eax, lightGray
call SetTextColor
mov edx, OFFSET scoreLabel
call WriteString
mov eax, lightGreen
call SetTextColor
mov eax, esi
shl eax, 2
mov eax, highscoreValues[eax]
call WriteInt

call Crlf
inc dh
inc esi
jmp ShowScoreLoop

LeaderDone:
call Crlf
call Crlf
mov dh, 20
mov dl, 20
call Gotoxy
mov eax, white
call SetTextColor
mov edx, OFFSET pressKeyMsg
call WriteString
call ReadChar

pop edi
pop esi
pop edx
pop ecx
pop ebx
pop eax
ret
disp_leaderboard endp
signed_to_str proc
push eax
push ebx
push ecx
push edx

cmp eax, 0
jge PositiveNum

mov byte ptr [edi], '-'
inc edi
neg eax

PositiveNum:
mov ebx, 10
mov ecx, 0

ConvertSignedLoop:
xor edx, edx
div ebx
add dl, '0'
push edx
inc ecx
cmp eax, 0
jne ConvertSignedLoop

WriteSignedDigits:
pop eax
mov byte ptr [edi], al
inc edi
loop WriteSignedDigits

pop edx
pop ecx
pop ebx
pop eax
ret
signed_to_str endp

get_rand_idx proc
push ebx
push edx
mov ebx, ecx
call Random32
xor edx, edx
div ebx
mov eax, edx
pop edx
pop ebx
ret
get_rand_idx endp
get_other_car_Color proc
push ebx
push ecx
push edx
push esi

mov eax, ebx
push edx
mov edx, cols
mul edx
pop edx
add eax, edi
xor esi, esi
SearchCarLoop:
cmp esi, dword ptr [otherCarCount]
jge UseDefaultColor

mov ecx, esi
shl ecx, 2

mov edx, otherCarRows[ecx]
cmp edx, ebx
jne NextCar

mov edx, otherCarCols[ecx]
cmp edx, edi
jne NextCar
mov eax, otherCarColors[ecx]
jmp ColorFound

NextCar:
inc esi
jmp SearchCarLoop

UseDefaultColor:
mov eax, lightBlue

ColorFound:
pop esi
pop edx
pop ecx
pop ebx
ret
get_other_car_Color endp
draw_cell proc
push eax
push ebx
push ecx
push edx
push esi
push edi
mov eax, ebx
push edx
mov edx, cols
mul edx
pop edx
add eax, edi
movzx eax, byte ptr grid[eax]
mov ecx, ebx
push eax
push edx
mov eax, ecx
mov edx, cellHeight + 1
mul edx
mov ecx, eax
pop edx
pop eax
inc ecx

push eax
push ecx
mov eax, edi
push edx
mov edx, cellWidth + 1
mul edx
mov edx, eax
pop eax
mov eax, edx
pop ecx
mov edx, eax
pop eax
inc edx
mov esi, 1
DrawCellLines:
push eax
push ecx
push edx
mov dh, cl
mov dl, byte ptr [esp]
call Gotoxy

pop edx
pop ecx
pop eax

cmp al, '.'
je DrawEmpty

cmp esi, 1
je ObjLine1
cmp esi, 2
je ObjLine2
cmp esi, 3
je ObjLine3
jmp DrawEmpty

ObjLine1:
cmp al, 'T'
je T1
cmp al, 'H'
je H1
cmp al, 'P'
je P1
cmp al, 'R'
je R1
cmp al, 'C'
je C1
cmp al, 'O'
je O1
cmp al, 'X'
je X1
cmp al, 'D'
je D1
cmp al, '$'
je COIN1_CELL
jmp DrawEmpty

T1:
push edx
mov edx, OFFSET tree1
push eax
mov eax, green
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

H1:
push edx
mov edx, OFFSET house1
push eax
mov eax, white
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

P1:
push edx
mov edx, OFFSET person1
push eax
mov eax, lightCyan
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

R1:
push edx
mov edx, OFFSET rock1
push eax
mov eax, darkGray
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

C1:
push edx
mov edx, OFFSET car1
push eax
mov eax, dword ptr [playerColor]
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

O1:
push edx
mov edx, OFFSET car1
push eax
call get_other_car_Color
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

X1:
push edx
mov edx, OFFSET hurdle1
push eax
mov eax, magenta
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

D1:
push edx
mov edx, OFFSET destination1
push eax
mov eax, lightGreen * 16 + black
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

COIN1_CELL:
push edx
mov edx, OFFSET coin1
push eax
mov eax, yellow
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

ObjLine2:
cmp al, 'T'
je T2
cmp al, 'H'
je H2
cmp al, 'P'
je P2
cmp al, 'R'
je R2
cmp al, 'C'
je C2
cmp al, 'O'
je O2
cmp al, 'X'
je X2
cmp al, 'D'
je D2
cmp al, '$'
je COIN2_CELL
jmp DrawEmpty

T2:
push edx
mov edx, OFFSET tree2
push eax
mov eax, green
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

H2:
push edx
mov edx, OFFSET house2
push eax
mov eax, white
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

P2:
push edx
mov edx, OFFSET person2
push eax
mov eax, lightCyan
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

R2:
push edx
mov edx, OFFSET rock2
push eax
mov eax, darkGray
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

C2:
push edx
mov edx, OFFSET car2
push eax
mov eax, dword ptr [playerColor]
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

O2:
push edx
mov edx, OFFSET car2
push eax
call get_other_car_Color
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

X2:
push edx
mov edx, OFFSET hurdle2
push eax
mov eax, magenta
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

D2:
push edx
mov edx, OFFSET destination2
push eax
mov eax, lightGreen * 16 + black
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

COIN2_CELL:
push edx
mov edx, OFFSET coin2
push eax
mov eax, yellow
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

ObjLine3:
cmp al, 'T'
je T3
cmp al, 'H'
je H3
cmp al, 'P'
je P3
cmp al, 'R'
je R3
cmp al, 'C'
je C3
cmp al, 'O'
je O3
cmp al, 'X'
je X3
cmp al, 'D'
je D3
cmp al, '$'
je COIN3_CELL
jmp DrawEmpty

T3:
push edx
mov edx, OFFSET tree3
push eax
mov eax, green
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

H3:
push edx
mov edx, OFFSET house3
push eax
mov eax, white
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

P3:
push edx
mov edx, OFFSET person3
push eax
mov eax, lightCyan
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

R3:
push edx
mov edx, OFFSET rock3
push eax
mov eax, darkGray
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

C3:
push edx
mov edx, OFFSET car3
push eax
mov eax, dword ptr [playerColor]
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

O3:
push edx
mov edx, OFFSET car3
push eax
call get_other_car_Color
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

X3:
push edx
mov edx, OFFSET hurdle3
push eax
mov eax, magenta
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

D3:
push edx
mov edx, OFFSET destination3
push eax
mov eax, lightGreen * 16 + black
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

COIN3_CELL:
push edx
mov edx, OFFSET coin3
push eax
mov eax, yellow
call SetTextColor
call WriteString
pop eax
pop edx
jmp AfterDraw

DrawEmpty:
push edx
mov edx, OFFSET emptyLine
push eax
mov eax, lightGray
call SetTextColor
call WriteString
pop eax
pop edx

AfterDraw:
inc esi
inc ecx
cmp esi, 3
jle DrawCellLines

pop edi
pop esi
pop edx
pop ecx
pop ebx
pop eax
ret
draw_cell endp
update_player proc
push eax
push ebx
push edi

mov eax, dword ptr [oldRow]
push edx
mov edx, cols
mul edx
pop edx
add eax, dword ptr [oldCol]
mov byte ptr grid[eax], '.'

mov ebx, dword ptr [oldRow]
mov edi, dword ptr [oldCol]
call draw_cell

pop edi
pop ebx
pop eax
ret
update_player endp
draw_player proc
push eax
push ebx
push edi

mov eax, dword ptr [playerRow]
push edx
mov edx, cols
mul edx
pop edx
add eax, dword ptr [playerCol]
mov byte ptr grid[eax], 'C'

mov ebx, dword ptr [playerRow]
mov edi, dword ptr [playerCol]
call draw_cell

pop edi
pop ebx
pop eax
ret
draw_player endp
draw_fullgrid proc
push eax
push ebx
push ecx
push edx
push esi
push edi

call Clrscr
mov dh, 0
mov dl, 0
call Gotoxy

mov eax, blue
call SetTextColor

xor ebx, ebx
RowLoop:
cmp ebx, ROWS
jae DrawFinalBottom
mov ecx, cols
TopBorderCols:
mov edx, OFFSET plusStr
call WriteString
mov edx, OFFSET dashesStr
call WriteString
loop TopBorderCols
mov edx, OFFSET plusStr
call WriteString
call Crlf
mov esi, 1
InteriorLinesLoop:
mov edi, 0
ColLoop:
mov eax, blue
call SetTextColor
mov edx, OFFSET barStr
call WriteString

mov eax, ebx
push edx
mov edx, cols
mul edx
pop edx
add eax, edi
mov al, grid[eax]

cmp al, '.'
je PrintEmptyLine

cmp esi, 1
je ObjLine1_Grid
cmp esi, 2
je ObjLine2_Grid
cmp esi, 3
je ObjLine3_Grid
jmp PrintEmptyLine

ObjLine1_Grid:
cmp al, 'T'
je T1_Grid
cmp al, 'H'
je H1_Grid
cmp al, 'P'
je P1_Grid
cmp al, 'R'
je R1_Grid
cmp al, 'C'
je C1_Grid
cmp al, 'O'
je O1_Grid
cmp al, 'X'
je X1_Grid
cmp al, 'D'
je DD1
cmp al, '$'
je COIN1_GRID
jmp PrintEmptyLine

T1_Grid:
mov edx, OFFSET tree1
mov eax, green
call SetTextColor
call WriteString
jmp AfterPrint

H1_Grid:
mov edx, OFFSET house1
mov eax, white
call SetTextColor
call WriteString
jmp AfterPrint

P1_Grid:
mov edx, OFFSET person1
mov eax, lightCyan
call SetTextColor
call WriteString
jmp AfterPrint

R1_Grid:
mov edx, OFFSET rock1
mov eax, darkGray
call SetTextColor
call WriteString
jmp AfterPrint

C1_Grid:
mov edx, OFFSET car1
mov eax, dword ptr [playerColor]
call SetTextColor
call WriteString
jmp AfterPrint

O1_Grid:
mov edx, OFFSET car1
push eax
call get_other_car_Color
call SetTextColor
call WriteString
pop eax
jmp AfterPrint

X1_Grid:
mov edx, OFFSET hurdle1
mov eax, magenta
call SetTextColor
call WriteString
jmp AfterPrint

DD1:
mov edx, OFFSET destination1
mov eax, lightGreen * 16 + black
call SetTextColor
call WriteString
jmp AfterPrint

COIN1_GRID:
mov edx, OFFSET coin1
mov eax, yellow
call SetTextColor
call WriteString
jmp AfterPrint

ObjLine2_Grid:
cmp al, 'T'
je T2_Grid
cmp al, 'H'
je H2_Grid
cmp al, 'P'
je P2_Grid
cmp al, 'R'
je R2_Grid
cmp al, 'C'
je C2_Grid
cmp al, 'O'
je O2_Grid
cmp al, 'X'
je X2_Grid
cmp al, 'D'
je DD2
cmp al, '$'
je COIN2_GRID
jmp PrintEmptyLine

T2_Grid:
mov edx, OFFSET tree2
mov eax, green
call SetTextColor
call WriteString
jmp AfterPrint

H2_Grid:
mov edx, OFFSET house2
mov eax, white
call SetTextColor
call WriteString
jmp AfterPrint

P2_Grid:
mov edx, OFFSET person2
mov eax, lightCyan
call SetTextColor
call WriteString
jmp AfterPrint

R2_Grid:
mov edx, OFFSET rock2
mov eax, darkGray
call SetTextColor
call WriteString
jmp AfterPrint

C2_Grid:
mov edx, OFFSET car2
mov eax, dword ptr [playerColor]
call SetTextColor
call WriteString
jmp AfterPrint

O2_Grid:
mov edx, OFFSET car2
push eax
call get_other_car_Color
call SetTextColor
call WriteString
pop eax
jmp AfterPrint

X2_Grid:
mov edx, OFFSET hurdle2
mov eax, magenta
call SetTextColor
call WriteString
jmp AfterPrint

DD2:
mov edx, OFFSET destination2
mov eax, lightGreen * 16 + black
call SetTextColor
call WriteString
jmp AfterPrint

COIN2_GRID:
mov edx, OFFSET coin2
mov eax, yellow
call SetTextColor
call WriteString
jmp AfterPrint

ObjLine3_Grid:
cmp al, 'T'
je T3_Grid
cmp al, 'H'
je H3_Grid
cmp al, 'P'
je P3_Grid
cmp al, 'R'
je R3_Grid
cmp al, 'C'
je C3_Grid
cmp al, 'O'
je O3_Grid
cmp al, 'X'
je X3_Grid
cmp al, 'D'
je DD3
cmp al, '$'
je COIN3_GRID
jmp PrintEmptyLine

T3_Grid:
mov edx, OFFSET tree3
mov eax, green
call SetTextColor
call WriteString
jmp AfterPrint

H3_Grid:
mov edx, OFFSET house3
mov eax, white
call SetTextColor
call WriteString
jmp AfterPrint

P3_Grid:
mov edx, OFFSET person3
mov eax, lightCyan
call SetTextColor
call WriteString
jmp AfterPrint

R3_Grid:
mov edx, OFFSET rock3
mov eax, darkGray
call SetTextColor
call WriteString
jmp AfterPrint

C3_Grid:
mov edx, OFFSET car3
mov eax, dword ptr [playerColor]
call SetTextColor
call WriteString
jmp AfterPrint

O3_Grid:
mov edx, OFFSET car3
push eax
call get_other_car_Color
call SetTextColor
call WriteString
pop eax
jmp AfterPrint

X3_Grid:
mov edx, OFFSET hurdle3
mov eax, magenta
call SetTextColor
call WriteString
jmp AfterPrint

DD3:
mov edx, OFFSET destination3
mov eax, lightGreen * 16 + black
call SetTextColor
call WriteString
jmp AfterPrint

COIN3_GRID:
mov edx, OFFSET coin3
mov eax, yellow
call SetTextColor
call WriteString
jmp AfterPrint

AfterPrint:
jmp ColContinue

PrintEmptyLine:
mov edx, OFFSET emptyLine
mov eax, lightGray
call SetTextColor
call WriteString

ColContinue:
inc edi
cmp edi, cols
jl ColLoop

mov eax, blue
call SetTextColor
mov edx, OFFSET barStr
call WriteString
call Crlf

inc esi
cmp esi, cellHeight
jle InteriorLinesLoop

inc ebx
jmp RowLoop

DrawFinalBottom:
mov ecx, cols
FinalBottomLoop:
mov edx, OFFSET plusStr
call WriteString
mov edx, OFFSET dashesStr
call WriteString
loop FinalBottomLoop
mov edx, OFFSET plusStr
call WriteString
call Crlf

pop edi
pop esi
pop edx
pop ecx
pop ebx
pop eax
ret
draw_fullgrid endp
disp_Score proc
push eax
push edx
push ebx
push ecx

mov dh, 105
mov dl, 0
call Gotoxy

mov dh, 85
mov dl, 0
call Gotoxy

mov eax, white
call SetTextColor
mov edx, OFFSET scoreMsg
call WriteString
mov eax, dword ptr [playerScore]
call WriteInt

mov edx, OFFSET passengerMsg
call WriteString

mov eax, dword ptr [passengerInTaxi]
cmp eax, -1
je NoPassenger

mov eax, lightGreen
call SetTextColor
mov edx, OFFSET yesMsg
call WriteString
jmp ScoreDone

NoPassenger:
mov eax, red
call SetTextColor
mov edx, OFFSET noMsg
call WriteString

ScoreDone:
mov eax, white
call SetTextColor

pop ecx
pop ebx
pop edx
pop eax
ret
disp_Score endp
check_adj_psngr proc
push ebx
push ecx
push edx
push esi
push edi

xor esi, esi

CheckPassLoop:
mov ecx, dword ptr [passengerCount]
cmp esi, ecx
jge NoPassengerFound

cmp esi, max_psngr
jge NoPassengerFound

mov ebx, esi
shl ebx, 2
mov ecx, passengerRows[ebx]
mov edx, passengerCols[ebx]
cmp ecx, -1
je NextPass

mov ebx, dword ptr [playerRow]
mov edi, dword ptr [playerCol]
cmp ebx, 0
je CheckPassDown
push eax
mov eax, ebx
dec eax
cmp eax, ecx
pop eax
jne CheckPassDown
cmp edi, edx
je FoundPass

CheckPassDown:
push eax
mov eax, ROWS
dec eax
cmp ebx, eax
pop eax
jge CheckPassLeft
push eax
mov eax, ebx
inc eax
cmp eax, ecx
pop eax
jne CheckPassLeft
cmp edi, edx
je FoundPass

CheckPassLeft:
cmp edi, 0
je CheckPassRight
push eax
mov eax, edi
dec eax
pop eax
cmp ebx, ecx
jne CheckPassRight
push eax
mov eax, edi
dec eax
cmp eax, edx
pop eax
je FoundPass

CheckPassRight:
push eax
mov eax, cols
dec eax
cmp edi, eax
pop eax
jge NextPass
push eax
mov eax, edi
inc eax
pop eax
cmp ebx, ecx
jne NextPass
push eax
mov eax, edi
inc eax
cmp eax, edx
pop eax
je FoundPass

NextPass:
inc esi
jmp CheckPassLoop

FoundPass:
mov eax, esi
jmp CheckPassDone

NoPassengerFound:
mov eax, -1

CheckPassDone:
pop edi
pop esi
pop edx
pop ecx
pop ebx
ret
check_adj_psngr endp
IsReachable proc
push ebx
push ecx
push edx
push esi
push edi
push ebp

sub esp, cells
mov ebp, esp

push edi
mov edi, ebp
mov ecx, cells
xor al, al
rep stosb
pop edi

push ebx
push edi

mov al, grid[0]
cmp al, '.'
je StartOK
cmp al, 'C'
je StartOK
cmp al, 'P'
je StartOK
cmp al, 'D'
je StartOK
cmp al, '$'
je StartOK

pop edi
pop ebx
add esp, cells
xor eax, eax
jmp ReachDone

StartOK:
sub esp, 800

mov dword ptr [esp], 0
mov esi, 0
mov edi, 1
mov byte ptr [ebp], 1

BFSLoop:
cmp esi, edi
jge BFSEnd

cmp edi, 200
jge BFSEnd

mov eax, dword ptr [esp + esi*4]
inc esi

push edx
xor edx, edx
mov ecx, cols
div ecx
mov ebx, eax
mov ecx, edx
pop edx

cmp ebx, 0
je SkipUp
push ebx
push ecx
dec ebx
mov eax, ebx
push edx
mov edx, cols
mul edx
pop edx
add eax, ecx

cmp byte ptr [ebp + eax], 0
jne PopUp

mov dl, grid[eax]
cmp dl, '.'
je MarkUp
cmp dl, 'C'
je MarkUp
cmp dl, 'P'
je MarkUp
cmp dl, 'D'
je MarkUp
cmp dl, '$'
je MarkUp
jmp PopUp

MarkUp:
mov byte ptr [ebp + eax], 1
cmp edi, 200
jge PopUp
mov dword ptr [esp + 8 + edi*4], eax
inc edi

PopUp:
pop ecx
pop ebx

SkipUp:
cmp ebx, ROWS-1
jge SkipDown
push ebx
push ecx
inc ebx
mov eax, ebx
push edx
mov edx, cols
mul edx
pop edx
add eax, ecx

cmp byte ptr [ebp + eax], 0
jne PopDown

mov dl, grid[eax]
cmp dl, '.'
je MarkDown
cmp dl, 'C'
je MarkDown
cmp dl, 'P'
je MarkDown
cmp dl, 'D'
je MarkDown
cmp dl, '$'
je MarkDown
jmp PopDown

MarkDown:
mov byte ptr [ebp + eax], 1
cmp edi, 200
jge PopDown
mov dword ptr [esp + 8 + edi*4], eax
inc edi

PopDown:
pop ecx
pop ebx

SkipDown:
cmp ecx, 0
je SkipLeft
push ebx
push ecx
dec ecx
mov eax, ebx
push edx
mov edx, cols
mul edx
pop edx
add eax, ecx

cmp byte ptr [ebp + eax], 0
jne PopLeft

mov dl, grid[eax]
cmp dl, '.'
je MarkLeft
cmp dl, 'C'
je MarkLeft
cmp dl, 'P'
je MarkLeft
cmp dl, 'D'
je MarkLeft
cmp dl, '$'
je MarkLeft
jmp PopLeft

MarkLeft:
mov byte ptr [ebp + eax], 1
cmp edi, 200
jge PopLeft
mov dword ptr [esp + 8 + edi*4], eax
inc edi

PopLeft:
pop ecx
pop ebx

SkipLeft:
cmp ecx, cols -1
jge SkipRight
push ebx
push ecx
inc ecx
mov eax, ebx
push edx
mov edx, cols
mul edx
pop edx
add eax, ecx

cmp byte ptr [ebp + eax], 0
jne PopRight

mov dl, grid[eax]
cmp dl, '.'
je MarkRight
cmp dl, 'C'
je MarkRight
cmp dl, 'P'
je MarkRight
cmp dl, 'D'
je MarkRight
cmp dl, '$'
je MarkRight
jmp PopRight

MarkRight:
mov byte ptr [ebp + eax], 1
cmp edi, 200
jge PopRight
mov dword ptr [esp + 8 + edi*4], eax
inc edi

PopRight:
pop ecx
pop ebx

SkipRight:
jmp BFSLoop

BFSEnd:
add esp, 800

pop edi
pop ebx

mov eax, ebx
push edx
mov edx, cols
mul edx
pop edx
add eax, edi

movzx eax, byte ptr [ebp + eax]

add esp, cells

ReachDone:
pop ebp
pop edi
pop esi
pop edx
pop ecx
pop ebx
ret
IsReachable endp
PickupPassenger proc
push eax
push ebx
push ecx
push edx
push edi
push esi

mov esi, eax
shl esi, 2

mov ebx, passengerRows[esi]
mov edi, passengerCols[esi]

mov eax, ebx
push edx
mov edx, cols
mul edx
pop edx
add eax, edi
mov byte ptr grid[eax], '.'

call draw_cell

mov passengerRows[esi], -1

mov ebx, passengerDestRows[esi]
mov edi, passengerDestCols[esi]
mov eax, ebx
push edx
mov edx, cols
mul edx
pop edx
add eax, edi
mov byte ptr grid[eax], 'D'

call draw_cell

pop esi
pop edi
pop edx
pop ecx
pop ebx
pop eax
ret
PickupPassenger endp
DropoffPassenger proc
push ebx
push ecx
push edx
push esi
push edi

mov eax, dword ptr [passengerInTaxi]
cmp eax, -1
je DropDone

mov esi, eax
shl esi, 2

mov ebx, passengerDestRows[esi]
mov edi, passengerDestCols[esi]

mov eax, dword ptr [playerRow]
mov ecx, dword ptr [playerCol]

cmp eax, 0
je CheckDropDown
mov edx, eax
dec edx
cmp edx, ebx
jne CheckDropDown
cmp ecx, edi
je ValidDrop

CheckDropDown:
mov edx, ROWS
dec edx
cmp eax, edx
jge CheckDropLeft
mov edx, eax
inc edx
cmp edx, ebx
jne CheckDropLeft
cmp ecx, edi
je ValidDrop

CheckDropLeft:
cmp ecx, 0
je CheckDropRight
mov edx, ecx
dec edx
cmp eax, ebx
jne CheckDropRight
cmp edx, edi
je ValidDrop

CheckDropRight:
mov edx, cols
dec edx
cmp ecx, edx
jge DropDone
mov edx, ecx
inc edx
cmp eax, ebx
jne DropDone
cmp edx, edi
jne DropDone

ValidDrop:
mov eax, ebx
push edx
mov edx, cols
mul edx
pop edx
add eax, edi
mov byte ptr grid[eax], '.'

push ebx
push edi
call draw_cell
pop edi
pop ebx

mov dword ptr [passengerInTaxi], -1
add dword ptr [playerScore], 10
call play_dropsoound
inc dword ptr [psngr_dropped]
mov eax, dword ptr [psngr_dropped]
test eax, 1                      
jnz SkipUniversalSpeedIncrease   
mov eax, dword ptr [npcMoveDelay]
cmp eax, 300                     
jle SkipUniversalSpeedIncrease
sub eax, 100                     
mov dword ptr [npcMoveDelay], eax

SkipUniversalSpeedIncrease:
cmp dword ptr [currentGameMode], mode_career
jne SkipCareerCheck
inc dword ptr [levelPassengers]
call check_career_progress
cmp eax, 2
je CareerLevelRestart
cmp eax, 3
je CareerGameEnd
jmp SkipCareerCheck

CareerLevelRestart:
pop edi
pop esi
pop edx
pop ecx
pop ebx
mov eax, 2  
ret

CareerGameEnd:
pop edi
pop esi
pop edx
pop ecx
pop ebx
mov eax, 3  
ret

SkipCareerCheck:
xor eax, eax  

DropDone:
xor eax, eax  
pop edi
pop esi
pop edx
pop ecx
pop ebx
ret
DropoffPassenger endp
place_houseblocks_2 proc
push ebp
mov ebp, esp
push ebx
push ecx
push edx
push esi
push edi

mov eax, dword ptr [housesToPlace]
cmp eax, 0
jle ph2_done

ph2_outer:
cmp eax, 3
jl ph2_place_singles

mov ecx, 4
call get_rand_idx
add eax, 3
mov esi, eax

mov edx, dword ptr [housesToPlace]
cmp esi, edx
jle ph2_len_ok
mov esi, edx
cmp esi, 3
jl ph2_place_singles
ph2_len_ok:

mov edi, 200
ph2_attempts:
cmp edi, 0
je ph2_break_to_singles

mov ecx, 2
call get_rand_idx
mov bl, al

cmp bl, 0
je ph2_horizontal_pick

mov eax, ROWS
sub eax, esi
inc eax
cmp eax, 1
jl ph2_decrement_attempt
mov ecx, eax
call get_rand_idx
mov ebx, eax
mov ecx, cols
call get_rand_idx
mov ecx, eax

mov eax, ebx
push edx
mov edx, cols
mul edx
pop edx
add eax, ecx
mov ebx, eax

mov edx, 0
ph2_check_vert:
mov eax, ebx
push edx
push eax
mov eax, edx
push edx
mov edx, cols
mul edx
pop edx
mov ecx, eax
pop eax
add eax, ecx
pop edx
cmp grid[eax], '.'
jne ph2_decrement_attempt
inc edx
cmp edx, esi
jl ph2_check_vert

mov edx, 0
ph2_place_vert_loop:
mov eax, ebx
push edx
push eax
mov eax, edx
push edx
mov edx, cols
mul edx
pop edx
mov ecx, eax
pop eax
add eax, ecx
pop edx
mov byte ptr grid[eax], 'H'
dec dword ptr [housesToPlace]
inc edx
cmp edx, esi
jl ph2_place_vert_loop

mov eax, dword ptr [housesToPlace]
jmp ph2_outer

ph2_horizontal_pick:
mov eax, cols
sub eax, esi
inc eax
cmp eax, 1
jl ph2_decrement_attempt
mov ecx, eax
call get_rand_idx
mov edx, eax
mov ecx, ROWS
call get_rand_idx
mov ebx, eax

mov eax, ebx
push edx
push eax
mov eax, ebx
mov edx, cols
mul edx
pop ebx
pop edx
add eax, edx
mov ebx, eax

mov ecx, 0
ph2_check_horiz:
mov eax, ebx
add eax, ecx
cmp grid[eax], '.'
jne ph2_decrement_attempt
inc ecx
cmp ecx, esi
jl ph2_check_horiz

mov ecx, 0
ph2_place_horiz_loop:
mov eax, ebx
add eax, ecx
mov byte ptr grid[eax], 'H'
dec dword ptr [housesToPlace]
inc ecx
cmp ecx, esi
jl ph2_place_horiz_loop

mov eax, dword ptr [housesToPlace]
jmp ph2_outer

ph2_decrement_attempt:
dec edi
jmp ph2_attempts

ph2_break_to_singles:
jmp ph2_place_singles

ph2_place_singles:
mov ecx, dword ptr [housesToPlace]
cmp ecx, 0
jle ph2_done
ph2_single_loop:
mov ecx, cells
call get_rand_idx
mov esi, eax
cmp grid[esi], '.'
jne ph2_single_loop
mov byte ptr grid[esi], 'H'
dec dword ptr [housesToPlace]
mov ecx, dword ptr [housesToPlace]
cmp ecx, 0
jne ph2_single_loop

ph2_done:
pop edi
pop esi
pop edx
pop ecx
pop ebx
pop ebp
ret
place_houseblocks_2 endp
check_clear_path proc
push ebx
push esi
push edi

mov eax, 0
push ebx
push edi

cmp esi, dirup
je CheckUp
cmp esi, dirdown
je CheckDown
cmp esi, dirleft
je CheckLeft
cmp esi, dirright
je CheckRight
jmp CheckInvalid

CheckUp:
CheckUpLoop:
cmp ebx, 0
jle CheckUpDone
dec ebx
push eax
mov eax, ebx
push edx
mov edx, cols
mul edx
pop edx
add eax, edi
mov cl, grid[eax]
pop eax
cmp cl, '.'
jne CheckUpDone
inc eax
jmp CheckUpLoop
CheckUpDone:
mov edx, ebx
mov ecx, edi
jmp CheckValidate

CheckDown:
CheckDownLoop:
push eax
mov eax, ROWS
dec eax
cmp ebx, eax
pop eax
jge CheckDownDone
inc ebx
push eax
mov eax, ebx
push edx
mov edx, cols
mul edx
pop edx
add eax, edi
mov cl, grid[eax]
pop eax
cmp cl, '.'
jne CheckDownDone
inc eax
jmp CheckDownLoop
CheckDownDone:
mov edx, ebx
mov ecx, edi
jmp CheckValidate

CheckLeft:
CheckLeftLoop:
cmp edi, 0
jle CheckLeftDone
dec edi
push eax
mov eax, ebx
push edx
mov edx, cols
mul edx
pop edx
add eax, edi
mov cl, grid[eax]
pop eax
cmp cl, '.'
jne CheckLeftDone
inc eax
jmp CheckLeftLoop
CheckLeftDone:
mov edx, ebx
mov ecx, edi
jmp CheckValidate

CheckRight:
CheckRightLoop:
push eax
mov eax, cols
dec eax
cmp edi, eax
pop eax
jge CheckRightDone
inc edi
push eax
mov eax, ebx
push edx
mov edx, cols
mul edx
pop edx
add eax, edi
mov cl, grid[eax]
pop eax
cmp cl, '.'
jne CheckRightDone
inc eax
jmp CheckRightLoop
CheckRightDone:
mov edx, ebx
mov ecx, edi
jmp CheckValidate

CheckValidate:
cmp eax, 8
jge CheckDone

CheckInvalid:
mov eax, 0
mov edx, 0
mov ecx, 0

CheckDone:
add esp, 8
pop edi
pop esi
pop ebx
ret
check_clear_path endp
move_other_cars proc
push eax
push ebx
push ecx
push edx
push esi
push edi

mov ecx, dword ptr [otherCarCount]
cmp ecx, 0
je MoveOthersDone

xor esi, esi

MoveOthersLoop:
cmp esi, dword ptr [otherCarCount]
jge MoveOthersDone

mov eax, esi
shl eax, 2
mov ebx, otherCarRows[eax]
mov edi, otherCarCols[eax]
mov edx, otherCarDirs[eax]

push ebx
push edi

cmp edx, dirup
je TryMoveUp
cmp edx, dirdown
je TryMoveDown
cmp edx, dirleft
je TryMoveLeft
cmp edx, dirright
je TryMoveRight
jmp SkipThisCar

TryMoveUp:
cmp ebx, 0
jle HitBoundaryVert
dec ebx
jmp CheckNextPos

TryMoveDown:
mov eax, ROWS
dec eax
cmp ebx, eax
jge HitBoundaryVert
inc ebx
jmp CheckNextPos

TryMoveLeft:
cmp edi, 0
jle HitBoundaryHoriz
dec edi
jmp CheckNextPos

TryMoveRight:
mov eax, cols
dec eax
cmp edi, eax
jge HitBoundaryHoriz
inc edi
jmp CheckNextPos

HitBoundaryVert:
pop edi
pop ebx
push esi
mov eax, esi
shl eax, 2
cmp edx, dirup
je ChangeToDown
mov edx, dirup
mov otherCarDirs[eax], edx
pop esi
jmp NextOtherCar
ChangeToDown:
mov edx, dirdown
mov otherCarDirs[eax], edx
pop esi
jmp NextOtherCar

HitBoundaryHoriz:
pop edi
pop ebx
push esi
mov eax, esi
shl eax, 2
cmp edx, dirleft
je ChangeToRight
mov edx, dirleft
mov otherCarDirs[eax], edx
pop esi
jmp NextOtherCar
ChangeToRight:
mov edx, dirright
mov otherCarDirs[eax], edx
pop esi
jmp NextOtherCar

CheckNextPos:
mov eax, ebx
push edx
push eax
mov edx, cols
mul edx
pop ecx
pop edx
add eax, edi
mov cl, grid[eax]

cmp cl, '.'
je CanMove

pop edi
pop ebx
push esi
mov eax, esi
shl eax, 2

cmp edx, dirup
je RevToDown
cmp edx, dirdown
je RevToUp
cmp edx, dirleft
je RevToRight
cmp edx, dirright
je RevToLeft
pop esi
jmp NextOtherCar

RevToDown:
mov edx, dirdown
mov otherCarDirs[eax], edx
pop esi
jmp NextOtherCar
RevToUp:
mov edx, dirup
mov otherCarDirs[eax], edx
pop esi
jmp NextOtherCar
RevToRight:
mov edx, dirright
mov otherCarDirs[eax], edx
pop esi
jmp NextOtherCar
RevToLeft:
mov edx, dirleft
mov otherCarDirs[eax], edx
pop esi
jmp NextOtherCar

CanMove:
pop edi
pop ebx

push esi

mov eax, ebx
push edx
push eax
mov edx, cols
mul edx
pop ecx
pop edx
add eax, edi
mov byte ptr grid[eax], '.'
push ebx
push edi
push edx
call draw_cell
pop edx
pop edi
pop ebx

cmp edx, dirup
je DoMoveUp
cmp edx, dirdown
je DoMoveDown
cmp edx, dirleft
je DoMoveLeft
cmp edx, dirright
je DoMoveRight
pop esi
jmp NextOtherCar

DoMoveUp:
dec ebx
jmp UpdatePos
DoMoveDown:
inc ebx
jmp UpdatePos
DoMoveLeft:
dec edi
jmp UpdatePos
DoMoveRight:
inc edi

UpdatePos:
mov eax, ebx
push edx
push eax
mov edx, cols
mul edx
pop ecx
pop edx
add eax, edi
mov byte ptr grid[eax], 'O'

pop esi
mov eax, esi
shl eax, 2
mov otherCarRows[eax], ebx
mov otherCarCols[eax], edi

push esi
call draw_cell
pop esi
jmp NextOtherCar

SkipThisCar:
pop edi
pop ebx

NextOtherCar:
inc esi
jmp MoveOthersLoop

MoveOthersDone:
pop edi
pop esi
pop edx
pop ecx
pop ebx
pop eax
ret
move_other_cars endp
savegame proc
push eax
push ebx
push ecx
push edx
push esi
push edi
mov edx, OFFSET userSaveFile
call CreateOutputFile
mov fileHandle, eax
cmp eax, INVALID_HANDLE_VALUE
jne SaveFileCreated
mov edx, OFFSET errorMsg1
call WriteString
call Crlf
jmp SaveDone

SaveFileCreated:
mov edi, OFFSET buffer
mov eax, dword ptr [currentGameMode]
call dword2str
mov byte ptr [edi], 0Ah
inc edi
mov eax, dword ptr [careerLevel]
call dword2str
mov byte ptr [edi], 0Ah
inc edi
mov eax, dword ptr [psngr_dropped]
call dword2str
mov byte ptr [edi], 0Ah
inc edi

mov eax, dword ptr [careerTarget]
call dword2str
mov byte ptr [edi], 0Ah
inc edi

mov eax, dword ptr [levelPassengers]
call dword2str
mov byte ptr [edi], 0Ah
inc edi
mov eax, dword ptr [timeRemaining]
call dword2str
mov byte ptr [edi], 0Ah
inc edi
mov eax, dword ptr [livesRemaining]
call dword2str
mov byte ptr [edi], 0Ah
inc edi
mov eax, dword ptr [playerRow]
call dword2str
mov byte ptr [edi], 0Ah
inc edi
mov eax, dword ptr [playerCol]
call dword2str
mov byte ptr [edi], 0Ah
inc edi
mov eax, dword ptr [playerColor]
call dword2str
mov byte ptr [edi], 0Ah
inc edi
mov eax, dword ptr [curr_diff]
call dword2str
mov byte ptr [edi], 0Ah
inc edi
mov eax, dword ptr [coinsToPlace]
call dword2str
mov byte ptr [edi], 0Ah
inc edi

mov eax, dword ptr [minpass]
call dword2str
mov byte ptr [edi], 0Ah
inc edi

mov eax, dword ptr [maxPassengers]
call dword2str
mov byte ptr [edi], 0Ah
inc edi

mov eax, dword ptr [hurdlesToPlace]
call dword2str
mov byte ptr [edi], 0Ah
inc edi

mov eax, dword ptr [treesToPlace]
call dword2str
mov byte ptr [edi], 0Ah
inc edi

mov eax, dword ptr [other_car2place]
call dword2str
mov byte ptr [edi], 0Ah
inc edi

mov eax, dword ptr [npcMoveDelay]
call dword2str
mov byte ptr [edi], 0Ah
inc edi
mov eax, dword ptr [playerScore]
call signed_to_str
mov byte ptr [edi], 0Ah
inc edi
mov eax, dword ptr [passengerInTaxi]
call signed_to_str
mov byte ptr [edi], 0Ah
inc edi
mov eax, dword ptr [passengerCount]
call dword2str
mov byte ptr [edi], 0Ah
inc edi
mov ecx, max_psngr
xor esi, esi
SavePassLoop:
mov eax, esi
shl eax, 2

mov eax, passengerRows[eax]
call signed_to_str
mov byte ptr [edi], 0Ah
inc edi

mov eax, esi
shl eax, 2
mov eax, passengerCols[eax]
call signed_to_str
mov byte ptr [edi], 0Ah
inc edi

mov eax, esi
shl eax, 2
mov eax, passengerDestRows[eax]
call signed_to_str
mov byte ptr [edi], 0Ah
inc edi

mov eax, esi
shl eax, 2
mov eax, passengerDestCols[eax]
call signed_to_str
mov byte ptr [edi], 0Ah
inc edi

inc esi
loop SavePassLoop
mov eax, dword ptr [otherCarCount]
call dword2str
mov byte ptr [edi], 0Ah
inc edi

mov ecx, max_other_cars
xor esi, esi
SaveOtherLoop:
mov eax, esi
shl eax, 2

mov eax, otherCarRows[eax]
call dword2str
mov byte ptr [edi], 0Ah
inc edi

mov eax, esi
shl eax, 2
mov eax, otherCarCols[eax]
call dword2str
mov byte ptr [edi], 0Ah
inc edi

mov eax, esi
shl eax, 2
mov eax, otherCarDirs[eax]
call dword2str
mov byte ptr [edi], 0Ah
inc edi

mov eax, esi
shl eax, 2
mov eax, otherCarColors[eax]
call dword2str
mov byte ptr [edi], 0Ah
inc edi

inc esi
loop SaveOtherLoop
mov esi, 0
SaveGridLoop:
movzx eax, byte ptr grid[esi]
call dword2str
mov byte ptr [edi], 0Ah
inc edi
inc esi
cmp esi, cells
jl SaveGridLoop
mov eax, edi
sub eax, OFFSET buffer
mov ecx, eax
mov eax, fileHandle
mov edx, OFFSET buffer
call WriteToFile
jc SaveWriteError
mov eax, fileHandle
call CloseFile
call Clrscr
mov dh, 10
mov dl, 30
call Gotoxy
mov edx, OFFSET saveSuccessMsg
call WriteString
call ReadChar
jmp SaveDone

SaveWriteError:
mov edx, OFFSET errorMsg2
call WriteString
call Crlf
mov eax, fileHandle
call CloseFile

SaveDone:
pop edi
pop esi
pop edx
pop ecx
pop ebx
pop eax
ret
savegame endp
dword2str proc
push eax
push ebx
push ecx
push edx

mov ebx, 10
mov ecx, 0

ConvertLoop:
xor edx, edx
div ebx
add dl, '0'
push edx
inc ecx
cmp eax, 0
jne ConvertLoop

WriteDigits:
pop eax
mov byte ptr [edi], al
inc edi
loop WriteDigits

pop edx
pop ecx
pop ebx
pop eax
ret
dword2str endp
LoadGame proc
push ebx
push ecx
push edx
push esi
push edi
mov edx, OFFSET userSaveFile
call OpenInputFile
mov fileHandle, eax
cmp eax, INVALID_HANDLE_VALUE
jne LoadFileOpened
xor eax, eax
jmp LoadDone

LoadFileOpened:
mov eax, fileHandle
mov edx, OFFSET buffer
mov ecx, 10000
call ReadFromFile
jc LoadReadError
mov bytesRead, eax
mov eax, fileHandle
call CloseFile
mov esi, OFFSET buffer
call ParseNumber
mov dword ptr [currentGameMode], eax
call ParseNumber
mov dword ptr [psngr_dropped], eax
call ParseNumber
mov dword ptr [careerLevel], eax

call ParseNumber
mov dword ptr [careerTarget], eax

call ParseNumber
mov dword ptr [levelPassengers], eax
call ParseNumber
mov dword ptr [timeRemaining], eax
call ParseNumber
mov dword ptr [livesRemaining], eax
call ParseNumber
mov dword ptr [playerRow], eax
call ParseNumber
mov dword ptr [playerCol], eax
call ParseNumber
mov dword ptr [playerColor], eax
call ParseNumber
mov dword ptr [curr_diff], eax
call ParseNumber
mov dword ptr [coinsToPlace], eax

call ParseNumber
mov dword ptr [minpass], eax

call ParseNumber
mov dword ptr [maxPassengers], eax

call ParseNumber
mov dword ptr [hurdlesToPlace], eax

call ParseNumber
mov dword ptr [treesToPlace], eax

call ParseNumber
mov dword ptr [other_car2place], eax

call ParseNumber
mov dword ptr [npcMoveDelay], eax
call parse_snum
mov dword ptr [playerScore], eax
call parse_snum
mov dword ptr [passengerInTaxi], eax
call ParseNumber
mov dword ptr [passengerCount], eax
mov ecx, max_psngr
xor edi, edi
LoadPassLoop:
push ecx
push edi

call parse_snum
mov edi, [esp]
shl edi, 2
mov passengerRows[edi], eax

call parse_snum
mov edi, [esp]
shl edi, 2
mov passengerCols[edi], eax

call parse_snum
mov edi, [esp]
shl edi, 2
mov passengerDestRows[edi], eax

call parse_snum
mov edi, [esp]
shl edi, 2
mov passengerDestCols[edi], eax

pop edi
pop ecx
inc edi
loop LoadPassLoop
call ParseNumber
mov dword ptr [otherCarCount], eax
mov ecx, max_other_cars
xor edi, edi
LoadOtherLoop:
push ecx
push edi

call ParseNumber
mov edi, [esp]
shl edi, 2
mov otherCarRows[edi], eax

call ParseNumber
mov edi, [esp]
shl edi, 2
mov otherCarCols[edi], eax

call ParseNumber
mov edi, [esp]
shl edi, 2
mov otherCarDirs[edi], eax

call ParseNumber
mov edi, [esp]
shl edi, 2
mov otherCarColors[edi], eax

pop edi
pop ecx
inc edi
loop LoadOtherLoop
mov edi, 0
LoadGridLoop:
call ParseNumber
mov byte ptr grid[edi], al
inc edi
cmp edi, cells
jl LoadGridLoop
cmp dword ptr [currentGameMode], mode_time
jne SkipTimeInit
call GetMseconds
mov dword ptr [lastTimerUpdate], eax
SkipTimeInit:

mov eax, 1
jmp LoadDone

LoadReadError:
mov eax, fileHandle
call CloseFile
xor eax, eax

LoadDone:
pop edi
pop esi
pop edx
pop ecx
pop ebx
ret
LoadGame endp
ParseNumber proc
push ebx
push ecx
push edx

xor eax, eax
xor ebx, ebx
mov ecx, 10

ParseNumLoop:
mov bl, byte ptr [esi]
inc esi
cmp bl, 0Ah
je ParseNumDone
cmp bl, 0
je ParseNumDone
sub bl, '0'
push edx
mul ecx
pop edx
add eax, ebx
jmp ParseNumLoop

ParseNumDone:
pop edx
pop ecx
pop ebx
ret
ParseNumber endp
parse_snum proc
push ebx
push ecx
push edx

xor edx, edx 
mov bl, byte ptr [esi]
cmp bl, '-'
jne ParseSigned
mov edx, 1
inc esi

ParseSigned:
xor eax, eax
xor ebx, ebx
mov ecx, 10

ParseSignedLoop:
mov bl, byte ptr [esi]
inc esi
cmp bl, 0Ah
je ParseSignedDone
cmp bl, 0
je ParseSignedDone
sub bl, '0'
push edx
mul ecx
pop edx
add eax, ebx
jmp ParseSignedLoop

ParseSignedDone:
cmp edx, 1
jne ParseSignedPos
neg eax

ParseSignedPos:
pop edx
pop ecx
pop ebx
ret
parse_snum endp
ShowMenu proc
push ebx
push ecx
push edx

ShowMenuAgain:
call Clrscr

mov dh, 3
mov dl, 10
call Gotoxy
mov eax, yellow
call SetTextColor
mov edx, OFFSET gameTitle1
call WriteString

mov dh, 4
mov dl, 10
call Gotoxy
mov edx, OFFSET gameTitle2
call WriteString

mov dh, 5
mov dl, 10
call Gotoxy
mov edx, OFFSET gameTitle3
call WriteString

mov dh, 6
mov dl, 10
call Gotoxy
mov edx, OFFSET gameTitle4
call WriteString
mov dh, 8
mov dl, 22
call Gotoxy
mov eax, yellow
call SetTextColor
mov edx, OFFSET taxiArt1
call WriteString

mov dh, 9
mov dl, 22
call Gotoxy
mov edx, OFFSET taxiArt2
call WriteString

mov dh, 10
mov dl, 22
call Gotoxy
mov edx, OFFSET taxiArt3
call WriteString

mov dh, 11
mov dl, 22
call Gotoxy
mov edx, OFFSET taxiArt4
call WriteString

mov dh, 12
mov dl, 22
call Gotoxy
mov edx, OFFSET taxiArt5
call WriteString

mov dh, 13
mov dl, 22
call Gotoxy
mov edx, OFFSET taxiArt6
call WriteString

mov dh, 14
mov dl, 12
call Gotoxy
mov eax, lightCyan
call SetTextColor
mov edx, OFFSET menuTop
call WriteString
mov dh, 15
mov dl, 12
call Gotoxy
mov edx, OFFSET menuSide
call WriteString

mov dh, 15
mov dl, 22
call Gotoxy
mov eax, white
call SetTextColor
mov edx, OFFSET welcomeMsg
call WriteString
mov eax, lightGreen
call SetTextColor
mov edx, OFFSET username
call WriteString
mov eax, white
call SetTextColor
mov edx, OFFSET exclamation
call WriteString
mov dh, 16
mov dl, 12
call Gotoxy
mov eax, lightCyan
call SetTextColor
mov edx, OFFSET menuDiv
call WriteString
mov dh, 17
mov dl, 12
call Gotoxy
mov edx, OFFSET menuSide
call WriteString

mov dh, 17
mov dl, 22
call Gotoxy
mov eax, lightGreen
call SetTextColor
mov edx, OFFSET menuOption1
call WriteString
mov dh, 18
mov dl, 12
call Gotoxy
mov eax, lightCyan
call SetTextColor
mov edx, OFFSET menuSide
call WriteString

mov dh, 18
mov dl, 22
call Gotoxy
mov eax, lightBlue
call SetTextColor
mov edx, OFFSET menuOption2
call WriteString
mov dh, 19
mov dl, 12
call Gotoxy
mov eax, lightCyan
call SetTextColor
mov edx, OFFSET menuSide
call WriteString

mov dh, 19
mov dl, 22
call Gotoxy
mov eax, yellow
call SetTextColor
mov edx, OFFSET menuOption3
call WriteString
mov dh, 20
mov dl, 12
call Gotoxy
mov eax, lightCyan
call SetTextColor
mov edx, OFFSET menuSide
call WriteString

mov dh, 20
mov dl, 22
call Gotoxy
mov eax, lightMagenta
call SetTextColor
mov edx, OFFSET menuOption4
call WriteString
mov dh, 21
mov dl, 12
call Gotoxy
mov eax, lightCyan
call SetTextColor
mov edx, OFFSET menuSide
call WriteString

mov dh, 21
mov dl, 22
call Gotoxy
mov eax, red
call SetTextColor
mov edx, OFFSET menuOption5
call WriteString
mov dh, 22
mov dl, 12
call Gotoxy
mov eax, lightCyan
call SetTextColor
mov edx, OFFSET menuDiv
call WriteString
mov dh, 23
mov dl, 12
call Gotoxy
mov edx, OFFSET menuSide
call WriteString

mov dh, 23
mov dl, 22
call Gotoxy
mov eax, white
call SetTextColor
mov edx, OFFSET menuPrompt
call WriteString
mov dh, 24
mov dl, 12
call Gotoxy
mov eax, lightCyan
call SetTextColor
mov edx, OFFSET menuBot
call WriteString

mov dh, 23
mov dl, 52
call Gotoxy
mov eax, yellow
call SetTextColor

call ReadChar
call WriteChar

cmp al, '1'
je MenuChoice1
cmp al, '2'
je MenuChoice2
cmp al, '3'
je MenuChoice3
cmp al, '4'
je MenuChoice4
cmp al, '5'
je MenuChoice5
mov dh, 26
mov dl, 20
call Gotoxy
mov eax, white + (red * 16)
call SetTextColor
mov al, ' '
call WriteChar
mov edx, OFFSET invalidChoice
call WriteString
mov al, ' '
call WriteChar
mov eax, 1000
call Delay
jmp ShowMenuAgain

MenuChoice1:
call play_click_sound
mov eax, 1
jmp MenuDone
MenuChoice2:
call play_click_sound
mov eax, 2
jmp MenuDone
MenuChoice3:
call play_click_sound
mov eax, 3
jmp MenuDone
MenuChoice4:
call play_click_sound
mov eax, 4
jmp MenuDone
MenuChoice5:
call play_click_sound
mov eax, 5

MenuDone:
pop edx
pop ecx
pop ebx
ret
ShowMenu endp

show_pscreen proc
push eax
push ebx
push ecx
push edx
call Clrscr
mov dh, 8
mov dl, 30
call Gotoxy

mov eax, yellow + (black * 16)
call SetTextColor
call WriteChar
mov eax, white + (black * 16)
call SetTextColor

mov dh, 10
mov dl, 38
call Gotoxy
mov edx, OFFSET pauseMsg
call WriteString

mov eax, lightCyan + (black * 16)
call SetTextColor

mov dh, 12
mov dl, 36
call Gotoxy
mov edx, offset resumeMsg
call WriteString

mov dh, 13
mov dl, 34
call Gotoxy
mov edx, offset pauseSaveMsg
call WriteString

mov eax, white
call SetTextColor

pop edx
pop ecx
pop ebx
pop eax
ret
show_pscreen endp
disp_inst proc
push eax
push edx

call Clrscr

mov dh, 2
mov dl, 28
call Gotoxy
mov eax, yellow
call SetTextColor
mov edx, OFFSET instructionsTitle
call WriteString
call Crlf
call Crlf

mov dh, 4
mov dl, 5
call Gotoxy
mov eax, lightGreen
call SetTextColor
mov edx, offset instructions1
call WriteString

mov dh, 5
mov dl, 5
call Gotoxy
mov eax, white
call SetTextColor
mov edx, offset instructions2
call WriteString

mov dh, 6
mov dl, 5
call Gotoxy
mov edx, offset instructions3
call WriteString

mov dh, 8
mov dl, 5
call Gotoxy
mov eax, lightCyan
call SetTextColor
mov edx, offset instructions5
call WriteString

mov dh, 9
mov dl, 5
call Gotoxy
mov eax, white
call SetTextColor
mov edx, offset instructions6
call WriteString

mov dh, 10
mov dl, 5
call Gotoxy
mov edx, offset instructions7
call WriteString

mov dh, 11
mov dl, 5
call Gotoxy
mov edx, offset instructions8
call WriteString

mov dh, 12
mov dl, 5
call Gotoxy
mov edx, offset instructions9
call WriteString

mov dh, 13
mov dl, 5
call Gotoxy
mov edx, offset instructions10
call WriteString
mov dh, 15
mov dl, 5
call Gotoxy
mov eax, lightMagenta
call SetTextColor
mov edx, offset instructions12
call WriteString

mov dh, 16
mov dl, 5
call Gotoxy
mov eax, red
call SetTextColor
mov edx, offset instructions13
call WriteString

mov dh, 17
mov dl, 5
call Gotoxy
mov eax, yellow
call SetTextColor
mov edx, OFFSET instructions14
call WriteString
mov dh, 19
mov dl, 5
call Gotoxy
mov eax, lightGreen
call SetTextColor
mov edx, OFFSET instructions16
call WriteString

mov dh, 20
mov dl, 5
call Gotoxy
mov eax, white
call SetTextColor
mov edx, OFFSET instructions17
call WriteString

mov dh, 21
mov dl, 5
call Gotoxy
mov edx, OFFSET instructions18
call WriteString

mov dh, 22
mov dl, 5
call Gotoxy
mov edx, OFFSET instructions19
call WriteString
mov dh, 24
mov dl, 20
call Gotoxy
mov eax, yellow
call SetTextColor
mov edx, OFFSET instructions21
call WriteString

call ReadChar

pop edx
pop eax
ret
disp_inst endp
slct_taxicolor proc
push eax
push edx

ColorSelectLoop:
call Clrscr

mov dh, 8
mov dl, 25
call Gotoxy
mov eax, yellow
call SetTextColor
mov edx, OFFSET colorPrompt
call WriteString
call Crlf
call Crlf

mov dh, 10
mov dl, 25
call Gotoxy
mov eax, red
call SetTextColor
mov edx, OFFSET coloropt1
call WriteString

mov dh, 11
mov dl, 25
call Gotoxy
mov eax, yellow
call SetTextColor
mov edx, OFFSET coloropt2
call WriteString

mov dh, 12
mov dl, 25
call Gotoxy
mov eax, lightCyan
call SetTextColor
mov edx, OFFSET coloropt3
call WriteString

mov dh, 14
mov dl, 25
call Gotoxy
mov eax, white
call SetTextColor
mov edx, OFFSET colorChoicePrompt
call WriteString

call ReadChar
call WriteChar
call Crlf

cmp al, '1'
je ChooseRed
cmp al, '2'
je ChooseYellow
cmp al, '3'
je ChooseRandom
mov dh, 16
mov dl, 25
call Gotoxy
mov eax, red
call SetTextColor
mov edx, OFFSET invalidColorMsg
call WriteString
mov eax, 1000
call Delay
jmp ColorSelectLoop

ChooseRed:
mov dword ptr [playerColor], red
jmp ColorSelected

ChooseYellow:
mov dword ptr [playerColor], yellow
jmp ColorSelected

ChooseRandom:
mov ecx, 2
call get_rand_idx
cmp eax, 0
je RandomRed
mov dword ptr [playerColor], yellow
jmp ColorSelected
RandomRed:
mov dword ptr [playerColor], red

ColorSelected:
pop edx
pop eax
ret
slct_taxicolor endp
slct_diff proc
push eax
push edx

DiffSelectLoop:
call Clrscr

mov dh, 8
mov dl, 20
call Gotoxy
mov eax, yellow
call SetTextColor
mov edx, OFFSET difficultyPrompt
call WriteString
call Crlf
call Crlf

mov dh, 10
mov dl, 20
call Gotoxy
mov eax, lightGreen
call SetTextColor
mov edx, OFFSET diffOption1
call WriteString

mov dh, 11
mov dl, 20
call Gotoxy
mov eax, lightCyan
call SetTextColor
mov edx, OFFSET diffOption2
call WriteString

mov dh, 12
mov dl, 20
call Gotoxy
mov eax, lightRed
call SetTextColor
mov edx, OFFSET diffOption3
call WriteString

mov dh, 14
mov dl, 20
call Gotoxy
mov eax, white
call SetTextColor
mov edx, OFFSET diffChoicePrompt
call WriteString

call ReadChar
call WriteChar
call Crlf

cmp al, '1'
je ChooseEasy
cmp al, '2'
je ChooseStandard
cmp al, '3'
je ChooseHard
mov dh, 16
mov dl, 20
call Gotoxy
mov eax, red
call SetTextColor
mov edx, OFFSET invalidDiffMsg
call WriteString
mov eax, 1000
call Delay
jmp DiffSelectLoop

ChooseEasy:
mov dword ptr [curr_diff], diff_easy
mov ecx, 3
call get_rand_idx
add eax, 8
mov dword ptr [coinsToPlace], eax

mov dword ptr [minpass], 2
mov dword ptr [maxPassengers], 5

mov ecx, 2
call get_rand_idx
add eax, 2
mov dword ptr [hurdlesToPlace], eax

mov ecx, 2
call get_rand_idx
add eax, 1
mov dword ptr [treesToPlace], eax

mov ecx, 2
call get_rand_idx
add eax, 1
mov dword ptr [other_car2place], eax

mov dword ptr [npcMoveDelay], 1500
jmp DiffSelected

ChooseStandard:
mov dword ptr [curr_diff], diff_std
mov ecx, 3
call get_rand_idx
add eax, 5
mov dword ptr [coinsToPlace], eax

mov dword ptr [minpass], 2
mov dword ptr [maxPassengers], 5

mov ecx, 3
call get_rand_idx
add eax, 3
mov dword ptr [hurdlesToPlace], eax

mov ecx, 3
call get_rand_idx
add eax, 1
mov dword ptr [treesToPlace], eax

mov ecx, 2
call get_rand_idx
add eax, 2
mov dword ptr [other_car2place], eax

mov dword ptr [npcMoveDelay], 1000
jmp DiffSelected

ChooseHard:
mov dword ptr [curr_diff], diff_hard
mov ecx, 3
call get_rand_idx
add eax, 3
mov dword ptr [coinsToPlace], eax

mov dword ptr [minpass], 3
mov dword ptr [maxPassengers], 4

mov ecx, 3
call get_rand_idx
add eax, 5
mov dword ptr [hurdlesToPlace], eax

mov ecx, 3
call get_rand_idx
add eax, 3
mov dword ptr [treesToPlace], eax

mov ecx, 2
call get_rand_idx
add eax, 3
mov dword ptr [other_car2place], eax

mov dword ptr [npcMoveDelay], 700

DiffSelected:
pop edx
pop eax
ret
slct_diff endp
SelectGameMode proc
push eax
push edx

ModeSelectLoop:
call Clrscr

mov dh, 7
mov dl, 25
call Gotoxy
mov eax, yellow
call SetTextColor
mov edx, OFFSET modeMenuTitle
call WriteString
call Crlf
call Crlf

mov dh, 9
mov dl, 25
call Gotoxy
mov eax, white
call SetTextColor
mov edx, OFFSET modeOption1
call WriteString

mov dh, 10
mov dl, 25
call Gotoxy
mov eax, lightGreen
call SetTextColor
mov edx, OFFSET modeOption2
call WriteString

mov dh, 11
mov dl, 25
call Gotoxy
mov eax, lightCyan
call SetTextColor
mov edx, OFFSET modeOption3
call WriteString

mov dh, 12
mov dl, 25
call Gotoxy
mov eax, lightMagenta
call SetTextColor
mov edx, OFFSET modeOption4
call WriteString

mov dh, 13
mov dl, 25
call Gotoxy
mov eax, lightGray
call SetTextColor
mov edx, OFFSET modeOption5
call WriteString

mov dh, 15
mov dl, 25
call Gotoxy
mov eax, white
call SetTextColor
mov edx, OFFSET modePrompt
call WriteString

call ReadChar
call WriteChar
call Crlf

cmp al, '1'
je ChooseStandard
cmp al, '2'
je ChooseCareer
cmp al, '3'
je ChooseTime
cmp al, '4'
je ChooseEndless
cmp al, '5'
je BackToMenu
mov dh, 17
mov dl, 25
call Gotoxy
mov eax, red
call SetTextColor
mov edx, OFFSET invalidChoice
call WriteString
mov eax, 1000
call Delay
jmp ModeSelectLoop

ChooseStandard:
call play_click_sound
mov dword ptr [currentGameMode], mode_std
jmp ModeSelected

ChooseCareer:
call play_click_sound
mov dword ptr [currentGameMode], mode_career
mov dword ptr [careerLevel], 1
mov dword ptr [careerTarget], 50
mov dword ptr [levelPassengers], 0
jmp ModeSelected

ChooseTime:
call play_click_sound
mov dword ptr [currentGameMode], mode_time
mov dword ptr [timeRemaining], 120  ; 2 min
call GetMseconds
mov dword ptr [lastTimerUpdate], eax
jmp ModeSelected

ChooseEndless:
call play_click_sound
mov dword ptr [currentGameMode], mode_endless
mov dword ptr [livesRemaining], 3
jmp ModeSelected

BackToMenu:
call play_click_sound
xor eax, eax 
pop edx      
pop eax     
jmp ModeDone

ModeSelected:
mov eax, 1  

ModeDone:
pop edx      
pop eax      
ret
SelectGameMode endp
slct_time_diff proc
push eax
push edx

TimeDiffSelectLoop:
call Clrscr

mov dh, 8
mov dl, 20
call Gotoxy
mov eax, yellow
call SetTextColor
mov edx, OFFSET timeDifficultyPrompt
call WriteString
call Crlf
call Crlf

mov dh, 10
mov dl, 20
call Gotoxy
mov eax, lightGreen
call SetTextColor
mov edx, OFFSET timeDiffOption1
call WriteString

mov dh, 11
mov dl, 20
call Gotoxy
mov eax, lightCyan
call SetTextColor
mov edx, OFFSET timeDiffOption2
call WriteString

mov dh, 12
mov dl, 20
call Gotoxy
mov eax, lightRed
call SetTextColor
mov edx, OFFSET timeDiffOption3
call WriteString

mov dh, 14
mov dl, 20
call Gotoxy
mov eax, white
call SetTextColor
mov edx, OFFSET diffChoicePrompt
call WriteString

call ReadChar
call WriteChar
call Crlf

cmp al, '1'
je ChooseEasyTime
cmp al, '2'
je ChooseMediumTime
cmp al, '3'
je ChooseHardTime
mov dh, 16
mov dl, 20
call Gotoxy
mov eax, red
call SetTextColor
mov edx, OFFSET invalidDiffMsg
call WriteString
mov eax, 1000
call Delay
jmp TimeDiffSelectLoop

ChooseEasyTime:
mov dword ptr [curr_diff], diff_easy
mov dword ptr [timeRemaining], 120 
mov dword ptr [coinsToPlace], 8

mov dword ptr [minpass], 2

mov dword ptr [maxPassengers], 5

mov dword ptr [hurdlesToPlace], 2


mov dword ptr [treesToPlace], 1
mov dword ptr [other_car2place], 1
mov dword ptr [npcMoveDelay], 1500
jmp TimeDiffSelected

ChooseMediumTime:
mov dword ptr [curr_diff], diff_std
mov dword ptr [timeRemaining], 60  
mov dword ptr [coinsToPlace], 6
mov dword ptr [minpass], 2
mov dword ptr [maxPassengers], 5
mov dword ptr [hurdlesToPlace], 4
mov dword ptr [treesToPlace], 2
mov dword ptr [other_car2place], 2
mov dword ptr [npcMoveDelay], 1000
jmp TimeDiffSelected

ChooseHardTime:
mov dword ptr [curr_diff], diff_hard
mov dword ptr [timeRemaining], 30   

mov dword ptr [coinsToPlace], 4
mov dword ptr [minpass], 2
mov dword ptr [maxPassengers], 4
mov dword ptr [hurdlesToPlace], 5
mov dword ptr [treesToPlace], 3
mov dword ptr [other_car2place], 3
mov dword ptr [npcMoveDelay], 700

TimeDiffSelected:
pop edx
pop eax
ret
slct_time_diff endp
UpdateTimeMode proc
push ebx

call GetMseconds
mov ebx, eax
sub ebx, dword ptr [last_timer_update]
cmp ebx, 1000
jl NoTimeUpdate
mov dword ptr [last_timer_update], eax
dec dword ptr [timeRemaining]
call disp_time_rem
cmp dword ptr [timeRemaining], 0
jle TimeUp

NoTimeUpdate:
pop ebx
xor eax, eax  
ret

TimeUp:
call stop_sounds
call endgame_Sound
call Clrscr

mov dh, 10
mov dl, 30
call Gotoxy
mov eax, yellow
call SetTextColor
mov edx, OFFSET timeUpMsg
call WriteString
mov eax, dword ptr [playerScore]
call WriteInt
call Crlf
call Crlf

mov dh, 12
mov dl, 30
call Gotoxy
mov edx, OFFSET pressKeyMsg
call WriteString
call ReadChar

call check_update_hs

pop ebx
mov eax, 1 
ret
UpdateTimeMode endp
disp_hud proc
push eax
push edx
push ebx
push ecx

mov dh, 85
mov dl, 0
call Gotoxy
mov eax, white
call SetTextColor
mov edx, OFFSET scoreMsg
call WriteString
mov eax, dword ptr [playerScore]
call WriteInt
mov eax, dword ptr [currentGameMode]
cmp eax, mode_std
je ShowStandardHUD
cmp eax, mode_career
je ShowCareerHUD
cmp eax, mode_time
je ShowTimeHUD
cmp eax, mode_endless
je ShowEndlessHUD
jmp ShowPassengerStatus

ShowStandardHUD:
jmp ShowPassengerStatus

ShowCareerHUD:
mov eax, lightCyan
call SetTextColor
mov edx, OFFSET levelMsg
call WriteString
mov eax, dword ptr [careerLevel]
call WriteDec

mov eax, yellow
call SetTextColor
mov edx, OFFSET targetMsg
call WriteString
mov eax, dword ptr [careerTarget]
call WriteDec

mov eax, lightGreen
call SetTextColor
mov edx, OFFSET passengersMsg
call WriteString
mov eax, dword ptr [levelPassengers]
call WriteDec
jmp ShowPassengerStatus

ShowTimeHUD:
call disp_time_rem 
jmp ShowPassengerStatus

ShowEndlessHUD:
mov eax, lightRed
call SetTextColor
mov edx, OFFSET endlessMsg
call WriteString
mov eax, dword ptr [livesRemaining]
call WriteDec

ShowPassengerStatus:
mov eax, white
call SetTextColor
mov edx, OFFSET passengerMsg
call WriteString

mov eax, dword ptr [passengerInTaxi]
cmp eax, -1
je NoPassengerHUD

mov eax, lightGreen
call SetTextColor
mov edx, OFFSET yesMsg
call WriteString
jmp HUDComplete

NoPassengerHUD:
mov eax, red
call SetTextColor
mov edx, OFFSET noMsg
call WriteString

HUDComplete:
mov eax, white
call SetTextColor

pop ecx
pop ebx
pop edx
pop eax
ret
disp_hud endp
check_career_progress proc
push eax
push edx
mov eax, dword ptr [playerScore]
cmp eax, dword ptr [careerTarget]
jl CareerNotComplete
LevelCompleteScreen:
call Clrscr

mov dh, 8
mov dl, 25
call Gotoxy
mov eax, yellow
call SetTextColor
mov edx, OFFSET levelCompleteTitle
call WriteString
call Crlf
call Crlf
mov dh, 10
mov dl, 25
call Gotoxy
mov eax, lightGreen
call SetTextColor
mov edx, OFFSET levelMsg
call WriteString
mov eax, dword ptr [careerLevel]
call WriteDec
mov al, ' '
call WriteChar
mov edx, OFFSET levelCompleteMsg
call WriteString
call Crlf
mov dh, 11
mov dl, 25
call Gotoxy
mov eax, white
call SetTextColor
mov edx, OFFSET levelCompleteScore
call WriteString
mov eax, dword ptr [playerScore]
call WriteInt
call Crlf
call Crlf
inc dword ptr [careerLevel]
cmp dword ptr [careerLevel], 11
jge CareerComplete
mov eax, dword ptr [careerLevel]
mov ebx, 50
mul ebx
push eax  
mov dh, 13
mov dl, 25
call Gotoxy
mov eax, lightCyan
call SetTextColor
mov edx, OFFSET nextLevelMsg
call WriteString
pop eax
push eax
call WriteDec
call Crlf
call Crlf
mov dh, 15
mov dl, 25
call Gotoxy
mov eax, white
call SetTextColor
mov edx, OFFSET levelChoicePrompt
call WriteString

mov dh, 16
mov dl, 25
call Gotoxy
mov edx, OFFSET levelChoicePrompt2
call WriteString

mov dh, 18
mov dl, 25
call Gotoxy
mov edx, OFFSET levelChoiceInput
call WriteString

call ReadChar
call WriteChar
call Crlf

cmp al, '1'
je ContinueToNextLevel
cmp al, '2'
je ReturnToMenu
mov dh, 20
mov dl, 25
call Gotoxy
mov eax, red
call SetTextColor
mov edx, OFFSET invalidLevelChoice
call WriteString
mov eax, 1000
call Delay
pop eax  
jmp LevelCompleteScreen

ContinueToNextLevel:
call play_click_sound

pop eax
mov dword ptr [careerTarget], eax
mov dword ptr [levelPassengers], 0
inc dword ptr [hurdlesToPlace]
inc dword ptr [other_car2place]
cmp dword ptr [npcMoveDelay], 500
jle SkipSpeedIncrease
sub dword ptr [npcMoveDelay], 50
SkipSpeedIncrease:
pop edx
pop eax
mov eax, 2  
ret

ReturnToMenu:
call play_click_sound
pop eax 
call savegame
call check_update_hs

pop edx
pop eax
mov eax, 3 
ret

CareerComplete:
call stop_sounds
call endgame_Sound
call Clrscr

mov dh, 10
mov dl, 25
call Gotoxy
mov eax, yellow
call SetTextColor
mov edx, OFFSET careerCompleteMsg
call WriteString
call Crlf
call Crlf

mov dh, 12
mov dl, 25
call Gotoxy
mov eax, lightGreen
call SetTextColor
mov edx, OFFSET scoreMsg
call WriteString
mov eax, dword ptr [playerScore]
call WriteInt
call Crlf
call Crlf

mov dh, 14
mov dl, 25
call Gotoxy
mov eax, white
call SetTextColor
mov edx, OFFSET pressKeyMsg
call WriteString
call ReadChar

call check_update_hs

pop edx
pop eax
mov eax, 3
ret

CareerNotComplete:
pop edx
pop eax
xor eax, eax  
ret
check_career_progress endp
;```
endless_coll proc
push edx
dec dword ptr [livesRemaining]
call disp_hud
cmp dword ptr [livesRemaining], 0
jle EndlessGameOver
mov eax, 200
call Delay

pop edx
xor eax, eax  
ret

EndlessGameOver:
call stop_sounds
call endgame_Sound
call Clrscr

mov dh, 10
mov dl, 30
call Gotoxy
mov eax, red
call SetTextColor
mov edx, OFFSET gameOverMsg
call WriteString
mov eax, dword ptr [playerScore]
call WriteInt
call Crlf
call Crlf

mov dh, 12
mov dl, 30
call Gotoxy
mov eax, white
call SetTextColor
mov edx, OFFSET pressKeyMsg
call WriteString
call ReadChar

call check_update_hs

pop edx
mov eax, 4 
ret
endless_coll endp

is_game_complete proc
push ebx
push ecx
push edx
push esi
xor esi, esi
xor ebx, ebx  

CountPassengers:
cmp esi, dword ptr [passengerCount]
jge CheckPassengersDone

mov eax, esi
shl eax, 2
mov ecx, passengerRows[eax]

cmp ecx, -1
je NextPassengerCheck
inc ebx 

NextPassengerCheck:
inc esi
jmp CountPassengers

CheckPassengersDone:

cmp ebx, 0
jne GameNotComplete

cmp dword ptr [passengerInTaxi], -1
jne GameNotComplete
xor esi, esi

ScanForCoins:
cmp esi, cells
jge NoCoinsLeft

movzx eax, byte ptr grid[esi]
cmp al, '$'
je GameNotComplete 
inc esi
jmp ScanForCoins

NoCoinsLeft:
call stop_sounds
call endgame_Sound
call Clrscr

mov dh, 10
mov dl, 25
call Gotoxy
mov eax, yellow
call SetTextColor
mov edx, OFFSET levelCompleteMsg
call WriteString
call Crlf
call Crlf

mov dh, 12
mov dl, 25
call Gotoxy
mov eax, lightGreen
call SetTextColor
mov edx, OFFSET scoreMsg
call WriteString
mov eax, dword ptr [playerScore]
call WriteInt
call Crlf
call Crlf

mov dh, 14
mov dl, 25
call Gotoxy
mov eax, white
call SetTextColor
mov edx, OFFSET pressKeyMsg
call WriteString
call ReadChar
call savegame
call check_update_hs

pop esi
pop edx
pop ecx
pop ebx
mov eax, 5  
ret

GameNotComplete:
pop esi
pop edx
pop ecx
pop ebx
xor eax, eax  
ret
is_game_complete endp

disp_time_rem proc
push eax
push ebx
push ecx
push edx
mov dh, 87         
mov dl, 0         
call Gotoxy
mov eax, yellow
call SetTextColor
mov edx, OFFSET timeMsg
call WriteString
mov eax, dword ptr [timeRemaining]
xor edx, edx
mov ebx, 60
div ebx

push edx 
cmp eax, 10
jge MinutesTwoDigits
push eax
mov al, '0'
call WriteChar
pop eax

MinutesTwoDigits:
call WriteDec
mov al, ':'
call WriteChar
pop eax  
cmp eax, 10
jge SecondsTwoDigits
push eax
mov al, '0'
call WriteChar
pop eax

SecondsTwoDigits:
call WriteDec
mov al, ' '
call WriteChar
call WriteChar
call WriteChar
call WriteChar

pop edx
pop ecx
pop ebx
pop eax
ret
disp_time_rem  endp

main PROC
call Randomize
mov edx, OFFSET clickSound
call OpenInputFile
cmp eax, INVALID_HANDLE_VALUE
je FileNotFound
call CloseFile
mov edx, OFFSET loadSuccessMsg
call WriteString
call Crlf
jmp FileTested

FileNotFound:
mov edx, OFFSET errorMsg3
call WriteString
call Crlf

FileTested:
call WaitMsg
call load_hs
call get_un
call BuildUserFilename

MenuLoop:
call ShowMenu
cmp eax, 5         
je ExitGameNow
cmp eax, 4         
je ShowInstructions
cmp eax, 3
je ShowLeaderboard
cmp eax, 2
je TryLoadGame
jmp StartNewGame

ShowInstructions:    
call disp_inst
jmp MenuLoop

ShowLeaderboard:
call disp_leaderboard
jmp MenuLoop

TryLoadGame:
call LoadGame
cmp eax, 0
je NoSaveFile

call Clrscr
mov dh, 10
mov dl, 30
call Gotoxy
mov edx, OFFSET loadSuccessMsg
call WriteString
mov eax, 1000
call Delay
jmp GameSetupDone
MenuLoopFromLoad:
jmp MenuLoop

NoSaveFile:
call Clrscr
mov dh, 10
mov dl, 30
call Gotoxy
mov edx, OFFSET noSaveMsg
call WriteString
mov eax, 1500
call Delay

StartNewGame:
mov dword ptr [passengerInTaxi], -1
mov dword ptr [playerScore], 0
mov dword ptr [passengerCount], 0
mov dword ptr [otherCarCount], 0
call SelectGameMode
cmp eax, 0
je MenuLoop  
call slct_taxicolor
mov eax, dword ptr [currentGameMode]
cmp eax, mode_std
je AskStandardDifficulty
cmp eax, mode_time
je AskTimeDifficulty
cmp eax, mode_career
je SetCareerDifficulty
cmp eax, mode_endless
je SetEndlessDifficulty
jmp AfterDifficultySetup

AskStandardDifficulty:
call slct_diff
jmp AfterDifficultySetup

AskTimeDifficulty:
call slct_time_diff
jmp AfterDifficultySetup

SetCareerDifficulty:
mov dword ptr [curr_diff], diff_easy
mov dword ptr [coinsToPlace], 8
mov dword ptr [minpass], 2
mov dword ptr [maxPassengers], 5
mov dword ptr [hurdlesToPlace], 2
mov dword ptr [treesToPlace], 1
mov dword ptr [other_car2place], 1
mov dword ptr [npcMoveDelay], 1500
jmp AfterDifficultySetup

SetEndlessDifficulty:
mov dword ptr [curr_diff], diff_std
mov dword ptr [coinsToPlace], 6
mov dword ptr [minpass], 2
mov dword ptr [maxPassengers], 5
mov dword ptr [hurdlesToPlace], 4
mov dword ptr [treesToPlace], 2
mov dword ptr [other_car2place], 2
mov dword ptr [npcMoveDelay], 1000

AfterDifficultySetup:

mov edx, OFFSET sent
call WriteString
call ReadChar
call Clrscr
mov dh, 0
mov dl, 0
call Gotoxy

RestartCareerLevel:
mov dword ptr [passengerInTaxi], -1
mov dword ptr [passengerCount], 0
mov dword ptr [otherCarCount], 0
mov dword ptr [psngr_dropped], 0 
mov ecx, max_psngr
xor esi, esi
InitPassArrays:
mov eax, esi
shl eax, 2
mov dword ptr passengerRows[eax], -1
mov dword ptr passengerCols[eax], -1
mov dword ptr passengerDestRows[eax], -1
mov dword ptr passengerDestCols[eax], -1
inc esi
loop InitPassArrays

mov ecx, cells
xor esi, esi
ClearLoop:
mov grid[esi], '.'
inc esi
loop ClearLoop

mov eax, cells
push edx
mov edx, 30
mul edx
pop edx
mov ebx, 100
xor edx, edx
div ebx
mov dword ptr [housesToPlace], eax

call place_houseblocks_2
mov dword ptr [playerRow], 0
mov dword ptr [playerCol], 0

cmp byte ptr grid[0], '.'
je PlayerPosOK
mov byte ptr grid[0], '.'
PlayerPosOK:
mov byte ptr grid[0], 'C'
mov eax, dword ptr [maxPassengers]
sub eax, dword ptr [minpass]
inc eax
mov ecx, eax
call get_rand_idx
add eax, dword ptr [minpass]
mov edi, eax

PlacePassengers:
cmp edi, 0
je CheckMinPassengers
cmp dword ptr [passengerCount], max_psngr
jge CheckMinPassengers

mov ecx, cells
call get_rand_idx
mov esi, eax
cmp grid[esi], '.'
jne PlacePassengers

xor edx, edx
mov eax, esi
mov ebx, cols
div ebx
mov ebx, eax
push edx

push edi
push ebx
push esi

xor esi, esi
CheckDistanceLoop:
cmp esi, dword ptr [passengerCount]
jge DistanceOK

mov eax, esi
shl eax, 2
mov edi, passengerRows[eax]

cmp edi, -1
je NextDistCheck

mov eax, ebx
sub eax, edi
jns RowPositive
neg eax
RowPositive:
push eax

mov eax, esi
shl eax, 2
mov edi, passengerCols[eax]
mov eax, [esp + 8]
sub eax, edi
jns ColPositive
neg eax
ColPositive:
pop ecx
add eax, ecx

cmp eax, 5
jl TooClose

NextDistCheck:
inc esi
jmp CheckDistanceLoop

TooClose:
pop esi
pop ebx
pop edi
pop edx
jmp PlacePassengers

DistanceOK:
pop esi
pop ebx
pop edi
pop edx
push edx

push edi
push ebx

mov edi, edx
call IsReachable

pop ebx
pop edi
pop edx

cmp eax, 0
je PlacePassengers

mov eax, ebx
push edx
push eax
mov edx, cols
mul edx
pop ecx
pop edx
add eax, edx
mov byte ptr grid[eax], 'P'

mov eax, dword ptr [passengerCount]
shl eax, 2
mov passengerRows[eax], ebx
mov passengerCols[eax], edx

FindPassDest:
push ebx
push ecx
push edi

FindDestLoop:
mov ecx, cells
call get_rand_idx
mov esi, eax

cmp grid[esi], '.'
jne FindDestLoop

xor edx, edx
mov eax, esi
mov ebx, cols
div ebx
mov ebx, eax

cmp ebx, [esp + 8]
jne CheckNotOtherPassenger
cmp edx, [esp + 4]
je FindDestLoop

CheckNotOtherPassenger:
push ebx
push edx
push edi

xor esi, esi
CheckPassengerLoop:
cmp esi, dword ptr [passengerCount]
jge CheckPassengerDone

mov eax, esi
shl eax, 2
mov edi, passengerRows[eax]

cmp edi, -1
je NextCheckPass

cmp ebx, edi
jne NextCheckPass
mov edi, passengerCols[eax]
cmp edx, edi
je DestOnPassenger

NextCheckPass:
inc esi
jmp CheckPassengerLoop

DestOnPassenger:
pop edi
pop edx
pop ebx
jmp FindDestLoop

CheckPassengerDone:
xor esi, esi
CheckDestLoop:
cmp esi, dword ptr [passengerCount]
jge CheckDestDone

mov eax, esi
shl eax, 2

mov edi, passengerDestRows[eax]
cmp ebx, edi
jne NextCheckDest
mov edi, passengerDestCols[eax]
cmp edx, edi
je DestOnDest

NextCheckDest:
inc esi
jmp CheckDestLoop

DestOnDest:
pop edi
pop edx
pop ebx
jmp FindDestLoop

CheckDestDone:
pop edi
pop edx
pop ebx

CheckDestReachable2:
push edi
push ebx
push edx

mov edi, edx
call IsReachable

pop edx
pop ebx
pop edi

cmp eax, 0
je FindDestLoop

DestOK:
pop edi
pop ecx
pop eax

mov eax, dword ptr [passengerCount]
shl eax, 2
mov passengerDestRows[eax], ebx
mov passengerDestCols[eax], edx

inc dword ptr [passengerCount]
dec edi
jmp PlacePassengers

CheckMinPassengers:
mov eax, dword ptr [minpass]
cmp dword ptr [passengerCount], eax
jge PassDone
mov edi, 1
jmp PlacePassengers

PassDone:
mov edi, dword ptr [coinsToPlace]
PlaceCoins:
cmp edi, 0
je CoinsDone
mov ecx, cells
call get_rand_idx
mov esi, eax
cmp grid[esi], '.'
jne PlaceCoins

xor edx, edx
mov ebx, cols
push eax
div ebx
mov ebx, eax
push edi
mov edi, edx
call IsReachable
pop edi
pop eax

cmp eax, 0
je PlaceCoins

mov byte ptr grid[esi], '$'
dec edi
jmp PlaceCoins
CoinsDone:
mov edi, dword ptr [hurdlesToPlace]
PlaceHurdles:
cmp edi, 0
je HurdlesDone
mov ecx, cells
call get_rand_idx
mov esi, eax
cmp grid[esi], '.'
jne PlaceHurdles
mov byte ptr grid[esi], 'X'
dec edi
jmp PlaceHurdles


HurdlesDone:
mov edi, dword ptr [treesToPlace]
PlaceTrees:
cmp edi, 0
je TreesDone
mov ecx, cells
call get_rand_idx
mov esi, eax
cmp grid[esi], '.'
jne PlaceTrees
mov byte ptr grid[esi], 'T'
dec edi
jmp PlaceTrees
TreesDone:
mov ecx, cells
call get_rand_idx
mov esi, eax
cmp grid[esi], '.'
jne RockSkip
mov byte ptr grid[esi], 'R'
RockSkip:

mov edi, dword ptr [other_car2place]

PlaceOtherCars:
cmp edi, 0
je OtherDone
cmp dword ptr [otherCarCount], max_other_cars
jge OtherDone

mov ecx, 200
TryPlaceOther:
cmp ecx, 0
je OtherDone
push ecx
push edi

mov ecx, cells
call get_rand_idx
mov esi, eax

cmp grid[esi], '.'
jne TryNextOther

xor edx, edx
mov ebx, cols
div ebx
mov ebx, eax
mov eax, edx
mov edi, eax

mov ecx, 4
TryDirection:
push ecx

mov eax, 4
sub eax, ecx
mov esi, eax

push ebx
push edi

call check_clear_path

pop edi
pop ebx

cmp eax, 0
jne FoundValidPath

pop ecx
loop TryDirection

jmp TryNextOther

FoundValidPath:
pop ecx

push eax
push edx
push ecx

mov eax, ebx
push edx
push eax
mov edx, cols
mul edx
pop ecx
pop edx
add eax, edi
mov byte ptr grid[eax], 'O'

mov eax, dword ptr [otherCarCount]
shl eax, 2

mov otherCarRows[eax], ebx
mov otherCarCols[eax], edi
mov otherCarDirs[eax], esi

mov otherCarStartRows[eax], ebx
mov otherCarStartCols[eax], edi

pop ecx
pop edx
pop eax

mov eax, dword ptr [otherCarCount]
shl eax, 2
mov otherCarEndRows[eax], edx
mov otherCarEndCols[eax], ecx

push eax
push ebx
push ecx
push edx
push edi

mov eax, dword ptr [otherCarCount]
shl eax, 2

mov ecx, numAvailableColors
push eax
call get_rand_idx
pop ecx

mov ebx, eax
shl ebx, 2
mov edx, availableColors[ebx]

mov otherCarColors[ecx], edx

pop edi
pop edx
pop ecx
pop ebx
pop eax

inc dword ptr [otherCarCount]
pop edi
pop ecx
dec edi
jmp PlaceOtherCars

TryNextOther:
pop edi
pop ecx
dec ecx
jmp TryPlaceOther

OtherDone:

GameSetupDone:
call GetMseconds
mov dword ptr [hhlb], eax
mov dword ptr [lastMoveTime], eax

cmp dword ptr [currentGameMode], mode_time
jne SkipTimerInit
mov dword ptr [last_timer_update], eax
SkipTimerInit:

call draw_fullgrid
call disp_hud
call play_bg_music

GameLoop:
cmp dword ptr [isPaused], 1
je PausedLoop

call GetMseconds
mov ebx, eax
sub ebx, dword ptr [lastMoveTime]
mov ecx, dword ptr [npcMoveDelay]
cmp ebx, ecx
jl SkipOtherMove

mov dword ptr [lastMoveTime], eax
call move_other_cars

SkipOtherMove:
call endless_coll
cmp eax, 5
je MenuLoop  

cmp dword ptr [currentGameMode], mode_time
jne SkipTimeUpdate
call UpdateTimeMode
SkipTimeUpdate:
cmp eax, 1
je MenuLoop

ContinueGame:
mov eax, 10
call Delay

call ReadKey
jz GameLoop

mov inputChar, al
cmp inputChar, 'p'
je TogglePause
cmp inputChar, 'P'
je TogglePause

cmp inputChar, 'x'
je ExitGame
cmp inputChar, 'c'
je SaveAndExit
cmp ah, 48h        
je MoveUp
cmp ah, 50h       
je MoveDown
cmp ah, 4Bh       
je MoveLeft
cmp ah, 4Dh        
je MoveRight

cmp inputChar, ' '
je HandleSpace
jmp GameLoop

TogglePause:
mov eax, dword ptr [isPaused]
xor eax, 1                   
mov dword ptr [isPaused], eax
call play_pause_sound  
cmp eax, 1
je ShowPause

call draw_fullgrid
call disp_Score
jmp GameLoop

ShowPause:
call show_pscreen
jmp GameLoop

PausedLoop:
mov eax, 50
call Delay

call ReadKey
jz PausedLoop

mov inputChar, al
cmp inputChar, 'p'
je TogglePause
cmp inputChar, 'P'
je TogglePause

cmp inputChar, 'c'
je SaveAndExit
cmp inputChar, 'C'
je SaveAndExit
jmp PausedLoop

SaveAndExit:
call stop_sounds   
call savegame
call check_update_hs
jmp MenuLoop

HandleSpace:
mov eax, dword ptr [passengerInTaxi]
cmp eax, -1
jne TryDropoff
call check_adj_psngr
cmp eax, -1
je GameLoop

mov dword ptr [passengerInTaxi], eax
call PickupPassenger
call play_pickup_sound
call disp_Score
jmp GameLoop

TryDropoff:
call DropoffPassenger
cmp eax, 2
je RestartCareerLevel 
cmp eax, 3
je MenuLoop
call disp_Score
jmp GameLoop

MoveUp:
call GetMseconds
mov ebx, eax
sub ebx, dword ptr [hhlb]
mov eax, dword ptr [playerColor]
cmp eax, red
je RedTaxiDelayUp
cmp ebx, 100
jl GameLoop
jmp UpdateMoveTimeUp

RedTaxiDelayUp:
cmp ebx, 500
jl GameLoop

UpdateMoveTimeUp:
call GetMseconds
mov dword ptr [hhlb], eax
cmp dword ptr [playerRow], 0
je GameLoop

mov eax, dword ptr [playerRow]
dec eax
push edx
push eax
mov edx, cols
mul edx
pop ecx
pop edx
add eax, dword ptr [playerCol]
mov bl, grid[eax]

cmp bl, '$'
je CollectCoinUp

cmp bl, '.'
je MoveUpOK

cmp bl, 'P'
je HitPersonUpBlocked

cmp bl, 'X'
je HitHurdleUpBlocked

cmp bl, 'T'
je HitTreeUpBlocked

cmp bl, 'O'
je HitOtherCarUpBlocked

cmp bl, 'H'
je HitHouseUpBlocked

cmp bl, 'R'
je HitRockUpBlocked

jmp GameLoop

CollectCoinUp:
add dword ptr [playerScore], 10
call play_sound_coin
call disp_Score
jmp MoveUpOK

HitPersonUpBlocked:
sub dword ptr [playerScore], 5
call play_crashsound  
call disp_hud
cmp dword ptr [currentGameMode], mode_endless
jne SkipEndlessPersonUp
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessPersonUp:
jmp GameLoop

HitHurdleUpBlocked:
mov eax, dword ptr [playerColor]
cmp eax, red
je RedHitHurdleUpBlocked
sub dword ptr [playerScore], 4
call play_crashsound 
jmp AfterHurdleHitUpBlocked
RedHitHurdleUpBlocked:
sub dword ptr [playerScore], 2
call play_crashsound 
AfterHurdleHitUpBlocked:
call disp_hud
cmp dword ptr [currentGameMode], mode_endless
jne SkipEndlessHurdle
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessHurdle:
jmp GameLoop

HitTreeUpBlocked:
mov eax, dword ptr [playerColor]
cmp eax, red
je RedHitTreeUpBlocked
sub dword ptr [playerScore], 4
call play_crashsound 
jmp AfterTreeHitUpBlocked
RedHitTreeUpBlocked:
sub dword ptr [playerScore], 2
call play_crashsound 
AfterTreeHitUpBlocked:
call disp_hud
cmp dword ptr [currentGameMode], mode_endless
jne SkipEndlessTreeUp
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessTreeUp:
jmp GameLoop

HitOtherCarUpBlocked:
mov eax, dword ptr [playerColor]
cmp eax, red
je RedHitCarUpBlocked
sub dword ptr [playerScore], 2
call play_crashsound 
jmp AfterCarHitUpBlocked
RedHitCarUpBlocked:
sub dword ptr [playerScore], 3
call play_crashsound 
AfterCarHitUpBlocked:
call disp_hud
cmp dword ptr [currentGameMode], mode_endless
jne SkipEndlessCarUp
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessCarUp:
jmp GameLoop

HitHouseUpBlocked:
sub dword ptr [playerScore], 3
call play_crashsound 
call disp_hud
cmp dword ptr [currentGameMode], mode_endless
jne SkipEndlessHouseUp
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessHouseUp:
jmp GameLoop

HitRockUpBlocked:
sub dword ptr [playerScore], 2
call play_crashsound 
call disp_hud
cmp dword ptr [currentGameMode], mode_endless
jne SkipEndlessRockUp
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessRockUp:
jmp GameLoop

MoveUpOK:
mov eax, dword ptr [playerRow]
mov dword ptr [oldRow], eax
mov eax, dword ptr [playerCol]
mov dword ptr [oldCol], eax

call update_player
dec dword ptr [playerRow]
call draw_player
jmp GameLoop

MoveDown:
call GetMseconds
mov ebx, eax
sub ebx, dword ptr [hhlb]

mov eax, dword ptr [playerColor]
cmp eax, red
je RedTaxiDelayDown

cmp ebx, 100
jl GameLoop
jmp UpdateMoveTimeDown

RedTaxiDelayDown:
cmp ebx, 500
jl GameLoop

UpdateMoveTimeDown:
call GetMseconds
mov dword ptr [hhlb], eax

mov eax, dword ptr [playerRow]
cmp eax, rows - 1
jge GameLoop

mov eax, dword ptr [playerRow]
inc eax
push edx
push eax
mov edx, cols
mul edx
pop ecx
pop edx
add eax, dword ptr [playerCol]
mov bl, grid[eax]

cmp bl, '$'
je CollectCoinDown

cmp bl, '.'
je MoveDownOK

cmp bl, 'P'
je HitPersonDownBlocked

cmp bl, 'X'
je HitHurdleDownBlocked

cmp bl, 'T'
je HitTreeDownBlocked

cmp bl, 'O'
je HitOtherCarDownBlocked

cmp bl, 'H'
je HitHouseDownBlocked

cmp bl, 'R'
je HitRockDownBlocked

jmp GameLoop

CollectCoinDown:
add dword ptr [playerScore], 10
call play_sound_coin
call disp_Score
jmp MoveDownOK

HitPersonDownBlocked:
sub dword ptr [playerScore], 5
call play_crashsound  
call disp_hud
cmp dword ptr [currentGameMode], mode_endless
jne SkipEndlessPersonDown
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessPersonDown:
jmp GameLoop

HitHurdleDownBlocked:
mov eax, dword ptr [playerColor]
cmp eax, red
je RedHitHurdleDownBlocked
sub dword ptr [playerScore], 4
call play_crashsound  
jmp AfterHurdleHitDownBlocked
RedHitHurdleDownBlocked:
sub dword ptr [playerScore], 2
call play_crashsound  
AfterHurdleHitDownBlocked:
call disp_hud
cmp dword ptr [currentGameMode], mode_endless
jne SkipEndlessHurdleDown
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessHurdleDown:
jmp GameLoop

HitTreeDownBlocked:
mov eax, dword ptr [playerColor]
cmp eax, red
je RedHitTreeDownBlocked
sub dword ptr [playerScore], 4
call play_crashsound  
jmp AfterTreeHitDownBlocked
RedHitTreeDownBlocked:
sub dword ptr [playerScore], 2
call play_crashsound  
AfterTreeHitDownBlocked:
call disp_hud
cmp dword ptr [currentGameMode], mode_endless
jne SkipEndlessTreeDown
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessTreeDown:
jmp GameLoop

HitOtherCarDownBlocked:
mov eax, dword ptr [playerColor]
cmp eax, red
je RedHitCarDownBlocked
sub dword ptr [playerScore], 2
call play_crashsound  
jmp AfterCarHitDownBlocked
RedHitCarDownBlocked:
sub dword ptr [playerScore], 3
call play_crashsound  
AfterCarHitDownBlocked:
call disp_hud
cmp dword ptr [currentGameMode], mode_endless
jne SkipEndlessCarDown
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessCarDown:
jmp GameLoop

HitHouseDownBlocked:
sub dword ptr [playerScore], 3
call play_crashsound  
call disp_hud
cmp dword ptr [currentGameMode], mode_endless
jne SkipEndlessHouseDown
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessHouseDown:
jmp GameLoop

HitRockDownBlocked:
sub dword ptr [playerScore], 2
call play_crashsound  
call disp_hud
cmp dword ptr [currentGameMode], mode_endless
jne SkipEndlessRockDown
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessRockDown:
jmp GameLoop

MoveDownOK:
mov eax, dword ptr [playerRow]
mov dword ptr [oldRow], eax
mov eax, dword ptr [playerCol]
mov dword ptr [oldCol], eax

call update_player
inc dword ptr [playerRow]
call draw_player
jmp GameLoop

MoveLeft:
call GetMseconds
mov ebx, eax
sub ebx, dword ptr [hhlb]

mov eax, dword ptr [playerColor]
cmp eax, red
je RedTaxiDelayLeft

cmp ebx, 100
jl GameLoop
jmp UpdateMoveTimeLeft

RedTaxiDelayLeft:
cmp ebx, 500
jl GameLoop

UpdateMoveTimeLeft:
call GetMseconds
mov dword ptr [hhlb], eax

cmp dword ptr [playerCol], 0
je GameLoop

mov eax, dword ptr [playerRow]
push edx
push eax
mov edx, cols
mul edx
pop ecx

pop edx
add eax, dword ptr [playerCol]
dec eax
mov bl, grid[eax]

cmp bl, '$'
je CollectCoinLeft

cmp bl, '.'
je MoveLeftOK

cmp bl, 'P'
je HitPersonLeftBlocked
cmp bl, 'X'
je HitHurdleLeftBlocked
cmp bl, 'T'
je HitTreeLeftBlocked
cmp bl, 'O'
je HitOtherCarLeftBlocked
cmp bl, 'H'
je hhlb
cmp bl, 'R'
je HitRockLeftBlocked
jmp GameLoop

CollectCoinLeft:
add dword ptr [playerScore], 10
call play_sound_coin
call disp_Score
jmp MoveLeftOK

HitPersonLeftBlocked:
sub dword ptr [playerScore], 5
call play_crashsound  
call disp_hud
cmp dword ptr [currentGameMode], mode_endless
jne SkipEndlessPersonLeft
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessPersonLeft:
jmp GameLoop

HitHurdleLeftBlocked:
mov eax, dword ptr [playerColor]
cmp eax, red
je RedHitHurdleLeftBlocked
sub dword ptr [playerScore], 4
call play_crashsound  
jmp AfterHurdleHitLeftBlocked
RedHitHurdleLeftBlocked:
sub dword ptr [playerScore], 2
call play_crashsound  
AfterHurdleHitLeftBlocked:
call disp_hud
cmp dword ptr [currentGameMode], mode_endless
jne SkipEndlessHurdleLeft
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessHurdleLeft:
jmp GameLoop

HitTreeLeftBlocked:
mov eax, dword ptr [playerColor]
cmp eax, red
je RedHitTreeLeftBlocked
sub dword ptr [playerScore], 4
call play_crashsound  
jmp AfterTreeHitLeftBlocked
RedHitTreeLeftBlocked:
sub dword ptr [playerScore], 2
call play_crashsound  
AfterTreeHitLeftBlocked:
call disp_hud
cmp dword ptr [currentGameMode] , mode_endless
jne SkipEndlessTreeLeft
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessTreeLeft:
jmp GameLoop

HitOtherCarLeftBlocked:
mov eax, dword ptr [playerColor]
cmp eax, red
je RedHitCarLeftBlocked
sub dword ptr [playerScore], 2
call play_crashsound  
jmp AfterCarHitLeftBlocked
RedHitCarLeftBlocked:
sub dword ptr [playerScore], 3
call play_crashsound  
AfterCarHitLeftBlocked:
call disp_hud
cmp dword ptr [currentGameMode] , mode_endless
jne SkipEndlessCarLeft
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessCarLeft:
jmp GameLoop
hhlb:
sub dword ptr [playerScore], 3
call play_crashsound  
call disp_hud

cmp dword ptr [currentGameMode] ,mode_endless
jne SkipEndlessHouseLeft
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessHouseLeft:
jmp GameLoop

HitRockLeftBlocked:
sub dword ptr [playerScore], 2
call play_crashsound  
call disp_hud
cmp dword ptr [currentGameMode], mode_endless
jne SkipEndlessRockLeft
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessRockLeft:
jmp GameLoop

MoveLeftOK:
mov eax, dword ptr [playerRow]
mov dword ptr [oldRow], eax
mov eax, dword ptr [playerCol]
mov dword ptr [oldCol], eax

call update_player
dec dword ptr [playerCol]
call draw_player
jmp GameLoop

MoveRight:
call GetMseconds
mov ebx, eax
sub ebx, dword ptr [lpmt]

mov eax, dword ptr [playerColor]
cmp eax, red
je RedTaxiDelayRight

cmp ebx, 100
jl GameLoop
jmp UpdateMoveTimeRight

RedTaxiDelayRight:
cmp ebx, 500
jl GameLoop

UpdateMoveTimeRight:
call GetMseconds
mov dword ptr [hhlb], eax

mov eax, dword ptr [playerCol]
cmp eax, cols - 1
jge GameLoop

mov eax, dword ptr [playerRow]
push edx
push eax
mov edx, cols
mul edx
pop ecx
pop edx
add eax, dword ptr [playerCol]
inc eax
mov bl, grid[eax]

cmp bl, '$'
je CollectCoinRight

cmp bl, '.'
je MoveRightOK

cmp bl, 'P'
je HitPersonRightBlocked

cmp bl, 'X'
je HitHurdleRightBlocked

cmp bl, 'T'
je HitTreeRightBlocked

cmp bl, 'O'
je HitOtherCarRightBlocked

cmp bl, 'H'
je HitHouseRightBlocked

cmp bl, 'R'
je HitRockRightBlocked

jmp GameLoop

CollectCoinRight:
add dword ptr [playerScore], 10
call play_sound_coin
call disp_Score
jmp MoveRightOK

HitPersonRightBlocked:
sub dword ptr [playerScore], 5
call play_crashsound  
call disp_hud
cmp dword ptr [currentGameMode] ,mode_endless
jne SkipEndlessPersonRight
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessPersonRight:
jmp GameLoop

HitHurdleRightBlocked:
mov eax, dword ptr [playerColor]
cmp eax, red
je RedHitHurdleRightBlocked
sub dword ptr [playerScore], 4
call play_crashsound  
jmp AfterHurdleHitRightBlocked
RedHitHurdleRightBlocked:
sub dword ptr [playerScore], 2
call play_crashsound  
AfterHurdleHitRightBlocked:
call disp_hud
cmp dword ptr [currentGameMode] ,mode_endless
jne SkipEndlessHurdleRight
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessHurdleRight:
jmp GameLoop

HitTreeRightBlocked:
mov eax, dword ptr [playerColor]
cmp eax, red
je RedHitTreeRightBlocked
sub dword ptr [playerScore], 4
call play_crashsound
jmp AfterTreeHitRightBlocked
RedHitTreeRightBlocked:
sub dword ptr [playerScore], 2
call play_crashsound
AfterTreeHitRightBlocked:
call disp_hud
cmp dword ptr [currentGameMode] ,mode_endless
jne SkipEndlessTreeRight
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessTreeRight:
jmp GameLoop

HitOtherCarRightBlocked:
mov eax, dword ptr [playerColor]
cmp eax, red
je RedHitCarRightBlocked
sub dword ptr [playerScore], 2
call play_crashsound  
jmp AfterCarHitRightBlocked
RedHitCarRightBlocked:
sub dword ptr [playerScore], 3
call play_crashsound  
AfterCarHitRightBlocked:
call disp_hud
cmp dword ptr [currentGameMode], mode_endless
jne SkipEndlessCarRight
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessCarRight:
jmp GameLoop

HitHouseRightBlocked:
sub dword ptr [playerScore], 3
call play_crashsound  
call disp_hud
cmp dword ptr [currentGameMode], mode_endless
jne SkipEndlessHouseRight
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessHouseRight:
jmp GameLoop

HitRockRightBlocked:
sub dword ptr [playerScore], 2
call play_crashsound  
call disp_hud
cmp dword ptr [currentGameMode], mode_endless
jne SkipEndlessRockRight
call endless_coll
cmp eax, 4
je MenuLoop
SkipEndlessRockRight:
jmp GameLoop

MoveRightOK:
mov eax, dword ptr [playerRow]
mov dword ptr [oldRow], eax
mov eax, dword ptr [playerCol]
mov dword ptr [oldCol], eax

call update_player
inc dword ptr [playerCol]
call draw_player
jmp GameLoop

ExitGame:
call stop_sounds      
call endgame_Sound  
call check_update_hs
jmp MenuLoop

ExitGameNow:
exit
main endp

END main


