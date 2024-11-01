SHELL := /bin/bash

.PHONY: all check_sudo check_python install_python check_pip install_pip check_pygments install_pygments check_see install_see success

all: no_command
install: check_sudo check_python check_pip check_pygments check_see install_see success
uninstall: check_sudo check_see_removeable

no_command:
	@echo "Invalid Command"

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

install_pygments:
	@pip install Pygments

check_see:
	@if command -v see &> /dev/null; then \
		echo "See is already installed."; \
	else \
		echo "See is not installed. Proceeding to install..."; \
	fi

check_see_removeable:
	@if command -v see &> /dev/null; then \
		make uninstall_see; \
	else \
		echo "See is not installed."; \
	fi

install_see:
	@sudo cp ./see /usr/bin/see
	@sudo cp ./see /bin/see

uninstall_see:
	@sudo rm -f /usr/bin/see
	@sudo rm -f /bin/see
	make uninstall_success

success:
	@echo "----------------------------------------------------------------"
	@echo "----------------------------------------------------------------"
	@echo "----------------------------------------------------------------"
	@echo ""
	@echo "Success!"
	@echo "See is now installed"

uninstall_success:
	@echo "----------------------------------------------------------------"
	@echo "----------------------------------------------------------------"
	@echo "----------------------------------------------------------------"
	@echo ""
	@echo "Success!"
	@echo "See is now removed"
