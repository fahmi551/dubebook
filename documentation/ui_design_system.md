# UI Design System & Component Rules

## 1. Input Controls
- **Buttons**:
  - Primary: `ElevatedButton` with `primaryBlue` (0xFF1010A0) background, rounded corners (16px radius), white text.
  - Secondary: `OutlinedButton` with `primaryBlue` border and text, transparent background.
- **Text Fields**:
  - Filled styling (`0xFFF1F5F9`) with 16px border radius.
  - No visible border on idle, 2px `primaryBlue` border on focus.
- **Selectors**:
  - Custom Ethiopian Calendar dialog instead of the standard Material Date Picker.

## 2. Navigation
- **Primary Routes**: Stack-based navigation (`Navigator.push`) with AppBars.
- **AppBar**: White background, 0 elevation, centered title (20sp, font weight 900, letter spacing 3), dark slate text/icons.
- **Global Actions**: Floating Action Button (FAB) extended for primary actions ("New Customer", "Add Transaction").

## 3. Information Display
- **Cards (Hero Card)**: Gradient background (`primaryBlue` to lighter blue), 30px border radius, heavy drop shadow for elevation.
- **Cards (List Items)**: White background, 24px border radius, subtle border (`isOverdue` triggers red border).
- **Alerts/Dialogs**: `AlertDialog` with `AppTheme.surface` background, 28px border radius.
- **Badges**: Red error text for "Overdue" status, Green text for positive amounts/payments.

## 4. Spacing & Layout Rules
- **Margins & Padding**: Increments of 4px/8px.
  - Screen Padding: 16px or 24px horizontal.
  - Card Internal Padding: 16px to 32px depending on component size.
- **Corner Radii**:
  - Cards: 24px - 30px.
  - Buttons/Inputs: 16px.

## 5. Animation Guidelines
- **List Items**: Staggered fade-and-slide up animations using `TweenAnimationBuilder` (300ms + index * 80ms delay).
- **Transitions**: Standard Material page transitions.

## 6. Empty & Loading States
- **Empty State**: Centralized layout with a muted icon (`shield_moon_rounded`) and low-opacity helper text ("No Customers Found").
- **Loading State**: Centered `CircularProgressIndicator` specifically colored `primaryBlue`.
