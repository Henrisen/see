# See

> **S**can
>
> **E**xplore
>
> **E**xamine
---
[![Makefile CI](https://github.com/Henrisen/see/actions/workflows/makefile.yml/badge.svg)](https://github.com/Henrisen/see/actions/workflows/makefile.yml)

## Supported Operating Systems

| Operating System               | Support Status            |
|--------------------------------|---------------------------|
| ![Debian-based Linux](https://img.shields.io/badge/Linux-Debian%20%7C%20Ubuntu-green)      | Supported  |
| ![Red Hat-based Linux](https://img.shields.io/badge/Linux-Fedora%20%7C%20RHEL%20%7C%20Rocky-blue) | Supported  |
| ![Arch-based Linux](https://img.shields.io/badge/Linux-Arch%20%7C%20Manjaro-1793d1)       | Supported  |
| ![macOS](https://img.shields.io/badge/macOS-Supported-ff69b4)                               | Supported  |
| ![Windows (WSL)](https://img.shields.io/badge/Windows-WSL-blue)                             | Supported  |
| ![Windows (Non-WSL)](https://img.shields.io/badge/Windows-Non--WSL%20Not%20Supported-red)  | Not Supported  |


## Summary

A Simple File Viewer with Syntax Highlighting for Linux and MacOS

![Screenshot of see](https://github.com/Henrisen/see/blob/main/.github/resources/1.png?raw=true)

## Installing

The `see` tool is a command-line utility for viewing files in a user-friendly manner. Follow the steps below to install `see` on your supported operating systems. Ensure you have `curl` installed.

### For Linux and MacOS

#### 1. Check if `curl` is installed

Run this command to check if `curl` is installed:

```bash
command -v curl >/dev/null 2>&1 && echo "YES" || echo "NO"
```

If the previous command outputs `YES`, then `curl` is installed and you can continue.

If it returns `NO`, then `curl` is not installed. In this case you should check how to install `curl` on your system and then repeat this Step

#### 2. Download the Installer from the Official Github

First, you have to remove any outdated version of the installer from your current working directory if present. Check if the installer is already present and remove it using this command:

```bash
[ -f ./install ] && rm -f ./install
```

This command will use `curl` to download the installer into the current working directory:

```bash
curl -O https://raw.githubusercontent.com/Henrisen/see/refs/heads/main/install
```

#### 3. Run the installer

You will need sudo permissions to run the installer. To run the installer, run these commands:

```bash
chmod +x ./install

sudo ./install
```

#### Quick Install

If you want one quick install command, use this:

```bash
command -v curl >/dev/null 2>&1 || { echo "curl is not installed. Please install curl and try again."; exit 1; } && rm -f ./install && curl -s -O https://raw.githubusercontent.com/Henrisen/see/refs/heads/main/install && chmod +x ./install && sudo ./install
```

## Usage

To use see, you need to run `see` followed by the name of the file you want to open:

```bash
see example.sh
```

If you want to reload when the file updates, you can run `see` with the `-f` / `--follow` flag:

```bash
see -f example.sh
```

Using it this way, you will get a `No --update-interval provided. Using default value of 125 milliseconds` warning.
You can prevent this by setting the `-u` / `--update-interval` flag to any value (by default `125`):

```bash
see -fu125 example.sh
```

## Uninstalling

```bash
git clone https://github.com/Henrisen/see.git
cd see
sudo make uninstall
```
