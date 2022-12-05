#!/usr/bin/env python


class System(object):

    """Defines remote HPC system"""

    __slots__ = ("_name",)

    def __init__(self, name):
        """Initializes system by trying to connect

        :name: Name of system to connect to

        """
        self._name = name


