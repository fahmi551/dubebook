# Component Library

## 1. Atoms
- **Colors**: See `colors.md`.
- **Typography**: See `typography.md`.
- **Icons**: Standard Material Icons + Cupertino Icons, uniformly colored `textSecondary` unless active.

## 2. Molecules
- **Primary Button**: `ElevatedButtonThemeData`. `primaryBlue` bg, 16px radius, `w900` text. Used for main form submissions.
- **Input Field**: `InputDecorationTheme`. Filled `0xFFF1F5F9`. No idle border. Used across all dialogs.
- **Avatar Block**: 54x54 box with 18px border radius. Gradient background (Blue for active, Red for overdue). Displays first letter of customer name.

## 3. Organisms
- **Animated Customer Tile** (`_AnimatedCustomerTile`):
  - Row layout containing Avatar Block, Name, Deadline Tag, and Debt Amount.
  - Interactive: Tapping opens Customer Details.
  - States: Normal (Grey border), Overdue (Red border, Red text).
- **Hero Stats Card**:
  - Large Container (30px radius) with `primaryBlue` gradient.
  - Contains Total Debt number, currency label, and an "Active Credit" tag.
- **Ethiopian Date Picker Dialog**:
  - Custom grid layout replacing standard `showDatePicker`. Includes Month/Year selectors customized for 13 months (Pagume).

## 4. Templates
- **Standard Screen Structure**:
  - `Scaffold` -> `backgroundColor: AppTheme.background`.
  - `AppBar` -> White background, centered title, 0 elevation.
  - `Body` -> Column containing Header/Hero and an `Expanded` ListView.
