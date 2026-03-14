# iPlayground 18

> **⚠️ This project is no longer maintained and is considered legacy.**
>
> This app was built specifically for the **iPlayground 2018** conference, which has long since concluded. The codebase targets a very early version of Flutter (Flutter 1.x) and relies on dependencies that are now several major versions out of date (e.g. `url_launcher ^3.0.3`, `flutter_markdown ^0.2.0`). These packages have had breaking API changes in subsequent releases, so the project will **not** build or run with current Flutter SDK versions without significant migration work.
>
> No further development or bug fixes are planned. The repository is kept for historical reference only. If you are looking for a modern Flutter conference app to use as a starting point, we recommend starting from scratch with the current Flutter tooling.

iPlayground is the app for [iPlayground](https://iplayground.io/) conference built with [Flutter](https://flutter.io). The app supports both iOS and Android.

- [iOS version](https://itunes.apple.com/tw/app/iplayground-18/id1367423535?mt=8)
- [Android version](https://play.google.com/store/apps/details?id=iplayground.zonble.net.iplayground)

## Build and Run

To build the project, you need Flutter and required tools such as [Xcode](https://developer.apple.com/xcode/), [Android Studio](https://developer.android.com/studio/), and so on. Please read Google's instruction to [install Flutter](https://flutter.io/get-started/install/).

To run the project, just call `flutter run`.

To build the project, just call `flutter build ios` or `flutter build android`.

## Technical Details

### Project Structure

```
lib/
├── main.dart                   # App entry point and home page with bottom navigation
├── main_loading.dart           # Loading state widget
├── main_error.dart             # Error state widget
├── schedule_loader.dart        # Data models (Session, Program, Speaker) and ScheduleLoader
├── schedule_page.dart          # Schedule list view (Day 1 / Day 2 tabs)
├── schedule_session_page.dart  # Session detail page
├── about_page.dart             # About page with sponsors, staff, and co-organizers
├── about_coorganizer_card.dart # Co-organizer card widget
├── about_sns_icon.dart         # Social media icon widget
├── about_sponsor_card.dart     # Sponsor card widget
└── about_staff_card.dart       # Staff card widget
data/
├── sessions.json               # Conference schedule data
└── program.json                # Talk abstracts and speaker bios
```

### Architecture

The app uses Flutter's built-in `StatefulWidget` / `StatelessWidget` pattern for UI and state management.

- **`ScheduleLoader`** is a singleton class that fetches conference schedule data from remote JSON files hosted on GitHub. It exposes two `Stream`s — `onUpdate` and `onError` — which the home page listens to in order to transition between loading, error, and loaded states.
- The home page (`PlaygroundHomePage`) uses a `BottomNavigationBar` with three tabs: Day 1 schedule, Day 2 schedule, and an About page. Each tab is kept alive using `Offstage` widgets to preserve scroll positions.
- Session detail data (abstracts, speaker bios) may contain HTML, which is converted to Markdown using `html2md` and rendered with `flutter_markdown`.

### Dependencies

| Package | Version | Purpose |
|---|---|---|
| `cupertino_icons` | `^0.1.2` | iOS-style icons |
| `url_launcher` | `^3.0.3` | Open URLs in the browser |
| `html2md` | `^0.2.1` | Convert HTML content to Markdown |
| `flutter_markdown` | `^0.2.0` | Render Markdown text as Flutter widgets |

### Data Sources

The app loads conference data at startup from two JSON files hosted in this repository:

- **Sessions**: `https://raw.githubusercontent.com/zonble/iplayground_app/master/data/sessions.json` — contains the schedule for both conference days, including session titles, presenters, time slots, room assignments, and track information.
- **Programs**: `https://raw.githubusercontent.com/zonble/iplayground_app/master/data/program.json` — contains talk abstracts, speaker biographies, video links, and slide links.

If either request fails, the app shows an error screen with a retry button.

### Continuous Integration

The project uses [Travis CI](https://travis-ci.org/) to build both platforms on every push:

- **Android** — built on Ubuntu with `flutter build apk` using Android SDK 28 and JDK 8.
- **iOS** — built on macOS (Xcode 10.1) with `flutter build ios --no-codesign`.

### Testing

The project uses Flutter's built-in `flutter_test` package. Run the tests with:

```
flutter test
```
