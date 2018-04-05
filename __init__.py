# get correct path for datafiles when called from another directory
from builtins import filter
from builtins import map
from builtins import range
from builtins import object
from os import path
module_directory = path.abspath(path.dirname(__file__))
data_directory = path.join(module_directory, 'data')
import itertools


from fractions import gcd
from operator import mul as multiply

# This doesn't work anymore ... Ed to fix
# from smact import data_loader
import data_loader #hope this works

class Element(object):
    """Collection of standard elemental properties for given element.

    Data is drawn from "data/element.txt", part of the Open Babel
    package.

    Attributes:
        Element.symbol (string) : Elemental symbol used to retrieve data

        Element.name (string) : Full name of element

        Element.number (int) : Proton number of element

        Element.SSE (float) : Solid State Energy

        Element.oxidation_states (list) : Default list of allowed oxidation states for use in SMACT

        Element.HHI_r (float) : Hirfindahl-Hirschman Index for elemental reserves

    Raises:
        NameError: Element not found in element.txt
        Warning: Element not found in Eigenvalues.csv

    """
    def __init__(self, symbol):
        """Initialise Element class

        Args:
            symbol (str): Chemical element symbol (e.g. 'Fe')

        """

        #Ah ok so there is no lookup_element_data function in data_loader
        dataset = data_loader.lookup_element_data(symbol, copy=False)

        if dataset == None:
            raise NameError("Elemental data for {0} not found.".format(symbol))

        # Set coordination-environment data from the Shannon-radius data.
        # As above, it is safe to use copy = False with this Get* function.


        HHI_scores = data_loader.lookup_element_hhis(symbol)
        if HHI_scores == None:
            HHI_scores = (None, None)

        sse_data = data_loader.lookup_element_sse_data(symbol)
        if sse_data:
            sse = sse_data['SolidStateEnergy']
        else:
            sse = None

        for attribute, value in (
            ('HHI_r', HHI_scores[1]),
            ('name', dataset['Name']),
            ('number', dataset['Z']),
            ('oxidation_states',
             data_loader.lookup_element_oxidation_states(symbol)),
            ('SSE', sse),
            ('symbol', symbol)
            ):
            setattr(self, attribute, value)

def neutral_ratios_iter(oxidations, stoichs=False, threshold=5):
    """
    Iterator for charge-neutral stoichiometries

    Given a list of oxidation states of arbitrary length, yield ratios in which
    these form a charge-neutral compound. Stoichiometries may be provided as a
    set of legal stoichiometries per site (e.g. a known family of compounds);
    otherwise all unique ratios are tried up to a threshold coefficient.

    Args:
        oxidations : list of integers
        stoichs : stoichiometric ratios for each site (if provided)
        threshold : single threshold to go up to if stoichs are not provided

    Yields:
        tuple: ratio that gives neutrality
    """
    if not stoichs:
        stoichs = [list(range(1,threshold+1))] * len(oxidations)

    print("Stoichs: ", stoichs)
    print("Stoichs *: ", *stoichs)
    # First filter: remove combinations which have a common denominator
    # greater than 1 (i.e. Use simplest form of each set of ratios)
    # Second filter: return only charge-neutral combinations
    print("Oxidations: ",oxidations)
    return filter(

        #lambda is a way of creating anon functions - essenstial apply arguments to the expression after :
        lambda x: _isneutral(oxidations, x) and _gcd_recursive(*x) == 1,

        # Generator: enumerate all combinations of stoichiometry
        itertools.product(*stoichs)
        )

def neutral_ratios(oxidations, stoichs=False, threshold=5):
    """
    Get a list of charge-neutral compounds

    Given a list of oxidation states of arbitrary length, yield ratios in which
    these form a charge-neutral compound. Stoichiometries may be provided as a
    set of legal stoichiometries per site (e.g. a known family of compounds);
    otherwise all unique ratios are tried up to a threshold coefficient.

    Given a list of oxidation states of arbitrary length it searches for
    neutral ratios in a given ratio of sites (stoichs) or up to a given
    threshold.

    Args:
        oxidations (list of ints): Oxidation state of each site
        stoichs (list of positive ints): A selection of valid stoichiometric
            ratios for each site
        threshold (int): Maximum stoichiometry coefficient; if no 'stoichs'
            argument is provided, all combinations of integer coefficients up
            to this value will be tried.

    Returns:
        (exists, allowed_ratios) (tuple):

        exists *bool*:
            True ifc any ratio exists, otherwise False

        allowed_ratios *list of tuples*:
            Ratios of atoms in given oxidation
            states which yield a charge-neutral structure
    """
    allowed_ratios = [x for x in neutral_ratios_iter(oxidations,
                                                        stoichs=stoichs,
                                                        threshold=threshold)]
    return (len(allowed_ratios) > 0, allowed_ratios)

def _isneutral(oxidations, stoichs):
    """
    Check if set of oxidation states is neutral in given stoichiometry

    Args:
        oxidations (tuple): Oxidation states of a set of oxidised elements
        stoichs (tuple): Stoichiometry values corresponding to `oxidations`
    """
    return 0 == sum(map(multiply, oxidations, stoichs))

def _gcd_recursive(*args):
    """
    Get the greatest common denominator among any number of ints
    """
    if len(args) == 2:
        print("gcd: ", gcd(*args))
        return gcd(*args)
    else:
        return gcd(args[0], _gcd_recursive(*args[1:]))



######Testing#########


#Test calls to check if python script is behaving properly - Ed
test = Element('Be')
#Na, Ti, F
test_case1 = ['Na','Ti','F']
# test_cases = [test_case1]

# Charge neutrality + search for perovskite
max_amount = 5
# Charge neutral ratios list is empty
cn_list = []

# Iterate through each available oxidation state for each element
for ox1 in Element(test_case1[0]).oxidation_states:
    for ox2 in Element(test_case1[1]).oxidation_states:
        for ox3 in Element(test_case1[2]).oxidation_states:
            symbols = (test_case1[0], test_case1[1], test_case1[2])
            ox_states = (ox1, ox2, ox3)
            print("ox_states: ", type(ox_states));
            # Add charge neutral combos to list
            cn_e, cn_r = neutral_ratios(ox_states, threshold = max_amount)
            for i in cn_r:
                cn_list.append([(element,symbol) for element,symbol in zip(symbols,i)])

# And how many are charge neutral (to be used on the next page)
print('For elements {0},'.format(test_case1))
print('There are {0} charge neutral combinations:'.format(len(cn_list)))

for i in cn_list:
    # We want to make these look pretty.
    # e.g. [('Na', 1), ('Ti', 1), ('F', 3)] corresponds to NaTiF3 as a chemical formula.
    formula = str(i[0][0]+str(i[0][1])+i[1][0]+str(i[1][1])+i[2][0]+str(i[2][1]))
    for char in formula:
        formula = formula.replace('1','')

    # Check for perovskite-like compositions i.e. = ABX3
    if (i[0][1] == 1) and (i[1][1] == 1) and (i[2][1] == 3):
        print(formula, ' <-- Woohoo! We found a 1:1:3 ratio (perovskite)!')
    else:
        print(formula)
print('************')
print(neutral_ratios((1,1,-1)))

print('######')
# print(_isneutral((1,1,1), ))
# We want to make these look pretty.
# e.g. [('Na', 1), ('Ti', 1), ('F', 3)] corresponds to NaTiF3 as a chemical formula.

# print ("Allowable rations for Be: ",neutral_ratios(data_loader.lookup_element_oxidation_states("Be")))
