# SnapSync

### Local Network Clipboard Sync for Android & Windows

SnapSync is a free, open-source Flutter project designed to sync clipboard text between devices over a local network.

It provides a simple way to send copied text from one device to another without relying on cloud clipboard services.

---

## 📋 What is SnapSync?

SnapSync focuses on one simple task:

> **Move copied text between your devices over your local network.**

For example, you can copy a link, note, code snippet, or other text on one device and send it to another device using the target device's local IP address.

SnapSync uses a lightweight local HTTP server to receive clipboard data.

---

## ✨ Current Features

### 📋 Clipboard Sync

SnapSync can send and receive plain-text clipboard content between devices.

The current implementation allows you to:

* Copy text on your device
* Enter the target device's local IP address
* Send the current clipboard text
* Receive clipboard text from another SnapSync instance
* Automatically place received text into the device clipboard

### 🌐 Local Network Communication

SnapSync communicates directly over the local network.

The current implementation uses:

* Local IPv4 networking
* HTTP communication
* Port `8080`
* A `/sync-clipboard` endpoint for receiving clipboard text

No cloud server is required for the basic clipboard-sync workflow.

### ⚡ Simple Interface

The current app provides a straightforward interface with:

* Target device IP input
* **Send Copied Clipboard Now** button
* Last synced data display
* Clipboard synchronization handling

---

## 🔄 How SnapSync Works

The basic workflow is simple:

```text
Device A
   │
   │ Copy text
   ▼
SnapSync
   │
   │ Local network
   │ HTTP :8080
   ▼
SnapSync
   │
   ▼
Device B Clipboard
```

### Step 1 — Run SnapSync

Run the SnapSync application on the devices you want to use.

### Step 2 — Find the Target Device IP

The sending device needs the local IP address of the target device.

For example:

```text
192.168.1.15
```

### Step 3 — Enter the IP Address

Enter the target device's local IP address in the SnapSync interface.

### Step 4 — Send Clipboard Text

Copy some text and press:

**Send Copied Clipboard Now**

SnapSync sends the clipboard text to the target device over the local network.

### Step 5 — Receive the Text

The receiving SnapSync instance accepts the clipboard data and places the received text into the device clipboard.

---

## 🔒 Privacy & Network Design

SnapSync is designed around local device-to-device communication.

The current implementation does not require a cloud clipboard service for the basic sync workflow.

This can be useful when you want to move text between devices without sending it through an online clipboard or cloud storage platform.

### Important Security Note

The current implementation uses HTTP on the local network and does not currently provide authentication or encryption.

For this reason:

* Use SnapSync on networks you trust.
* Avoid exposing port `8080` directly to the public internet.
* Do not treat the current version as a secure solution for sensitive or confidential information.

Security improvements can be added as the project evolves.

---

## 🛠️ Technology

SnapSync is built with **Flutter** and Dart.

The current implementation uses:

* Flutter
* Dart
* `shelf`
* `shelf_router`
* `http`
* `clipboard_watcher`
* Flutter Clipboard API

The local server listens on IPv4 and uses port `8080` for clipboard synchronization.

---

## 📦 Getting Started

Clone the repository:

```bash
git clone https://github.com/ai-directory669/snapsync.git
```

Enter the project directory:

```bash
cd snapsync
```

Install Flutter dependencies:

```bash
flutter pub get
```

Then run the application using Flutter's normal run command for your target platform.

> Make sure the devices can communicate with each other over the same local network.

---

## 🖥️ Android & Windows

SnapSync is intended for use across devices such as Android phones and Windows computers where the Flutter application can run.

The exact platform support and setup experience may evolve as development continues.

Before using SnapSync for important data, test the application in your own network environment.

---

## 🎯 Useful For

SnapSync can be useful for people who frequently move small pieces of text between devices.

Examples include:

* 🔗 URLs and web links
* 📝 Notes and short text
* 💻 Code snippets
* 📋 Copied messages
* 📄 Small pieces of document text
* 🔢 Numbers or other plain-text information

---

## 💡 Why Local Clipboard Sync?

Moving text between a phone and computer often involves:

* Emailing the text to yourself
* Sending it through a messaging app
* Using a cloud clipboard
* Opening cloud storage
* Manually retyping information

SnapSync explores a simpler alternative:

**Android ↔ Local Network ↔ Windows**

The goal is to make quick clipboard sharing possible without requiring a cloud-based clipboard service.

---

## 🚧 Current Limitations

SnapSync is an early-stage project.

The current version has some limitations:

* Clipboard synchronization currently focuses on plain text.
* The target device IP must currently be entered manually.
* Automatic device discovery is not currently implemented.
* File transfer is not currently implemented.
* The current network communication uses HTTP.
* Authentication and encryption are not currently implemented.
* Network configuration may vary between devices and operating systems.

These limitations may be addressed in future versions.

---

## 🌱 Future Development

Possible future improvements include:

* Automatic device discovery
* Easier device pairing
* Improved clipboard synchronization
* Secure communication
* Authentication
* File transfer
* Better cross-platform support
* Improved user interface

These are future development ideas and are not necessarily available in the current version.

---

## 🤝 Contributing

SnapSync is an open-source project.

If you find a problem or have an idea for improvement, you can:

* Open an issue
* Suggest a feature
* Review the source code
* Contribute improvements

### Report an Issue

https://github.com/ai-directory669/snapsync/issues

---

## 📄 License

SnapSync is released under the **MIT License**.

See the `LICENSE` file for details.

---

## 🔗 Links

### GitHub Repository

https://github.com/ai-directory669/snapsync

### Live Project Page

https://ai-directory669.github.io/snapsync/

### Report an Issue
