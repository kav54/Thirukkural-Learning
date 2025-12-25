# Product Requirements Document (PRD)
# திருக்குறள் கற்றல் - Thirukkural Learning App for Children

## 1. EXECUTIVE SUMMARY

### Product Vision
Create an engaging, gamified mobile application to teach Tamil children (ages 6-14) the timeless wisdom of Thirukkural through daily lessons, interactive games, and social features.

### Key Objectives
- Make 1,330 Thirukkurals accessible and understandable for children
- Build daily learning habits through gamification
- Preserve and promote Tamil literary heritage
- Enable family participation through sharing features

### Success Metrics
- Daily Active Users (DAU): 10,000+ children
- 30-day retention rate: >60%
- Average session duration: 10+ minutes
- Completion rate per kural: >80%
- Parent satisfaction score: 4.5+/5

---

## 2. USER PERSONAS

### Primary User: Little Learner (Age 6-10)
- **Name**: Priya, 8 years old, Chennai
- **Context**: Grade 3 student, basic Tamil reading skills
- **Goals**: Have fun while learning, collect rewards, share with friends
- **Pain Points**: Complex classical Tamil, lack of visual aids, boring textbooks

### Secondary User: Young Scholar (Age 11-14)
- **Name**: Karthik, 12 years old, Coimbatore
- **Context**: Grade 7 student, good Tamil proficiency
- **Goals**: Excel in Tamil exams, understand deeper meanings, compete with peers
- **Pain Points**: Need modern context, want gamification, social validation

### Tertiary User: Parent/Guardian
- **Name**: Mrs. Lakshmi, 38 years old
- **Goals**: Children learn Tamil culture, track progress, share achievements
- **Pain Points**: Limited time to teach, need engaging content, progress visibility

---

## 3. INFORMATION ARCHITECTURE

```
App Root
├── Onboarding (First Time)
│   ├── Authentication
│   └── Parent Connect
│
├── Home Dashboard
│   ├── Kural of the Day Widget
│   ├── Streak Counter
│   ├── Quick Actions
│   └── Progress Summary
│
├── Daily Kural
│   ├── Kural Display
│   ├── Audio Player
│   ├── Explanations
│   ├── Visual Story
│   ├── Chapter Link
│   └── Share Options
│
├── All Kurals Library
│   ├── Themes (3 main)
│   ├── Chapters (133)
│   ├── Kurals (1330)
│   ├── Search
│   └── Bookmarks
│
├── Games & Quiz
│   ├── Daily Challenge
│   ├── Word Games
│   ├── Quiz Types
│   └── Leaderboard
│
├── Profile & Progress
│   ├── Avatar & Stats
│   ├── Achievements
│   ├── Learning History
│   └── Settings
│
└── Parent Portal
    ├── Progress Reports
    ├── Time Controls
    └── Content Settings
```

---

## 4. DETAILED SCREEN SPECIFICATIONS

### SCREEN 1: Splash Screen
**Purpose**: Brand introduction and loading
**Duration**: 2-3 seconds

**Visual Elements**:
- Gradient background: Purple to Pink to Yellow (sunrise theme)
- App logo: Playful Tamil typography "திருக்குறள் கற்றல்"
- Animated mascot: Friendly owl with Tamil book
- Loading indicator: Playful dots or Tamil letters

**Prompt for AI**:
"Create a splash screen with gradient background (purple to pink to yellow), centered app logo in Tamil 'திருக்குறள் கற்றல்' with playful rounded font, animated owl mascot holding a book, subtle loading dots at bottom"

---

### SCREEN 2: Authentication
**Purpose**: Secure user login and progress syncing

**Visual Elements**:
- App Logo centered at the top
- Title: "தொடங்க உள்நுழையவும்" (Sign in to start)
- Subtitle: "Save your progress and achievements"
- Authentication Button:
  - "Continue with Google" button (Google G logo)

**Content**:
```
Title: உங்களை வரவேற்கிறோம்!
Subtitle: Login to track your learning journey
Button: Google
```

**Prompt for AI**:
"Design a clean authentication screen with the app logo at the top, a distinct 'Continue with Google' button with official branding colors/icons. Background should be consistent with the app theme (light gradient)."

---

### SCREEN 3: Home Dashboard
**Purpose**: Central hub for all features

**Layout Sections**:
1. **Header** (Fixed):
   - Avatar + Name
   - Streak counter 🔥
   - Coins/Points
   - Settings icon

2. **Kural of the Day Card** (Hero):
   - Kural number and text
   - Attractive illustration
   - "Start Learning" button
   - Progress indicator

3. **Quick Actions Grid**:
   - 📚 All Kurals
   - 🎮 Play Games
   - 🏆 Leaderboard
   - 👨‍👩‍👧 Share

4. **Daily Progress**:
   - Today's activities
   - Mini achievements
   - Time spent

5. **Bottom Navigation**:
   - Home
   - Library
   - Games
   - Profile

**Prompt for AI**:
"Design a child-friendly dashboard with header showing avatar and streak, large kural-of-day card with illustration, 2x2 quick actions grid with icons, progress section, bottom navigation with 4 tabs"

---

### SCREEN 4: Kural of the Day - Main View
**Purpose**: Present daily kural in engaging format

**Visual Structure**:
```
┌─────────────────────────┐
│     Day 1 | குறள் #1    │
├─────────────────────────┤
│                         │
│    [Animated Visual]    │
│    [showing concept]    │
│                         │
├─────────────────────────┤
│   அகர முதல எழுத்தெல்லாம்    │
│   ஆதி பகவன் முதற்றே உலகு   │
├─────────────────────────┤
│   [🔊 Play] [Speed ▼]   │
├─────────────────────────┤
│  [Tamil] [English] tabs │
└─────────────────────────┘
```

**Interactive Elements**:
- Swipe up for explanation
- Tap speaker for audio
- Toggle language
- Share button
- Bookmark option

**Prompt for AI**:
"Create kural display screen with day/number header, central animated illustration area, Tamil text in large readable font, audio controls, language toggle tabs, swipe-up indicator for more content"

---

### SCREEN 5: Kural Explanation View
**Purpose**: Provide detailed understanding

**Content Sections**:
1. **Simple Meaning**:
   - Icon: 💡
   - Child-friendly explanation
   - Visual metaphor

2. **Story Time**:
   - Icon: 📖
   - 2-3 panel comic strip
   - Relatable modern context

3. **Fun Facts**:
   - Icon: 🌟
   - Interesting trivia
   - Historical context

4. **Practice**:
   - Icon: ✏️
   - Quick quiz question
   - Drawing prompt

5. **Chapter Info**:
   - Athikaram name
   - Position in chapter
   - "Explore Chapter" button

**Prompt for AI**:
"Design scrollable explanation screen with sections: simple meaning with lightbulb icon, comic strip story (3 panels), fun facts bubble, practice activity, chapter info card with navigation"

---

### SCREEN 6: All Kurals Library
**Purpose**: Browse and search all 1330 kurals

**Navigation Structure**:
```
Level 1: Three Themes
├── அறத்துப்பால் (Virtue) - 38 chapters
├── பொருட்பால் (Wealth) - 70 chapters
└── காமத்துப்பால் (Love) - 25 chapters

Level 2: Chapters (Athikaram)
└── Grid of chapter cards with icons

Level 3: Kurals List
└── Numbered list with previews
```

**Visual Design**:
- Themed colors for each section
- Progress indicators per chapter
- Search bar with filters
- Bookmark indicators

**Prompt for AI**:
"Create library screen with 3 main theme cards (different colors), search bar at top, filter chips (completed/bookmarked/all), expandable chapter accordion, visual progress bars"

---

### SCREEN 7: Quiz Selection
**Purpose**: Choose quiz type for daily challenge

**Quiz Types Grid**:
1. **சொல் விளையாட்டு** (Word Game)
   - Icon: Letter blocks
   - Wordle-style game
   - Guess the missing word

2. **நிரப்புக** (Fill in Blanks)
   - Icon: Pencil filling gap
   - Complete the kural
   - Drag and drop words

3. **தேர்வு செய்** (Multiple Choice)
   - Icon: Checkbox list
   - Choose correct meaning
   - 4 options per question

4. **பொருத்துக** (Match the Following)
   - Icon: Connecting lines
   - Match kurals to meanings
   - Drag to connect

**Daily Challenge Badge**:
- "Today: 0/3 completed"
- Streak indicator
- Reward preview

**Prompt for AI**:
"Design quiz selection with 2x2 grid of quiz type cards, each with colorful icon and Tamil/English name, daily challenge progress bar at top, streak counter, start button for each type"

---

### SCREEN 8: Quiz Gameplay - Wordle Type
**Purpose**: Guess the word from kural

**Game Elements**:
- 5x5 Tamil letter grid
- Keyboard with Tamil letters
- Hints button (uses coins)
- Timer (optional)
- Lives/attempts counter

**Color Coding**:
- Green: Correct letter, correct position
- Yellow: Correct letter, wrong position
- Gray: Letter not in word

**Prompt for AI**:
"Create Tamil wordle game screen with 5x5 letter grid, Tamil keyboard at bottom, color-coded feedback (green/yellow/gray), hints button, attempts counter (3 hearts), score display"

---

### SCREEN 9: Quiz Result
**Purpose**: Show performance and rewards

**Result Display**:
```
┌─────────────────────────┐
│      🏆 அருமை!           │
│     Quiz Complete!      │
├─────────────────────────┤
│   Score: 3/3 ⭐⭐⭐      │
│   Time: 2:45            │
│   Streak: 🔥 5 days     │
├─────────────────────────┤
│   Rewards Earned:       │
│   +50 coins             │
│   +1 streak day         │
│   "Quick Learner" badge │
├─────────────────────────┤
│ [Share] [Play Again]    │
│    [Back to Home]       │
└─────────────────────────┘
```

**Animations**:
- Confetti for perfect score
- Coin collection animation
- Streak fire effect

**Prompt for AI**:
"Design quiz result screen with trophy emoji, score display with stars, time taken, streak counter with fire emoji, rewards section with coins and badges, action buttons for share/replay/home"

---

### SCREEN 10: Social Sharing
**Purpose**: Share achievements with family/friends

**Share Options**:
1. **WhatsApp Status**:
   - Kural card design
   - Achievement overlay
   - App branding

2. **Instagram Story**:
   - Vertical format
   - Animated elements
   - Hashtags

3. **Download Image**:
   - High-quality card
   - Customizable background

**Share Card Template**:
```
┌─────────────────────────┐
│   [App Logo]            │
│                         │
│   Today I learned:      │
│   குறள் #234            │
│   [Kural text]          │
│   [Simple meaning]      │
│                         │
│   🔥 5 day streak!      │
│   Join me on [App]      │
└─────────────────────────┘
```

**Prompt for AI**:
"Create share screen with preview of shareable card (gradient background, kural text, achievement badges), share platform buttons (WhatsApp, Instagram, Download), customize options (background, add name)"

---

### SCREEN 11: Profile & Progress
**Purpose**: Track learning journey

**Profile Sections**:
1. **Avatar & Stats**:
   - Editable avatar
   - Name and age
   - Total kurals learned
   - Current streak

2. **Achievements Grid**:
   - Badges earned
   - Locked achievements (grayed)
   - Progress to next badge

3. **Learning Calendar**:
   - Month view
   - Green dots for active days
   - Streak highlights

4. **Statistics**:
   - Favorite chapter
   - Best quiz score
   - Total time spent
   - Kurals bookmarked

**Prompt for AI**:
"Design profile screen with avatar at top, stats cards (kurals learned, streak, coins), achievement badges in grid (earned/locked), calendar heatmap showing activity, statistics cards"

---

### SCREEN 12: Parent Dashboard
**Purpose**: Parent monitoring and control

**Dashboard Widgets**:
1. **Child Progress**:
   - Daily/weekly summary
   - Kurals completed
   - Quiz performance

2. **Screen Time**:
   - Daily usage graph
   - Set time limits
   - Bedtime controls

3. **Content Settings**:
   - Age-appropriate filtering
   - Notification preferences
   - Sharing permissions

4. **Reports**:
   - Weekly email option
   - PDF progress report
   - Share with teachers

**Prompt for AI**:
"Create parent dashboard with child selection dropdown, progress summary cards, screen time graph with controls, content settings toggles, report generation button, clean professional design"

---

## 5. DESIGN SYSTEM SPECIFICATIONS

### Color Palette
```
Primary Colors:
- Purple (Primary): #8B5CF6
- Pink (Secondary): #EC4899
- Yellow (Accent): #F59E0B

Semantic Colors:
- Success Green: #10B981
- Error Red: #EF4444
- Info Blue: #3B82F6
- Warning Yellow: #F59E0B

Background Gradients:
- Sunrise: linear-gradient(135deg, #667eea 0%, #764ba2 100%)
- Sunset: linear-gradient(135deg, #f093fb 0%, #f5576c 100%)
- Sky: linear-gradient(135deg, #667eea 0%, #764ba2 100%)
```

### Typography
```
Tamil Font:
- Headers: Catamaran Bold
- Body: Mukta Regular
- Kurals: Arima Madurai

English Font:
- Headers: Quicksand Bold
- Body: Open Sans Regular

Font Sizes:
- H1: 28px
- H2: 22px
- H3: 18px
- Body: 16px
- Small: 14px
- Tiny: 12px
```

### Component Library
```
Buttons:
- Primary: Gradient background, rounded-full
- Secondary: Outline, rounded-lg
- Icon: Circle, shadow

Cards:
- Elevated: shadow-xl, rounded-2xl
- Flat: border, rounded-xl
- Interactive: hover:scale-105

Input Fields:
- Text: rounded-lg, border-2
- Search: icon-left, rounded-full

Badges:
- Achievement: gold gradient
- Streak: fire emoji + number
- Progress: percentage fill
```

### Animation Guidelines
```
Transitions:
- Duration: 200-300ms
- Easing: ease-in-out
- Scale: 1.05 on hover

Micro-animations:
- Button press: scale(0.95)
- Card entry: fadeInUp
- Success: bounce + confetti
- Loading: pulse or spin

Page Transitions:
- Push: slideInRight
- Pop: slideInLeft
- Modal: fadeIn + scaleUp
```

---

## 6. TECHNICAL SPECIFICATIONS

### Platform Requirements
```
iOS:
- Minimum: iOS 12.0
- Recommended: iOS 15.0+
- Device: iPhone 6s and above

Android:
- Minimum: Android 6.0 (API 23)
- Recommended: Android 10+ (API 29)
- Device: 2GB RAM minimum
```

### Data Storage
```
Local Storage:
- User preferences
- Progress data
- Cached kurals
- Offline audio

Cloud Sync:
- User profile
- Achievements
- Streak data
- Bookmarks
```

### API Endpoints
```
GET /api/kural/daily
GET /api/kural/{id}
GET /api/chapters
GET /api/quiz/daily
POST /api/progress
POST /api/achievements
GET /api/leaderboard
POST /api/share
```

### Offline Capabilities
- Download kurals for offline reading
- Cache last 7 days of content
- Store quiz questions locally
- Sync when connection restored

---

## 7. GAMIFICATION MECHANICS

### Point System
```
Actions & Points:
- Daily login: 10 points
- Complete kural reading: 20 points
- Listen to audio: 5 points
- Complete quiz: 30 points
- Perfect quiz score: 50 points
- Share achievement: 10 points
- 7-day streak: 100 bonus
```

### Achievement Badges
```
Learning Milestones:
- First Kural: "பயணம் தொடங்கியது"
- 10 Kurals: "கற்றல் நண்பன்"
- 50 Kurals: "அறிவு தேடி"
- 100 Kurals: "நூற்றுவர்"
- 365 Kurals: "ஆண்டு சாதனையாளர்"
- 1330 Kurals: "திருக்குறள் மேதை"

Streak Badges:
- 3 days: "Fire Starter"
- 7 days: "Week Warrior"
- 30 days: "Month Master"
- 100 days: "Century Champion"
- 365 days: "Year Legend"

Quiz Master:
- 10 perfect scores
- 50 quizzes completed
- Speed demon (under 1 min)
```

### Leaderboard
```
Categories:
- Daily Top 10
- Weekly Champions
- Monthly Leaders
- All-time Legends

Display:
- Rank
- Avatar
- Name
- Points
- Streak
```

---

## 8. LOCALIZATION

### Supported Languages
1. Tamil (Primary)
2. English (Secondary)
3. Tamil + English (Mixed mode)

### Translatable Content
- UI text
- Kural meanings
- Instructions
- Achievement names
- Push notifications

### Cultural Considerations
- Tamil calendar dates
- Festival special kurals
- Regional pronunciation options
- Cultural context in examples

---

## 9. ACCESSIBILITY

### Visual Accessibility
- High contrast mode
- Font size adjustment (3 levels)
- Color blind friendly palette
- Clear icon + text labels

### Audio Accessibility
- Speed control for narration
- Repeat option
- Male/Female voice options
- Background music toggle

### Motor Accessibility
- Large touch targets (44x44 minimum)
- Gesture alternatives
- One-handed operation
- Simplified navigation option

---

## 10. PROMPT TEMPLATES FOR SCREEN GENERATION

### Template Structure for Gemini 3
```
Create a mobile app screen for [Screen Name] with the following specifications:

PURPOSE: [Main goal of the screen]

LAYOUT:
- [Section 1 description with position]
- [Section 2 description with position]
- [Interactive elements]

VISUAL STYLE:
- Color scheme: [Specific colors]
- Typography: [Font specifications]
- Spacing: [Padding/margins]
- Shadows: [Elevation details]

COMPONENTS:
- [Component 1]: [Details]
- [Component 2]: [Details]

CONTENT:
- [Actual text to display]
- [Placeholder indicators]

INTERACTIONS:
- [Gesture/tap behaviors]
- [Animations]

DEVICE: iPhone 13 / Android equivalent
ORIENTATION: Portrait
THEME: Child-friendly, Tamil culture
```

### Example Prompt for Gemini 3
```
"Create a mobile app screen for 'Thirukkural Daily Kural Display' with:

PURPOSE: Show today's kural in an engaging way for children aged 6-14

LAYOUT:
- Top bar: Day counter, kural number, bookmark icon
- Hero section: Large illustrated card with kural text
- Audio controls: Play button, speed selector
- Bottom tabs: Tamil/English toggle

VISUAL STYLE:
- Gradient background: Purple (#8B5CF6) to Pink (#EC4899)
- Card: White with 20px rounded corners, shadow-xl
- Tamil text: Arima Madurai font, 24px, dark purple
- Spacing: 16px padding, 24px between sections

COMPONENTS:
- Illustration: Animated character demonstrating kural concept
- Audio player: Circular play button with progress ring
- Language toggle: Segmented control with sliding indicator
- Share button: Floating action button, bottom-right

INTERACTIONS:
- Swipe up: Reveal explanation
- Tap illustration: Animate
- Hold bookmark: Add to favorites with haptic feedback

Generate a high-fidelity mobile screen design following these specifications."
```

---

## 11. SUCCESS METRICS & KPIs

### Engagement Metrics
- Daily Active Users (DAU)
- Monthly Active Users (MAU)
- Session duration
- Sessions per day
- Screen flow completion

### Learning Metrics
- Kurals read per user
- Quiz completion rate
- Average quiz score
- Streak maintenance rate
- Chapter completion rate

### Retention Metrics
- D1, D7, D30 retention
- Churn rate
- Resurrection rate
- Feature adoption rate

### Social Metrics
- Shares per user
- Referral rate
- Parent engagement
- Community participation

---

## 12. LAUNCH STRATEGY

### Phase 1: MVP (Month 1-2)
- Core screens: Home, Daily Kural, Basic Quiz
- 100 kurals with explanations
- Basic gamification
- Tamil language only

### Phase 2: Enhancement (Month 3-4)
- All 1330 kurals
- All quiz types
- English translations
- Social sharing
- Streak system

### Phase 3: Scale (Month 5-6)
- Parent portal
- Leaderboards
- Advanced animations
- Voice narration
- Offline mode

---

## 13. APPENDIX

### Sample Kurals for Development
```
Kural 1:
அகர முதல எழுத்தெல்லாம் ஆதி
பகவன் முதற்றே உலகு

Kural 2:
கற்றதனால் ஆய பயன்கொல் வாலறிவன்
நற்றாள் தொழாஅர் எனின்

Kural 3:
மலர்மிசை ஏகினான் மாணடி சேர்ந்தார்
நிலமிசை நீடுவாழ் வார்
```

### Resource Links
- Tamil Unicode: https://unicode.org/charts/PDF/U0B80.pdf
- Font Resources: Google Fonts Tamil
- Audio Libraries: Tamil TTS APIs
- Cultural References: Tamil Virtual Academy

---

## END OF PRD

This document serves as a comprehensive guide for generating screens and building the Thirukkural learning app for children. Each screen specification can be used as a standalone prompt for AI-based design generation tools like Gemini 3.