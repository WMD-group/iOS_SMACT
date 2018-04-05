"""
Provide data from text files while transparently caching for efficiency

This module handles the loading of external data used to initialise the
core smact.Element and smact.Species classes.  It implements a
transparent data-caching system to avoid a large amount of I/O when
naively constructing several of these objects.  It also implements a
switchable system to print verbose warning messages about possible
missing data (mainly for debugging purposes).
"""
from __future__ import print_function #__future__ ?

#assuming these packages are all part of python
from builtins import next
from builtins import map
from builtins import zip
import csv
import os

#Ok so this doesn't work anymore .... understandbly
# from smact import data_directory

# Module-level switch: print "verbose" warning messages
# about missing data.
_print_warnings = False
data_directory = "data"; #path to data files


def set_warnings(enable=True):
    """Set verbose warning messages on and off.

    In order to see any of the warnings, this function needs to be
    called _before_ the first call to the smact.Element()
    constructor.

    Args:
    enable (bool) : print verbose warning messages.
    """

    global _print_warnings
    _print_warnings = enable


def _get_data_rows(filename):
    """Generator for datafile entries by row"""
    with open(filename, 'r') as file:
        for line in file:
            line = line.strip()
            if line[0] != '#':
                yield line.split()

def float_or_None(x):
    """Cast a string to a float or to a None"""
    try:
        return float(x)
    except ValueError:
        return None

# Loader and cache for elemental data

_element_data = None

def lookup_element_data(symbol, copy=True):
    """
    Retrieve tabulated data for an element.

    The table "data/element_data.txt" contains a collection of relevant
    atomic data. If a cache exists in the form of the module-level
    variable _element_data, this is returned. Otherwise, a dictionary is
    constructed from the data table and cached before returning it.

    Args:
        symbol (str) : Atomic symbol for lookup

        copy (Optional(bool)) : if True (default), return a copy of the
            data dictionary, rather than a reference to the cached
            object -- only used copy=False in performance-sensitive code
            and where you are certain the dictionary will not be
            modified!

    Returns (dict): Dictionary of data for given element, keyed by
        column headings from data/element_data.txt
    """
    global _element_data
    if _element_data is None:
        _element_data = {}
        keys = ('Symbol', 'Name', 'Z', 'Mass', 'r_cov', 'e_affinity',
                'p_eig', 's_eig', 'Abundance', 'el_neg', 'ion_pot')
        for items in _get_data_rows(os.path.join(data_directory,
                                                 "element_data.txt")):
            # First two columns are strings and should be left intact
            # Everything else is numerical and should be cast to a float
            # or, if not clearly a number, to None
            clean_items = items[0:2] + list(map(float_or_None, items[2:]))

            _element_data.update({items[0]:
                                  dict(list(zip(keys, clean_items)))})

    if symbol in _element_data:
        if copy:
            # _element_open_babel_derived_data stores dictionaries
            # -> if copy is set, use the dict.copy() function to return
            # a copy. The values are all Python "value types", so
            # explicitly cloning the elements is not necessary to make
            # a deep copy.

            return _element_data[symbol].copy()
        else:
            return _element_data[symbol]
    else:
        if _print_warnings:
            print("WARNING: Elemental data for {0}"
                  " not found.".format(symbol))
            print(_element_data)
        return None


# Loader and cache for the element oxidation-state data.
_el_ox_states = None

def lookup_element_oxidation_states(symbol, copy=True):
    """
    Retrieve a list of known oxidation states for an element.
    The oxidation states list used is the SMACT default and
    most exhaustive list.

    Args:
        symbol (str) : the atomic symbol of the element to look up.
        copy (Optional(bool)): if True (default), return a copy of the
            oxidation-state list, rather than a reference to the cached
            data -- only use copy=False in performance-sensitive code
            and where the list will not be modified!

    Returns:
        list: List of known oxidation states for the element.

            Return None if oxidation states for the Element were not
            found in the external data.
    """

    global _el_ox_states
    #data_directory = "data" #consider changing this? couldn't rely on smact

    if _el_ox_states is None:
        _el_ox_states = {}

        for items in _get_data_rows(os.path.join(data_directory,
                                                 "oxidation_states.txt")):
            _el_ox_states[items[0]] = [int(oxidationState)
                                       for oxidationState in items[1:]]

    if symbol in _el_ox_states:
        if copy:
            # _el_ox_states stores lists -> if copy is set, make an implicit
            # deep copy.  The elements of the lists are integers, which are
            # "value types" in Python.

            return [oxidationState for oxidationState in _el_ox_states[symbol]]
        else:
            return _el_ox_states[symbol]
    else:
        if _print_warnings:
            print("WARNING: Oxidation states for element {0} "
                  "not found.".format(symbol))
        return None

# Loader and cache for the element HHI scores.
_element_hhis = None

def lookup_element_hhis(symbol):
    """
    Retrieve the HHI_R and HHI_p scores for an element.

    Args:
        symbol : the atomic symbol of the element to look up.

    Returns:
        A (HHI_p, HHI_R) tuple, or None if values for the elements were
        not found in the external data.
    """

    global _element_hhis

    if _element_hhis is None:
        _element_hhis = {}

        with open(os.path.join(data_directory, "HHIs.txt"),
                  'r') as file:
            for line in file:
                line = line.strip()

                if line[0] != '#':
                    items = line.split()

                    _element_hhis[items[0]] = (float(items[1]),
                                               float(items[2]))

    if symbol in _element_hhis:
        return _element_hhis[symbol]
    else:
        if _print_warnings:
            print("WARNING: HHI data for element "
                  "{0} not found.".format(symbol))

        return None

# Loader and cache for the element solid-state energy (SSE) datasets.
_element_sse_data = None

def lookup_element_sse_data(symbol):
    """
    Retrieve the solid-state energy (SSE) data for an element.

    Taken from J. Am. Chem. Soc., 2011, 133 (42), pp 16852-16960,
    DOI: 10.1021/ja204670s

    Args:
        symbol : the atomic symbol of the element to look up.

    Returns:
        A dictionary containing the SSE dataset for the element, or None
        if the element was not found among the external data.
    """

    global _element_sse_data

    if _element_sse_data is None:
        _element_sse_data = {}

        with open(os.path.join(data_directory, "SSE.csv"),
                  'rU') as file:
            reader = csv.reader(file)

            for row in reader:
                dataset = {
                    'SolidStateEnergy': float(row[1])}

                _element_sse_data[row[0]] = dataset

    if symbol in _element_sse_data:
        return _element_sse_data[symbol]
    else:
        if _print_warnings:
            print("WARNING: Solid-state energy data "
                  " element {0} not found.".format(symbol))

        return None



#Temp calls for testing - Ed
#look_up_element_oxidation_states now works without smact!
# print("*** FROM DATA LOADER.PY ***")
# print("Oxidation statse of Be: ", lookup_element_oxidation_states("Be"))
# print("HHI_R and HHI_p scores of Be: ", lookup_element_hhis("Be"))
# print("solid-state energy (SSE) for Be: ", lookup_element_sse_data("Be"))
_get_data_rows('data/element_data.txt');
