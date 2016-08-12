#!/usr/bin/env python
# -*- coding: utf-8 -*-
from setuptools.command.test import test as TestCommand
import sys
import mate

try:
    from setuptools import setup, find_packages
except ImportError:
    from distutils.core import setup


with open('README.rst') as readme_file:
    readme = readme_file.read()

with open('HISTORY.rst') as history_file:
    history = history_file.read()

requirements = [
    # TODO: put package requirements here
]

setup(
    name='mate',
    version=mate.__version__,
    description="Description goes here...",
    long_description=readme + '\n\n' + history,
    author="Programmier-AG TU Dortmund",
    author_email='progag@lists.cs.tu-dortmund.de',
    url='matetudo.atlassian.net',
    packages=find_packages(),
    include_package_data=True,
    install_requires=requirements,
    license="LGPL",
    zip_safe=False,
    keywords='mate',
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Programming Language :: Python :: 3.5',
    ]
)
