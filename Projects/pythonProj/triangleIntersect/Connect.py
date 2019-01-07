class Connect():
    def __init__(self, v1, v2):
        self.v1 = v1
        self.v2 = v2
        
    def getHeight(self):
        return (self.v1.getHeight() + self.v2.getHeight()) / 2.0
        
    #if any connects had the same position, they would have to be referencing
    #the same vertexes in this program
    def __eq__(self, other):
        if(self.v1 == other.v1 and self.v2 == other.v2):
            return True
        if(self.v1 == other.v2 and self.v2 == other.v1):
            return True
        return False
        
