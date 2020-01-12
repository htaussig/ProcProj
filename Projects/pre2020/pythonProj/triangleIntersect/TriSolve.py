from Vertex import Vertex
from Connect import Connect

class TriSolve():
    
    #get a triangle and line in 3d space
    #converts triangle to 2d space and gets the point of intersection on that plane
    #returns a boolean from triPointIntersect
    def triPointLineIntersect(self):
        return 1
    #called by triPointLineIntersect
    #returns a boolean
    def triPointIntersect(self):
        return 1
    
    #sorts the height of a list of Connects and returns an ordered array
    #element zero is the highest Connect
    #Connects are in 2d space
    def sortHeightLines(self, connectL):
        self.precondition(type(connectL) == type([]))
        
        heightL = [connectL[0]]
        
        for i in range(1, len(connectL)):
            heightInsert(heightL, connectL[i])
        
        return 1
    
    #insert element, highest element at index 0
    #takes parameteres of a list, connect object
    def heightInsert(self, l, c):
        #why can't I change the data in l?
        return self.helperHeightInsert(l , c)
    
    def helperHeightInsert(self, l, c):
        #print(type(c))
        #self.precondition(type(c) == 'Connect')
        h = c.getHeight()
        if(l == []):
            return [c]
        elif(l[0].getHeight() < h):
            return [c] + l
        else:
            return [l[0]] + self.heightInsert(l[1:], c)
        
    
    #helpers
    
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
    
    
