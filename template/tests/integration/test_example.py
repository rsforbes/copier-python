"""Example integration test: replace with real ones, or delete.

Integration tests talk to real services (APIs, databases), so they are marked
`integration`, live outside the default `testpaths`, and skip themselves unless
RUN_INTEGRATION is set. Run them with:

    RUN_INTEGRATION=1 uv run pytest tests/integration -m integration
"""

import os

import pytest

pytestmark = [
    pytest.mark.integration,
    pytest.mark.skipif(
        not os.getenv("RUN_INTEGRATION"), reason="set RUN_INTEGRATION=1 to run"
    ),
]


def test_example_service():
    # e.g. call a real API or database and assert on the response
    assert True
