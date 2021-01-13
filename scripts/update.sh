#!/bin/bash
python -m pip uninstall -y ansible ansible-base
python3 -m pip uninstall -y ansible ansible-base
python3 -m pip install ansible">=2.10,<2.11"