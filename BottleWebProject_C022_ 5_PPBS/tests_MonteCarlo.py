import unittest
from models.MonteCarlo import WorkingBlock, Node, ConnectionType

class tests_MonteCarlo(unittest.TestCase):

    def test_ConsistentNodeWithOneElement_ReturnsElementProbability(self):
        prob = 0.7
        block = WorkingBlock(prob)
        node = Node(ConnectionType.Consistent)
        node.addElement(block)

        actual = node.probability()

        self.assertEqual(prob, actual)

    def test_ParallelNodeWithOneElement_ReturnsElementProbability(self):
        prob = 0.7
        block = WorkingBlock(prob)
        node = Node(ConnectionType.Parallel)
        node.addElement(block)

        actual = node.probability()

        self.assertEqual(prob, actual)

    def test_ParallelNodeWithTwoSameElements_ReturnsElementProbability(self):
        prob = 0.7
        block1 = WorkingBlock(prob)
        block2 = WorkingBlock(prob)
        node = Node(ConnectionType.Parallel)
        node.addElement(block1)
        node.addElement(block2)
        expected = 1 - (1 - prob) * (1 - prob)

        actual = node.probability()

        self.assertEqual(expected, actual)

    def test_ConsistentNodeWithTwoSameElements_ReturnsElementProbability(self):
        prob = 0.7
        block1 = WorkingBlock(prob)
        block2 = WorkingBlock(prob)
        node = Node(ConnectionType.Consistent)
        node.addElement(block1)
        node.addElement(block2)
        expected = prob * prob

        actual = node.probability()

        self.assertEqual(expected, actual)
        
    
    def test_NodeWithSimpleNodeInside_InternalBlockProbReturned(self):
        prob = 0.7
        block = WorkingBlock(prob)
        baseNode = Node(ConnectionType.Consistent)
        childNode = Node(ConnectionType.Consistent)
        baseNode.addElement(childNode)
        childNode.addElement(block)
        expected = prob

        actual = baseNode.probability()

        self.assertEqual(expected, actual)

    def test_ConsistentNodeWithParallelsNodes(self):
        node1 = Node(ConnectionType.Parallel)
        node1.addElement(WorkingBlock(0.7))
        node1.addElement(WorkingBlock(0.7))
        node1ExpectedProb = 1 - (1 - node1.elements[0].probability()) * (1 - node1.elements[1].probability())

        node2 = Node(ConnectionType.Parallel)
        node2.addElement(WorkingBlock(0.7))
        node2.addElement(WorkingBlock(0.7))
        node2ExpectedProb = 1 - (1 - node2.elements[0].probability()) * (1 - node2.elements[1].probability())

        node3 = Node(ConnectionType.Consistent)
        node3.addElement(node1)
        node3.addElement(node2)
        expected = node1ExpectedProb * node2ExpectedProb

        actual = node3.probability()

        self.assertEqual(expected, actual)

    def test_SimpleExperienceTest(self):
        prob = 0.7
        node = Node(ConnectionType.Parallel)
        node.addElement(WorkingBlock(prob))
        node.addElement(WorkingBlock(prob))

        tries = 1000;
        goodTimes = 0
        for i in range(tries):
            if node.experience():
                goodTimes += 1

        self.assertAlmostEqual(node.probability(), goodTimes / tries, 0)

if __name__ == '__main__':
    unittest.main()