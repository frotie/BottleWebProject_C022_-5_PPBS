import enum
from random import random
import math
from abc import ABC, abstractmethod

class ConnectionType(enum.Enum):
    """ Тип соединения между блоками или элементами в блоке """

    Parallel = 0
    Consistent = 1

class AbstractBlock(ABC):
    """ Абстрактный элемент системы для расчета аналитической вероятности и проведения испытания """

    @abstractmethod
    def experience(self):
        """ Проведение испытания над элементом системы """
        pass
    
    @abstractmethod
    def analyticalProbability(self):
        """ Вычисление аналитической вероятности срабатывания элемента """
        pass

class WorkingBlock(AbstractBlock):
    """ Базовый элемент системы с известной аналитической вероятностью """

    def __init__(self, probability):
        """ Конструктор, установка аналитической вероятности """
        self.probabilityValue = probability

    def experience(self):
        """ Проведение испытания """
        return random() < self.probabilityValue
    
    def analyticalProbability(self):
        """ Возвращает аналитическую вероятность """
        return self.probabilityValue

class Node(AbstractBlock):
    """ Блок соединяющий другие элементы системы """

    def __init__(self, connectionType):
        """ Конструктор, установка типа соединения """
        self.elements = []
        self.connectionType = connectionType

    def addElement(self, block):
        """ Добавление элемента в блок """
        self.elements.append(block)
        
    def analyticalProbability(self):
        """ Вычисление аналитической вероятности срабатывания всех элементов в блоке """
        if len(self.elements) == 0:
            return 1.0
        if self.connectionType == ConnectionType.Parallel:
            d = (1 - e.analyticalProbability() for e in self.elements)
            return 1 - math.prod(d)
        else:
            return math.prod(e.analyticalProbability() for e in self.elements)
            
    def experience(self):
        """ Проведение испытания над элементами блока """
        if self.connectionType == ConnectionType.Parallel:
            return any(x.experience() for x in self.elements)
        else:
            return all(x.experience() for x in self.elements)

    def empiricalProbability(self, triesCount):
        """ Вычисление эмпирической вероятности """
        return sum(self.experience() for x in range(triesCount)) / triesCount

    def getErrorRate(self, triesCount):
        """ Вычисление абсолютной погрешности """
        analitical = self.analyticalProbability()
        empirical = self.empiricalProbability(triesCount)

        return abs(analitical - empirical)
