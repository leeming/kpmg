import sys
sys.path.insert(0, 'src')
import pytest
from kpmg_nested_obj import get_nested_values


@pytest.mark.parametrize("obj,key,expected", [({"a":{"b":{"c":"d"}}},"a", {"b":{"c":"d"}}), ({"a":{"b":{"c":"d"}}},"a/b/c","d")])
def test_expected(obj, key, expected):
    assert get_nested_values(obj, key) == expected


@pytest.mark.parametrize("obj,key,expected", [({"a":{"":{"c":"d"}}},"a//c", "d")])
def test_unusual_keys(obj, key, expected):
    assert get_nested_values(obj, key) == expected


@pytest.mark.parametrize("obj,key,", [({"a":{"b":{"c":"d"}}},"a/d")])
def test_wrong_keys(obj, key):
    with pytest.raises(KeyError):
        get_nested_values(obj, key)


@pytest.mark.parametrize("obj,key", [({},""), ("",""), (None,"a")])
def test_empty_obj(obj, key):
    with pytest.raises(LookupError):
        get_nested_values(obj, key)


@pytest.mark.parametrize("obj,key", [({'a':3},None), ({'a':3}, 10)])
def test_none_key(obj, key):
    with pytest.raises(TypeError):
        get_nested_values(obj, key)
