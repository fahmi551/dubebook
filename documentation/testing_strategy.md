# Testing Strategy

## 1. Overview
The testing strategy for DubeBook must prioritize the reliability of the offline SQLite database, the accuracy of the native Ethiopian Calendar conversions, and the resilience of the local data.

## 2. Unit Testing Strategy
- **Models**: Validate `fromJson` and `toJson` serialization for `Customer` and `AppTransaction`.
- **Utilities**: 
  - Exhaustively test `EthiopianCalendar.fromGregorian()` and conversions to ensure date accuracy, leap years, and month lengths (Pagume) are calculated flawlessly.
- **Calculations**: Test debt aggregation logic to ensure payments strictly reduce the total debt accurately without floating-point inaccuracies.

## 3. Integration Testing Strategy
- **SQLite Database**: 
  - Spin up an in-memory `sqflite_common_ffi` database for testing.
  - Test CRUD operations on `DatabaseHelper`.
  - Ensure foreign key constraints (e.g., deleting a customer deletes their transactions or handles them gracefully).

## 4. UI / Widget Testing Strategy
- **Localization**: Test if swapping locales correctly translates strings and rebuilds the `MaterialApp` without crashing.
- **List Rendering**: Ensure the Dashboard `ListView` renders correctly for 0, 1, and 100 customers.
- **Dialogs**: Trigger the Ethiopian Date Picker dialog and verify that selection properly updates the underlying text field.

## 5. Manual / Edge Case Testing
- Test the application behavior when the app is put in the background and brought back via the `SessionManager` timeout logic.
- Verify push notifications trigger when device is offline and deadline is reached.
