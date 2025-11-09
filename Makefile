SHELL := /bin/bash
.DEFAULT_GOAL := help

EXPORT_DIR ?= exported_txt
BASE ?= .
UNIFIED ?= 3

# PHONY
.PHONY: help export-code-txt clean-export

# ------------------------------------------------
# Help
# ------------------------------------------------
help:
	@echo "------------------------------------------------------------------"
	@echo " Available commands:"
	@echo "------------------------------------------------------------------"
	@echo " Code export:"
	@echo " make export-code-txt                               -> Export all .cs files to text under $(EXPORT_DIR) (short names)."
	@echo " make clean-export                                  -> Remove the export dir ($(EXPORT_DIR))."
	@echo "------------------------------------------------------------------"
	@echo "Variables (override): EXPORT_DIR, BASE, UNIFIED"
	@echo "Example: make export-code-txt EXPORT_DIR=my_txt BASE=dev"
	@echo "------------------------------------------------------------------"


# ------------------------------------------------
# Export all files recursively
# ------------------------------------------------
export-code-txt:
	@echo "-> Exporting source files recursively..."
	@mkdir -p $(EXPORT_DIR)
	@find . \
		-type f \( -name "*.java" -o -name "*.xml" -o -name "*.yml" -o -name "*.md" \) \
		! -path "*/.*/*" \
		! -name ".*" \
		> $(EXPORT_DIR)/file_list.txt

	@echo "-> Merging all files into $(EXPORT_DIR)/merged.txt..."
	@rm -f $(EXPORT_DIR)/merged.txt
	@cat $(EXPORT_DIR)/file_list.txt | while read f; do \
		echo "------------------------------------------------------------" >> $(EXPORT_DIR)/merged.txt; \
		echo "$$f" >> $(EXPORT_DIR)/merged.txt; \
		echo "------------------------------------------------------------" >> $(EXPORT_DIR)/merged.txt; \
		cat "$$f" >> $(EXPORT_DIR)/merged.txt; \
		echo "\n\n" >> $(EXPORT_DIR)/merged.txt; \
	done
	@echo "(OK) Export completed: $(EXPORT_DIR)/merged.txt"

# ------------------------------------------------
# Clean export directory
# ------------------------------------------------
clean-export:
	@rm -rf $(EXPORT_DIR)
	@echo "(OK) Export directory removed."