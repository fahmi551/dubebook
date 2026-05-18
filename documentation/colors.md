# Color System

## 1. Palette Overview
- **Background**: White (`0xFFFFFFFF`)
- **Surface**: Very light grey/blue (`0xFFF8FAFC`)
- **Primary**: Electric Blue (`0xFF1010A0`)
- **Accent/Success**: Accent Green (`0xFF059669`)
- **Text Primary**: Dark Slate (`0xFF0F172A`)
- **Text Secondary**: Medium Slate (`0xFF64748B`)
- **Error**: Red (`0xFFDC2626`)
- **Input Fill**: Slate Grey (`0xFFF1F5F9`)

## 2. The 60-30-10 Rule Application

### 60% — Backgrounds & Surfaces
- The app relies heavily on `Colors.white` and `0xFFF8FAFC` for scaffold backgrounds, cards, and bottom sheets. This ensures a clean, breathable interface.

### 30% — Primary Brand & Structural
- Electric Blue (`0xFF1010A0`) is used for AppBars, primary buttons, Hero Cards (via gradients), and active focus borders.
- Dark Slate text ensures structural readability across the app.

### 10% — Call to Actions & Highlights
- Accent Green (`0xFF059669`) is used strictly for positive actions (payments) and success markers.
- Error Red (`0xFFDC2626`) is reserved exclusively for overdue deadlines, destructive actions, and validation warnings.

## 3. Accessibility & Contrast (WCAG AA)
- **Primary Text on White**: `0xFF0F172A` on `0xFFFFFFFF` produces a contrast ratio of > 14:1 (Passes AAA).
- **White Text on Primary Blue**: `0xFFFFFFFF` on `0xFF1010A0` produces a contrast ratio of > 10:1 (Passes AAA).
- **Error Red on Surface**: `0xFFDC2626` on `0xFFF8FAFC` produces a contrast ratio of 4.5:1 (Passes AA).
