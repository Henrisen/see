# See

[![Makefile CI](https://github.com/Henrisen/see/actions/workflows/makefile.yml/badge.svg)](https://github.com/Henrisen/see/actions/workflows/makefile.yml)

## Summary

A Simple File Viewer with Syntax Highlighting for Linux and MacOS

![Screenshot of see](https://github.com/Henrisen/see/blob/main/.github/resources/1.png?raw=true)

## Installing

The `see` tool is a command-line utility for viewing files in a user-friendly manner. Follow the steps below to install `see` on your supported operating systems. Ensure you have Git and `make` installed.

### For Linux

#### **Debian/Ubuntu**

- **Step 1:** Install Git and `make` (if not already installed):

    ```bash
    sudo apt update
    sudo apt install git make
    ```

- **Step 2:** Install the `see` tool:

    ```bash
    git clone https://github.com/Henrisen/see.git
    cd see
    sudo make install
    ```

- **Step 3:** Verify the installation:

    ```bash
    see --version  # Check the installed version of see
    ```

#### **Fedora**

- **Step 1:** Install Git and `make`:

    ```bash
    sudo dnf install git make
    ```

- **Step 2:** Install the `see` tool:

    ```bash
    git clone https://github.com/Henrisen/see.git
    cd see
    sudo make install
    ```

#### **CentOS/RHEL**

- **Step 1:** Enable the EPEL repository (if not already enabled):

    ```bash
    sudo yum install epel-release
    ```

- **Step 2:** Install Git and `make`:

    ```bash
    sudo yum install git make
    ```

- **Step 3:** Install the `see` tool:

    ```bash
    git clone https://github.com/Henrisen/see.git
    cd see
    sudo make install
    ```

#### **Arch Linux**

- **Step 1:** Install Git and `make`:

    ```bash
    sudo pacman -S git make
    ```

- **Step 2:** Install the `see` tool:

    ```bash
    git clone https://github.com/Henrisen/see.git
    cd see
    sudo make install
    ```

### For macOS

- **Step 1:** Install Git and `make` (if not already installed):

    ```bash
    brew install git make
    ```

- **Step 2:** Install the `see` tool:

    ```bash
    git clone https://github.com/Henrisen/see.git
    cd see
    sudo make install
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
