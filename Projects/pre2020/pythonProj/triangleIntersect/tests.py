import unittest
from TriSolve import TriSolve
from Vertex import Vertex
from TriSolve import TriSolve
from Connect import Connect

class Test(unittest.TestCase):

    # Test for warmup (showing how to use pre/postconditions)
    def test_warmup(self):
        self.assertEqual(1, 1)
        
    def test_triPointIntersect(self):
        t = TriSolve()
        self.assertEqual(t.triPointIntersect(), 1)
        
    def test_heightInsert(self):
        t = TriSolve()
        p1 = PVector(12, 10)
        p2 = PVector(10, 20)
        p3 = PVector(20, 29)
        v1 = Vertex(p1)
        v2 = Vertex(p2)
        v3 = Vertex(p3)
        
        c1 = Connect(v1, v2)
        c2 = Connect(v1, v3)
        c3 = Connect(v2, v3)
        
        l = []
        l = t.heightInsert(l, c3)
        self.assertEqual(l, [c3])
        l = t.heightInsert(l, c1)
        self.assertEqual(l, [c1, c3])
        l = t.heightInsert(l, c2)
        self.assertEqual(l, [c1, c2, c3])
        
    def test_Connect__eq__(self):
        p = PVector(12, 10)
        p1 = PVector(20, 20)
        p2 = PVector(20, 20)
        v1 = Vertex(p)
        v2 = Vertex(p1)
        
        c1 = Connect(v1, v2)
        c2 = Connect(v2, v1)
        c3 = Connect(v1, v2)
        
        self.assertEqual(c1, c2)
        self.assertEqual(c1, c3)
        self.assertEqual(c1 == Connect(v1, v2), True)
        
        #same coordinates, but not referring to the same Vertex object
        self.assertEqual(c1 == Connect(v1, Vertex(p1)), False)
        self.assertEqual(Connect(v1, Vertex(p1)) == Connect(v1, Vertex(p1)), False)
        
        
        
