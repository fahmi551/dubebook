# Product Overview: DubeBook

## 1. Product Overview
DubeBook is a mobile application built with Flutter, tailored for managing informal shop credit systems (locally known as "Dube"). Operating with an offline-first architecture powered by SQLite, it provides local merchants with a digital replacement for manual ledger books. DubeBook currently supports multiple local languages (Amharic, Oromo, English) and utilizes native Ethiopian Calendar systems to perfectly fit the temporal context of its target audience.

## 2. Project Objectives
- Transition manual, paper-based ledger systems to a secure and resilient digital solution.
- Enhance the accuracy of debt calculations and transaction histories.
- Ensure 100% offline functionality to accommodate areas with unstable internet connections.
- Support local customs, languages, and calendar systems (Ethiopian Calendar) inherently.

## 3. Business Goals
- Improve credit recovery rates for local business owners by addressing frequent disputes.
- Provide structured repayment tracking and easy tracking of total customer debt.
- Ensure efficient reminder mechanisms for overdue payments.
- Maintain transaction history for accountability.

## 4. User Personas
**1. The Local Merchant (Shop Owner)**
- **Needs**: Fast entry, clear visibility of total outstanding debts, reminder of overdues, and offline reliability.
- **Pain Points**: Losing physical ledgers, calculating accumulated debt manually, translating Gregorian dates to local Ethiopian dates.

## 5. User Journey Map
1. **Onboarding/Splash**: User enters the app, authenticates if configured, selects their preferred language (Amharic/Oromo/English).
2. **Dashboard**: User sees the total outstanding money (Hero Card) and a list of all customers with pending debts.
3. **Adding a Customer**: User taps the FAB to register a new customer, setting an optional Ethiopian Calendar deadline.
4. **Logging a Transaction**: User selects a customer and navigates to the detailed view, logging new items taken on credit or payments made.
5. **Reviewing History**: User opens the History screen to review recent transactions for end-of-day reconciliation.

## 6. Information Architecture
```
[ App Root ]
 ├── Splash/Auth Screen
 ├── Dashboard (Unpaid Customers + Hero Stats)
 │    ├── Customer Details (Transactions & Add Transaction)
 │    ├── Settings (Language, Backup, Theme, App Lock)
 │    └── History (Global Transaction Logs)
```

## 7. UX Decisions and Rationale
- **Offline-First**: Driven by device constraints and connectivity issues in the target demographic. SQLite used for immediate persistence.
- **Electric Blue Theme on Light Background**: High contrast ensures visibility outdoors and in bright sunlight (Physical Context).
- **Hero Card UI**: Emphasizes the most critical business metric—total unrecovered money—at a quick glance.
- **Ethiopian Date Picker**: Completely custom-built calendar picker addressing a significant localization requirement that standard libraries fail to meet.

## 8. Accessibility
- High-contrast text on surfaces (WCAG AA compliant).
- Use of clear icons paired with text labels.
- Sizable tap targets (Minimum 48x48 logical pixels) for key actions (FAB, list items, buttons).

## 9. Future Scalability Recommendations
- Cloud backup integration for robust data preservation.
- Partial payment support to handle staggered debt recovery.
- Customer notification system for enhanced debt collection.
