import enum
from random import random
import math
from abc import ABC, abstractmethod

class ConnectionType(enum.Enum):
    Parallel = 0
    Consistent = 1

class AbstractBlock(ABC):
    @abstractmethod
    def experience(self):
        pass
    
    @abstractmethod
    def analyticalProbability(self):
        pass

class WorkingBlock(AbstractBlock):

    def __init__(self, probability):
        self.probabilityValue = probability

    def experience(self):
        return random() < self.probabilityValue
    
    def analyticalProbability(self):
        return self.probabilityValue

class Node(AbstractBlock):

    def __init__(self, connectionType):
        self.elements = []
        self.connectionType = connectionType

    def addElement(self, block):
        self.elements.append(block)
        
    def analyticalProbability(self):
        if len(self.elements) == 0:
            return 1.0
        if self.connectionType == ConnectionType.Parallel:
            d = (1 - e.analyticalProbability() for e in self.elements)
            return 1 - math.prod(d)
        else:
            return math.prod(e.analyticalProbability() for e in self.elements)
            
    def experience(self):
        if self.connectionType == ConnectionType.Parallel:
            return any(x.experience() for x in self.elements)
        else:
            return all(x.experience() for x in self.elements)

    def empiricalProbability(self, triesCount):
        return sum(self.experience() for x in range(triesCount)) / triesCount

    def getErrorRate(self, triesCount):
        analitical = self.analyticalProbability()
        empirical = self.empiricalProbability(triesCount)

        return abs(analitical - empirical)
