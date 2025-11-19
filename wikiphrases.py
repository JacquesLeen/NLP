#!/usr/bin/env python
import fire
from nlp_logic import corenlp

if __name__ == "__main__":
    fire.Fire(corenlp.get_phrases)