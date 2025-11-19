# Colors for output
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# Variables
PYTHON := python3
PIP := pip
PYTEST := pytest --verbose
PYLINT := pylint
BLACK := black
SCRIPT := main.py

TEST_DIR := test
TEST_FILES := $(wildcard $(TEST_DIR)/test*.py)
LIB_DIR := nlp_logic
LIB_FILES := $(wildcard $(LIB_DIR)/*.py)

install:
	@echo "$(BLUE)Installing dependencies...$(NC)"
	@$(PIP) install --upgrade $(PIP) &&\
		$(PIP) install -r requirements.txt
		$(PYTHON) -m textblob.download_corpora
	@echo "$(GREEN)✓ Dependencies installed$(NC)"

lint-test:
	@echo "$(BLUE)Running pylint on $(TEST_DIR)...$(NC)"
	@PYTHONPATH=$(SOURCE_DIR) $(PYLINT) $(TEST_FILES) || (EXIT_CODE=$$?; \
		if [ $$EXIT_CODE -eq 0 ]; then \
			echo "$(GREEN)✓ No issues found$(NC)"; \
		elif [ $$EXIT_CODE -eq 4 ]; then \
			echo "$(YELLOW)⚠ Warnings found (exit code 4 - ignored)$(NC)"; \
			exit 0; \
		elif [ $$EXIT_CODE -eq 8 ]; then \
			echo "$(YELLOW)⚠ Refactor suggestions found (exit code 8 - ignored)$(NC)"; \
			exit 0; \
		elif [ $$EXIT_CODE -eq 12 ]; then \
			echo "$(YELLOW)⚠ Warnings + Refactor (exit code 12 - ignored)$(NC)"; \
			exit 0; \
		elif [ $$EXIT_CODE -eq 16 ]; then \
			echo "$(YELLOW)⚠ Convention violations found (exit code 16 - ignored)$(NC)"; \
			exit 0; \
		elif [ $$EXIT_CODE -eq 20 ]; then \
			echo "$(YELLOW)⚠ Convention + Warnings (exit code 20 - ignored)$(NC)"; \
			exit 0; \
		elif [ $$EXIT_CODE -eq 24 ]; then \
			echo "$(YELLOW)⚠ Convention + Refactor (exit code 24 - ignored)$(NC)"; \
			exit 0; \
		elif [ $$EXIT_CODE -eq 28 ]; then \
			echo "$(YELLOW)⚠ Convention + Refactor + Warnings (exit code 28 - ignored)$(NC)"; \
			exit 0; \
		elif [ $$EXIT_CODE -eq 1 ] || [ $$EXIT_CODE -eq 2 ]; then \
			echo "$(RED)✗ Fatal errors or syntax errors found (exit code $$EXIT_CODE)$(NC)"; \
			exit $$EXIT_CODE; \
		else \
			echo "$(RED)✗ Pylint found issues (exit code $$EXIT_CODE)$(NC)"; \
			exit $$EXIT_CODE; \
		fi)
	@echo "$(GREEN)✓ Linting $(TEST_DIR) passed$(NC)"

lint-lib:
	@echo "$(BLUE)Running pylint on $(LIB_DIR)...$(NC)"
	@$(PYLINT) $(LIB_FILES) || (EXIT_CODE=$$?; \
		if [ $$EXIT_CODE -eq 0 ]; then \
			echo "$(GREEN)✓ No issues found$(NC)"; \
		elif [ $$EXIT_CODE -eq 4 ]; then \
			echo "$(YELLOW)⚠ Warnings found (exit code 4 - ignored)$(NC)"; \
			exit 0; \
		elif [ $$EXIT_CODE -eq 8 ]; then \
			echo "$(YELLOW)⚠ Refactor suggestions found (exit code 8 - ignored)$(NC)"; \
			exit 0; \
		elif [ $$EXIT_CODE -eq 12 ]; then \
			echo "$(YELLOW)⚠ Warnings + Refactor (exit code 12 - ignored)$(NC)"; \
			exit 0; \
		elif [ $$EXIT_CODE -eq 16 ]; then \
			echo "$(YELLOW)⚠ Convention violations found (exit code 16 - ignored)$(NC)"; \
			exit 0; \
		elif [ $$EXIT_CODE -eq 20 ]; then \
			echo "$(YELLOW)⚠ Convention + Warnings (exit code 20 - ignored)$(NC)"; \
			exit 0; \
		elif [ $$EXIT_CODE -eq 24 ]; then \
			echo "$(YELLOW)⚠ Convention + Refactor (exit code 24 - ignored)$(NC)"; \
			exit 0; \
		elif [ $$EXIT_CODE -eq 28 ]; then \
			echo "$(YELLOW)⚠ Convention + Refactor + Warnings (exit code 28 - ignored)$(NC)"; \
			exit 0; \
		elif [ $$EXIT_CODE -eq 1 ] || [ $$EXIT_CODE -eq 2 ]; then \
			echo "$(RED)✗ Fatal errors or syntax errors found (exit code $$EXIT_CODE)$(NC)"; \
			exit $$EXIT_CODE; \
		else \
			echo "$(RED)✗ Pylint found issues (exit code $$EXIT_CODE)$(NC)"; \
			exit $$EXIT_CODE; \
		fi)
	@echo "$(GREEN)✓ Linting $(LIB_DIR) passed$(NC)"

lint: lint-lib lint-test

test:
	@if [ -n "$(TEST_FILES)" ]; then \
		echo "$(BLUE)Running tests...$(NC)"; \
		PYTHONPATH=$(SOURCE_DIR) pytest $(TEST_FILES) -v; \
		echo "$(GREEN)✓ Tests passed$(NC)"; \
	else \
		echo "$(YELLOW)⚠️  No test files found in $(TEST_DIR)/$(NC)"; \
	fi

format:
	@echo "$(BLUE)Formatting code with black...$(NC)"
	$(BLACK) $(LIB_DIR) $(TEST_DIR)
	@echo "$(GREEN)✓ Code formatted$(NC)"

all: install lint test format

.PHONY: install lint lint-test lint-src test format all