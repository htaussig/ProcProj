import unittest

from tests import Test
from Vertex import Vertex
from TriSolve import TriSolve
from Connect import Connect

def setup():
    size(400, 400, P3D)
    unittest.main()
    
def draw():
    background(0)
    #Vertex(PVector(250, 10, 10), 100).display()


class PreconditionException(Exception):
        pass

class PostconditionException(Exception):
        pass

def precondition(value_of_precondition):
  if (value_of_precondition != True):
    raise PreconditionException

def postcondition(value_of_postcondition):
  if (value_of_postcondition != True):
    raise PostconditionException
