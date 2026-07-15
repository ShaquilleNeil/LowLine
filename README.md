# LowLine

LowLine is a barcode-based inventory tracking app. Scan an item to look it up,
adjust its quantity, and get notified when stock runs low. Inventory lives in
**Spaces** — personal or shared containers that a group of people can track
together.

Built with Flutter and Firebase (Firestore, Auth, Cloud Functions, FCM).

## Core entities

- **Space** — an inventory container, personal or shared. Has an owner,
  members, and pending invites.
- **Item** — a tracked item with a barcode, quantity, and low-stock
  threshold.
- **UsageLog** — a record of a quantity change on an item (who, how much,
  when, and why).

## Project structure

The app follows a feature-first layout:

```
lib/
  core/           # theme, routing, shared widgets, utils
  features/       # auth, spaces, inventory, scanner, labels, dashboard, settings
    <feature>/
      data/           # repositories, data sources
      domain/         # models, business logic
      presentation/   # screens, widgets
  services/       # firebase, notifications, barcode
```

State management is handled with [Riverpod](https://riverpod.dev/).

## Status

Currently scaffolding — folder structure and placeholder screens/models are
in place, but no Firebase integration or feature logic has been built yet.
Being developed sprint by sprint, starting with Firebase setup (Sprint 0).

## Getting started

```
flutter pub get
flutter analyze
flutter run
```

## License

All rights reserved. See [LICENSE](LICENSE).
