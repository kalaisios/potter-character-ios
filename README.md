# potter-character-ios

# Potter Character iOS App

An iOS app built with **Swift**, **SwiftUI**, and **SwiftData** using the **MVVM architecture**. It fetches Potter character data from an API, displays it in a list, and shows detailed information. The app includes a response **CacheManager** that uses **SwiftData** to cache API response data based on request URLs.

---

## Features

- Display a list of Potter characters from an API
- Show character details on selection
- **MVVM** architecture for maintainability and testability
- **NetworkService** handles network communication
- **CacheManager** stores and retrieves API response data using SwiftData
- Offline-friendly via persistent caching

---

## SwiftData Caching with CacheManager

The `CacheManager` caches JSON responses using a `CachedResponse` SwiftData model with the following properties:

- `url`: The unique request URL (String)
- `data`: Raw JSON `Data`
- `timestamp`: Cache time (Date)

### How It Works

1. On each API call, `CacheManager` checks if a valid response exists in SwiftData.
2. If found, the data is returned immediately.
3. If not, the `ServiceManager` fetches from the API.
4. The new response is saved into SwiftData for future use.

> This provides a simple form of offline access and reduces redundant API calls.

---

## Getting Started

### Requirements

- Xcode 15+
- iOS 17+
- macOS Ventura+

### Run Locally

```bash
git clone https://github.com/kalaisios/potter-character-ios.git
cd potter-character-ios
open PotterCharacter.xcodeproj
