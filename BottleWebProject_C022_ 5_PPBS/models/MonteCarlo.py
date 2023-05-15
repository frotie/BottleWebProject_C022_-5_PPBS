import enum
from random import random
import math

class ConnectionType(enum.Enum):
    Parallel = 0
    Consistent = 1

class WorkingBlock:

    def __init__(self, probability):
        self.probabilityValue = probability

    def experience(self):
        return random() < self.probabilityValue
    
    def probability(self):
        return self.probabilityValue

class Node:

    def __init__(self, connectionType):
        self.elements = []
        self.connectionType = connectionType

    def addElement(self, block):
        self.elements.append(block)
        
    def probability(self):
        if len(self.elements) == 0:
            return 1.0
        if self.connectionType == ConnectionType.Parallel:
            d = (1 - e.probability() for e in self.elements)
            return 1 - math.prod(d)
        else:
            return math.prod(e.probability() for e in self.elements)

    def experience(self):
        if self.connectionType == ConnectionType.Parallel:
            return any(x.experience() for x in self.elements)
        else:
            return all(x.experience() for x in self.elements)