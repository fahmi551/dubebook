# UX Documentation

## 1. Mobile UX Context Analysis

### 1.1 Physical Context
- **Outdoor Usage & Bright Sunlight**: The app uses a high-contrast theme (`AppTheme.primaryBlue` which is `0xFF1010A0`, and white `0xFFFFFFFF` background) to maintain legibility under harsh sunlight typical in street-facing shops.
- **Dark Mode Usage**: Currently, the `darkTheme` configuration in `theme.dart` actually implements a light, high-contrast UI. To improve, a true AMOLED black dark mode should be introduced for night-time usage in low-light environments.
- **One-hand Interaction**: Key interactions (FAB, bottom navigation elements) are placed within the natural thumb zone.

### 1.2 Temporal Context
- **Quick Actions & Micro Moments**: The transaction logging process involves minimal fields (amount, description). This satisfies the "fast completion workflow" necessary when a merchant is serving a queue of customers.
- **Time-sensitive Tasks**: The dashboard sorts/flags overdue customers using red (`AppTheme.error`), allowing merchants to prioritize debt collection.

### 1.3 Cognitive Context
- **Mental Load**: Avoids complex graphs. Uses a single big "Hero Card" showing the total outstanding debt. Simple color coding (Green for payments, Blue for debt, Red for overdue).
- **Error Prevention**: Forms use text capitalization for names and specific keyboard types for numeric entry.

### 1.4 Device Context
- **Small Screens**: Use of `ListView` with constrained card padding ensures usability on budget Android devices.
- **Offline Situations**: 100% offline data flow via SQLite. There are no loading spinners waiting for network requests, matching the "weak network" requirement flawlessly.
- **Performance**: Animated lists (`TweenAnimationBuilder`) are fast and lightweight, providing visual feedback without heavily impacting GPU rendering.

---

## 2. UX Research & Validation Plan

### 2.1 Qualitative Methods
- **User Interviews**: 
  - Interview 5-10 shop owners currently using paper ledgers. 
  - Focus on frustrations with debt calculation and language barriers.
- **Usability Testing**:
  - Task 1: "Add a customer named Abebe with a deadline of next week (in Ethiopian Calendar)."
  - Task 2: "Log a payment of 500 Birr from Abebe."
  - Task 3: "Change the app language to Amharic."
- **Diary Studies**: Ask a shop owner to use DubeBook parallel to their paper ledger for one week and report discrepancies or speed issues.

### 2.2 Quantitative Methods
- **Analytics (Future Implementation)**: 
  - Implement local, anonymous usage tracking (e.g., SQLite logging).
  - Track: Drop-off in the "Add Transaction" screen, usage frequency of the Ethiopian Date Picker vs typing.
- **Heatmaps & Session Recordings**:
  - Track scroll depth on the Dashboard. Are merchants missing customers at the bottom of the list?
- **A/B Testing**:
  - Test FAB placement (Bottom Right vs Bottom Center).
  - Test Hero Card visibility (Expanded vs Collapsible).
