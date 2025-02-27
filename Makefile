SHELL := /bin/bash

.PHONY: help

all: no_command
help: no_command
install: check_sudo check_python check_pip check_dependencies install_see success
uninstall: check_sudo check_see_removeable uninstall_see uninstall_success
full-uninstall: check_sudo check_python check_pip check_remove_pygments uninstall_see uninstall_success

no_command:
	@echo "Usage: make [command]"
	@echo ""
	@echo "  help             This Screen"
	@echo "  install          Install see"
	@echo "  uninstall        Uninstall see"
	@echo "  full-uninstall   Uninstall see and installed requirements"

check_sudo:
	@if [ "$$EUID" -ne 0 ]; then \
		echo "Please run the Installer with sudo."; \
		exit 1; \
	fi

check_python:
	@if ! command -v python3 &> /dev/null; then \
		echo "Python3 is not installed. Installing..."; \
		if [ -x "$$(command -v apt)" ]; then \
			sudo apt update && sudo apt install -y python3; \
		elif [ -x "$$(command -v dnf)" ]; then \
			sudo dnf install -y python3; \
		elif [ -x "$$(command -v yum)" ]; then \
			sudo yum install -y python3; \
		elif [ -x "$$(command -v pacman)" ]; then \
			sudo pacman --noconfirm -Sy python; \
		elif [ -x "$$(command -v zypper)" ]; then \
			sudo zypper install -y python3; \
		elif [ -x "$$(command -v brew)" ]; then \
			sudo brew install python3; \
		else \
			echo "Unsupported package manager. Please install Python3 manually."; \
			exit 1; \
		fi \
	else \
		echo "Python3 is already installed."; \
	fi

check_pip:
	@if ! command -v pip3 &> /dev/null; then \
		echo "Pip is not installed. Installing..."; \
		if [ -x "$$(command -v apt)" ]; then \
			sudo apt update && sudo apt install -y python3-pip; \
		elif [ -x "$$(command -v dnf)" ]; then \
			sudo dnf install -y python3-pip; \
		elif [ -x "$$(command -v yum)" ]; then \
			sudo yum install -y python3-pip; \
		elif [ -x "$$(command -v pacman)" ]; then \
			sudo pacman --noconfirm -Sy python-pip; \
		elif [ -x "$$(command -v zypper)" ]; then \
			sudo zypper install -y python3-pip; \
		elif [ -x "$$(command -v brew)" ]; then \
			sudo brew install python3-pip; \
		else \
			echo "Unsupported package manager. Please install pip manually."; \
			exit 1; \
		fi \
	else \
		echo "Pip is already installed."; \
	fi

check_remove_pygments:
	@if command -v pygmentize &> /dev/null; then \
        echo "pygmentize is installed, Removing..."; \
        if command -v apt &> /dev/null; then \
            sudo apt remove -y python3-pygments; \
        elif command -v dnf &> /dev/null; then \
            sudo dnf remove -y python3-pygments; \
        elif command -v pacman &> /dev/null; then \
            sudo pacman --noconfirm -R python-pygments; \
        elif command -v zypper &> /dev/null; then \
            sudo zypper remove -y python3-pygments; \
        elif command -v brew &> /dev/null; then \
            brew uninstall pygments; \
        else \
            echo "Package manager not recognized. Please remove pygmentize manually."; \
            exit 1; \
        fi \
    else \
        echo "pygmentize is not installed."; \
    fi

check_dependencies:
	@echo "Checking required system dependencies..."
	@if ! command -v pygmentize &> /dev/null; then \
		echo "pygmentize is required but not installed. Installing..."; \
		if [ -x "$$(command -v apt)" ]; then \
			sudo apt install -y python3-pygments; \
		elif [ -x "$$(command -v dnf)" ]; then \
			sudo dnf install -y python3-pygments; \
		elif [ -x "$$(command -v pacman)" ]; then \
			sudo pacman --noconfirm -Sy python-pygments; \
		elif [ -x "$$(command -v zypper)" ]; then \
			sudo zypper install -y python3-pygments; \
		elif [ -x "$$(command -v brew)" ]; then \
			sudo brew install python3-pygments; \
		else \
			echo "Unsupported package manager. Please install pygmentize manually."; \
			exit 1; \
		fi \
	else \
		echo "pygmentize is already installed."; \
	fi

	@echo "Checking other required system dependencies..."
	@if ! command -v less &> /dev/null; then \
		echo "less is not installed. Installing..."; \
		if [ -x "$$(command -v apt)" ]; then \
			sudo apt install -y less; \
		elif [ -x "$$(command -v dnf)" ]; then \
			sudo dnf install -y less; \
		elif [ -x "$$(command -v yum)" ]; then \
			sudo yum install -y less; \
		elif [ -x "$$(command -v pacman)" ]; then \
			sudo pacman --noconfirm -Sy less; \
		elif [ -x "$$(command -v zypper)" ]; then \
			sudo zypper install -y less; \
		elif [ -x "$$(command -v brew)" ]; then \
			sudo brew install less; \
		else \
			echo "Unsupported package manager. Please install less manually."; \
			exit 1; \
		fi \
	elif ! command -v bc &> /dev/null; then \
		echo "bc is not installed. Installing..."; \
		if [ -x "$$(command -v apt)" ]; then \
			sudo apt install -y bc; \
		elif [ -x "$$(command -v dnf)" ]; then \
			sudo dnf install -y bc; \
		elif [ -x "$$(command -v yum)" ]; then \
			sudo yum install -y bc; \
		elif [ -x "$$(command -v pacman)" ]; then \
			sudo pacman --noconfirm -Sy bc; \
		elif [ -x "$$(command -v zypper)" ]; then \
			sudo zypper install -y bc; \
		elif [ -x "$$(command -v brew)" ]; then \
			sudo brew install bc; \
		else \
			echo "Unsupported package manager. Please install bc manually."; \
			exit 1; \
		fi \
	elif ! command -v grep &> /dev/null; then \
		echo "grep is not installed. Installing..."; \
		if [ -x "$$(command -v apt)" ]; then \
			sudo apt install -y grep; \
		elif [ -x "$$(command -v dnf)" ]; then \
			sudo dnf install -y grep; \
		elif [ -x "$$(command -v yum)" ]; then \
			sudo yum install -y grep; \
		elif [ -x "$$(command -v pacman)" ]; then \
			sudo pacman --noconfirm -Sy grep; \
		elif [ -x "$$(command -v zypper)" ]; then \
			sudo zypper install -y grep; \
		elif [ -x "$$(command -v brew)" ]; then \
			sudo brew install grep; \
		else \
			echo "Unsupported package manager. Please install grep manually."; \
			exit 1; \
		fi \
	elif ! command -v awk &> /dev/null; then \
		echo "awk is not installed. Installing..."; \
		if [ -x "$$(command -v apt)" ]; then \
			sudo apt install -y gawk; \
		elif [ -x "$$(command -v dnf)" ]; then \
			sudo dnf install -y gawk; \
		elif [ -x "$$(command -v yum)" ]; then \
			sudo yum install -y gawk; \
		elif [ -x "$$(command -v pacman)" ]; then \
			sudo pacman --noconfirm -Sy gawk; \
		elif [ -x "$$(command -v zypper)" ]; then \
			sudo zypper install -y gawk; \
		elif [ -x "$$(command -v brew)" ]; then \
			sudo brew install gawk; \
		else \
			echo "Unsupported package manager. Please install gawk manually."; \
			exit 1; \
		fi \
	elif ! command -v wc &> /dev/null; then \
		echo "wc is not installed. Installing..."; \
		if [ -x "$$(command -v apt)" ]; then \
			sudo apt install -y coreutils; \
		elif [ -x "$$(command -v dnf)" ]; then \
			sudo dnf install -y coreutils; \
		elif [ -x "$$(command -v yum)" ]; then \
			sudo yum install -y coreutils; \
		elif [ -x "$$(command -v pacman)" ]; then \
			sudo pacman --noconfirm -Sy coreutils; \
		elif [ -x "$$(command -v zypper)" ]; then \
			sudo zypper install -y coreutils; \
		elif [ -x "$$(command -v brew)" ]; then \
			sudo brew install coreutils; \
		else \
			echo "Unsupported package manager. Please install coreutils manually."; \
			exit 1; \
		fi \
	else \
		echo "All required dependencies (less, bc, grep, awk, wc) are installed."; \
	fi

install_see:
	@sudo cp ./see /usr/bin/see
	@sudo cp ./see /bin/see
	@sudo chmod +x /usr/bin/see
	@sudo chmod +x /bin/see
	@echo "----------------------------------------------------------------"

uninstall_see:
	@sudo rm -f /usr/bin/see
	@sudo rm -f /bin/see
	@echo "----------------------------------------------------------------"

success:
	@echo ""
	@echo "Success!"
	@echo "See is now installed"

uninstall_success:
	@echo "Success!"
	@echo "See is now removed"
