# 🛠️ Fake Install Logger

![bash](https://img.shields.io/badge/language-bash-green)
![platform](https://img.shields.io/badge/platform-linux-lightgrey)
![license](https://img.shields.io/badge/license-MIT-blue)
![status](https://img.shields.io/badge/status-stable-success)

A harmless **fake Linux installer** that prints **realistic `apt`-style logs** for about **10 minutes**.  

Great for:
- Demo videos & terminal recordings  
- Fake screenshots  
- PRANK IDK

---

## 🚀 Quick Start

Install in just 2 commands:

```bash
curl -fsSL https://raw.githubusercontent.com/joeoreh/fake-install-logger/main/install.sh | bash
fake-install nginx git curl
```

---

## 📦 Features

- ✔️ Runs for ~10 minutes (600s)  
- ✔️ Outputs **1 log per second** → always looks busy  
- ✔️ Over **50 unique log messages** (cycled per package)  
- ✔️ Fake percentage progress (0% → 100%)  
- ✔️ **Safe:** does not install or modify your system  

---

## 📜 Example Output

```text
[ 42s] (  7%) nginx: Preparing to unpack...
[ 43s] (  7%) git: Unpacking package files...
[ 44s] (  7%) curl: Configuring system services...
...
[600s] (100%) nginx: Finalizing installation...
All packages installed successfully after 600s.
```

---

## ⚡ Run Without Install

If you don’t want to install system-wide, just run:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/joeoreh/fake-install-logger/main/fake-install.sh) nginx git curl
```

---

## 🛑 Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/joeoreh/fake-install-logger/main/uninstall.sh | bash
```

---

## 📂 Files in This Repo

- **`fake-install.sh`** → the main script (10-minute fake installer)  
- **`install.sh`** → simple installer script (adds `fake-install` to PATH)  
- **`uninstall.sh`** → removes everything cleanly  
- **`README.md`** → project documentation  

---

## 📸 Screenshots

Example of fake logs running in the Linux console:

![Terminal screenshot](https://i.imgur.com/McvPo7u.png)

---

## 📜 License

**MIT License** – free to use, modify, and share.  

Author: [@joeoreh](https://github.com/joeoreh)

