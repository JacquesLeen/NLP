"""Pytest configuration."""

import sys
from pathlib import Path

# Get the absolute path to nlp_logic directory
nlp_lib_path = Path(__file__).parent.parent / "nlp_logic"
print(f"DEBUG: nlp_lib_path = {nlp_lib_path}")
print(f"DEBUG: nlp_lib_path exists = {nlp_lib_path.exists()}")

if nlp_lib_path.exists():
    sys.path.insert(0, str(nlp_lib_path))
    print(f"DEBUG: Added {nlp_lib_path} to sys.path")
else:
    print(f"ERROR: nlp_logic directory not found at {nlp_lib_path}")
    raise FileNotFoundError(f"nlp_logic directory not found at {nlp_lib_path}")