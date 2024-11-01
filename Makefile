SHELL := /bin/bash

.PHONY: help

all: no_command
help: no_command
install: check_sudo check_python check_pip check_pygments check_see install_see success
uninstall: check_sudo check_see_removeable uninstall_see uninstall_success
full-uninstall: check_sudo check_python check_pip check_remove_pygments check_see_removeable uninstall_see uninstall_success

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
			sudo pacman -Sy python; \
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
			sudo pacman -Sy python-pip; \
		else \
			echo "Unsupported package manager. Please install pip manually."; \
			exit 1; \
		fi \
	else \
		echo "Pip is already installed."; \
	fi

check_pygments:
	@if ! pip show Pygments &> /dev/null; then \
		echo "Pygments is not installed. Installing..."; \
		make install_pygments; \
	else \
		echo "Pygments is already installed."; \
	fi

check_remove_pygments:
	@if pip show Pygments &> /dev/null; then \
		echo "Pygments is installed. Removing..."; \
		make remove_pygments; \
	else \
		echo "Pygments is already removed."; \
	fi

install_pygments:
	@pip install Pygments

remove_pygments:
	@pip uninstall -y Pygments

check_see:
	@if command -v see &> /dev/null; then \
		echo "See is already installed."; \
	else \
		echo "See is not installed. Proceeding to install..."; \
	fi

check_see_removeable:
	@if ! command -v see &> /dev/null; then \
		echo "See is already remooved."; \
	fi

install_see:
	@sudo cp ./see /usr/bin/see
	@sudo cp ./see /bin/see
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
