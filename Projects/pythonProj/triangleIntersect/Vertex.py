class Vertex():
    
    def __init__(self, pos, r):
        self.pos = pos
        self.r = r
        
    def __init__(self, pos):
        self.pos = pos
        self.r = 100
        
    def getHeight(self):
        return self.pos.y
        
    def display(self):
        noStroke()
        fill(255)
        pushMatrix()
        translate(self.pos.x, self.pos.y, self.pos.z)
        sphere(self.r)
        popMatrix()
