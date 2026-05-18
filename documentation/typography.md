# Typography System

## 1. Typefaces
- **Primary Font**: Platform native defaults (Roboto for Android, SF Pro for iOS). This ensures high performance, minimal app size, and native readability.
- **Weights**: Extensive use of `FontWeight.w900` (Black/Heavy), `FontWeight.w800` (Extra Bold), and `FontWeight.w500` (Medium) to create strong visual hierarchy without relying on multiple font families.

## 2. Hierarchy Specifications
As implemented in `theme.dart` and UI screens:

### Headers & Titles
- **Hero Numbers**: 48sp, `w900` (e.g., Total Unpaid Amount)
- **AppBar Title**: 20sp, `w900`, letter spacing 3.0
- **Screen Titles / Dialog Titles**: 18sp, `w900`, letter spacing 1.2
- **List Item Titles**: 17sp, `w800`

### Body Text
- **Primary Body**: 16sp, `w500` (Input labels, primary buttons)
- **Secondary Body**: 14sp, normal weight
- **Helper / Micro Text**: 12sp, `w700` (Active credit tag)
- **Overdue Tags**: 9sp, `w900`, letter spacing 1.0

## 3. Pillar 1 — Legibility
- Minimum tap-target texts (buttons) are set to 16sp.
- High contrast is maintained. Text colors are deep slate (`0xFF0F172A`) rather than pure black to reduce eye strain while preserving high contrast ratios.

## 4. Pillar 2 — Readability
- Line height: Flutter's default 1.2-1.5x scaling applies.
- Letter spacing is heavily used to separate all-caps or critical numbers (e.g., AppBar `letterSpacing: 3`, Overdue tag `letterSpacing: 1`).
