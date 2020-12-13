# Challenge #3

We have a nested object, we would like a function that you pass in the object and a key and get back the value

## Solution

Main function `get_nested_values(obj, key)` created in python. 

### Virtualenv
It is assumed virtualenv is installed on the host

Create a virtualenv and activate it, e.g. on a Debian/Ubunutu based os do the following:
```
virtualenv -p /usr/bin/python3 venv

source venv/bin/activate
```

### Install dependencies


To be able to run the test suite install the dev dependencies and run pytest
```
pip install -r requirements-dev.txt
pip install -e .
pytest tests/test_app.py
```

### Run Tests

To be able to run the test suite install the dev dependencies and run pytest
```
pip install -r requirements-dev.txt
pip install -e .
pytest tests/test_app.py
```
