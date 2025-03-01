# See

> **S**can  
> **E**xplore  
> **E**xamine  

---

[![Makefile CI](https://github.com/Henrisen/see/actions/workflows/makefile.yml/badge.svg)](https://github.com/Henrisen/see/actions/workflows/makefile.yml)
![Single Command Install](https://img.shields.io/badge/Installation-Single_Command_Install-ok)
![1 User](https://img.shields.io/badge/Users-1-ok)
![BSD3 License](https://img.shields.io/badge/License-BSD--3--Clause-yellow)

## Table of Contents

- [Supported Operating Systems](#supported-operating-systems)
- [Summary](#summary)
- [Installing](#installing)
  - [For Linux and macOS](#for-linux-and-macos)
  - [For Windows (WIP)](#for-windows)
  - [Quick Install](#quick-install)
- [Usage](#usage)
- [Uninstalling](#uninstalling)
- [License](#license)
- [Contributing](#contributing)

## Supported Operating Systems

![Debian-based Linux](https://img.shields.io/badge/Debian_Linux-Supported-green)
![Red Hat-based Linux](https://img.shields.io/badge/Red_Hat_Linux-Supported-green)
![Arch-based Linux](https://img.shields.io/badge/Arch_Linux-Supported-green)
![macOS](https://img.shields.io/badge/MacOS-Supported-green)
![Windows (WSL)](https://img.shields.io/badge/Windows--(WSL)-Supported-green)
![Windows (Non-WSL)](https://img.shields.io/badge/Windows--(Non--WSL)-Partially%20Supported-yellow)

## Summary

A simple file viewer with syntax highlighting for Linux, Windows and macOS.

![Screenshot of see](https://github.com/Henrisen/see/blob/main/.github/resources/1.png?raw=true)

## Installing

The `see` tool is a command-line utility for viewing files in a user-friendly manner. Follow the steps below to install `see` on your supported operating systems. Ensure you have `curl` installed.

### For Linux and macOS

#### 1. Check if `curl` is installed

Run this command to check if `curl` is installed:

```bash
command -v curl >/dev/null 2>&1 && echo "YES" || echo "NO"
```

If the previous command outputs `YES`, then `curl` is installed and you can continue.

If it returns `NO`, then `curl` is not installed. In this case, please check how to install `curl` on your system and then repeat this step.

#### 2. Download the Installer from my Official GitHub

Remove any outdated installer from your current working directory, if present:

```bash
[ -f ./install ] && rm -f ./install
```

Next, use `curl` to download the latest installer:

```bash
curl -O https://raw.githubusercontent.com/Henrisen/see/refs/heads/main/install
```

#### 3. Run the Installer

You will need sudo permissions to run the installer. Use the following commands:

```bash
chmod +x ./install
sudo ./install
```

### For Windows

#### 1. Check if `curl` is installed

Run this command to check if `curl` is installed:

```cmd
where curl >nul 2>&1 && echo YES || echo NO
```

If the previous command outputs `YES`, then `curl` is installed and you can continue.

If it returns `NO`, then `curl` is not installed. In this case, please check how to install `curl` on your system and then repeat this step.

#### 2. Download the Installer from my Official GitHub

Remove any outdated installer from your current working directory, if present:

```cmd
if exist .\install del /f .\install
```

Next, use `curl` to download the latest installer:

```cmd
curl -O https://raw.githubusercontent.com/Henrisen/see/refs/heads/main/install.bat
```

#### 3. Run the Installer

You will need sudo permissions to run the installer. Use the following commands:

```cmd
.\install.bat
```

### Quick Install

To install `see` with a single command:

### Linux

```bash
command -v curl >/dev/null 2>&1 || { echo "curl is not installed. Please install curl and try again."; } && rm -f ./install && curl -s -O https://raw.githubusercontent.com/Henrisen/see/refs/heads/main/install && chmod +x ./install && sudo ./install
```

#### Windows

```cmd
where curl >nul 2>&1 || (echo "curl is not installed. Please install curl and try again." & pause & exit /b) && (if exist installer.bat del /f installer.bat) & curl -s -O https://raw.githubusercontent.com/Henrisen/see/refs/heads/main/install.bat && (if exist install.bat call install.bat || (echo Failed to download installer.bat. & pause))
```

## Usage

To use `see`, run it with the name of the file you want to open:

```bash
see example.sh
```

For real-time file updates, use the `-f` / `--follow` flag:
> Currently only on Unix Version

```bash
see -f example.sh
```

For custom update intervals, use the `-u` / `--update-interval` flag (default is 125 ms):
> Currently only on Unix Version

```bash
see -fu125 example.sh
```

## Uninstalling

To uninstall `see`, use the following commands:

```bash
git clone https://github.com/Henrisen/see.git
cd see
sudo make uninstall
```

---

## License

This project is licensed under the **BSD 3-Clause License**. See the [LICENSE file](LICENSE) for more details.

## Contributing

Contributions to this project are welcome. Please fork the repository, make your changes, and submit a pull request. Ensure your code adheres to the project’s coding standards and includes relevant tests.

1. Fork the repository
2. Create a new branch for your feature
3. Commit your changes
4. Push your branch to your fork
5. Open a pull request
6. Wait for Approval
