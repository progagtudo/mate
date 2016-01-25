#!/usr/bin/env python
# -*- coding: utf-8 -*-


try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup


with open('README.rst') as readme_file:
    readme = readme_file.read()

with open('HISTORY.rst') as history_file:
    history = history_file.read()

requirements = [
    # TODO: put package requirements here
]

test_requirements = [
    # TODO: put package test requirements here
]

setup(
    name='M.A.T.E.',
    version='0.0.0',
    description="Description goes here...",
    long_description=readme + '\n\n' + history,
    author="Programmier-AG TU Dortmund",
    author_email='progag@lists.cs.tu-dortmund.de',
    url='matetudo.atlassian.net',
    packages=[
        'mate',
    ],
    include_package_data=True,
    install_requires=requirements,
    license="LGPL",
    zip_safe=False,
    keywords='mate',
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Programming Language :: Python :: 3.5',
    ],
    test_suite='tests',
    tests_require=test_requirements
)
