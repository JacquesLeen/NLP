"""
Test module for the nlp logic library.
"""

from nlp_logic import corenlp



def test_get_wikipedia_summary(name="Golden State Warriors"):
    """
    Test fetching a summary from Wikipedia.
    Args:
        name (str): The name of the Wikipedia article to fetch.
    Asserts:
        The summary contains the name.
    """
    summary = corenlp.get_wikipedia_summary(name)
    assert name in summary
