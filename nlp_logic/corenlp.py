"""
Library for interacting with Wikipedia and textblob.
"""

from textblob import TextBlob
import wikipedia


def search_wikipedia(name: str):
    """
    Search for a name on Wikipedia and return search results.
    Args:
        name (str): The name to search for.
    Returns:
        list: A list of search results from Wikipedia.
    """
    print(f"Searching for {name} on Wikipedia...")
    return wikipedia.search(name)


def get_wikipedia_summary(name: str):
    """
    Get the summary of a Wikipedia article by name.
    Args:
        name (str): The name of the Wikipedia article.
    Returns:
        str: The summary of the Wikipedia article.
    """
    print(f"Getting summary for {name} from Wikipedia...")
    return wikipedia.summary(name)


def get_text_blob(text: str):
    """
    Create a TextBlob object from the given text.
    Args:
        text (str): The input text.
    Returns:
        TextBlob: A TextBlob object for text processing.
    """
    print("Creating TextBlob for the given text...")
    return TextBlob(text)


def get_phrases(name):
    """
    Get noun phrases from the Wikipedia summary of a given name.
    Args:
        name (str): The name to search for.
    Returns:
        list: A list of noun phrases extracted from the summary.
    """
    text = get_wikipedia_summary(name)
    blob = get_text_blob(text)
    return blob.noun_phrases
