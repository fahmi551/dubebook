# Screen Designs Specification

## 1. Splash & Setup Screen (`splash_setup_screen.dart`)
- **Purpose**: App initialization, language selection, and user authentication.
- **Layout**: Centered logo/icon. Smooth fade-in. If a PIN is set, displays a numpad or password field.
- **Actions**: Login, Setup initial PIN.

## 2. Dashboard Screen (`dashboard_screen.dart`)
- **Purpose**: Primary view showing business health.
- **Components**:
  - **AppBar**: App title, History Icon, Settings Icon.
  - **Hero Card**: Gradient `primaryBlue` card. Displays "Total Outstanding" debt in 48sp text.
  - **List Header**: Text displaying "Pending Debts" and the count of customers.
  - **Customer List**: Scrollable list of `_AnimatedCustomerTile` widgets.
  - **FAB**: Extended button "New Customer".

## 3. Customer Detail Screen (`customer_detail_screen.dart`)
- **Purpose**: View specific customer debt and add new transactions.
- **Components**:
  - **AppBar**: Customer name.
  - **Profile Header**: Displays avatar, debt amount, and payment deadline.
  - **Transaction History**: List of specific items purchased on credit or payments made. Green text for payments, Blue/Black for debts.
  - **Add Transaction Layout**: Bottom sheet or dialog to input amount and description.

## 4. History Screen (`history_screen.dart`)
- **Purpose**: Global ledger view.
- **Components**:
  - **List View**: Chronological list of all app transactions across all customers. Helpful for end-of-day cash reconciliation.

## 5. Settings Screen (`settings_screen.dart`)
- **Purpose**: App configuration.
- **Components**:
  - **List Tiles**: Language Selection (Radio/Dropdown), App Lock (Toggle), Backup Database (Button).

## 6. Dialogs
- **Add Customer Dialog**: Input field for name, custom selector for Ethiopian Date Picker.
- **Add Transaction Dialog**: Input for Amount (Numeric keyboard), Description, Toggle for "Credit" vs "Payment".
