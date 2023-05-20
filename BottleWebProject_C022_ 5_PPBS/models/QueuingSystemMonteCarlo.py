import math
import random

class QueuingSystemMonteCarlo:
    def __init__(self, canalsCount, intensityFlowOfRequests, requestExecutionMinute, endTimeMinute):
        if (canalsCount <= 0 or intensityFlowOfRequests <= 0 or requestExecutionMinute < 0 or endTimeMinute < 0):
            raise ValueError("IllegalArgumentError")
        self.canals = [0] * canalsCount
        self.canalsCount = canalsCount
        self.intensityFlowOfRequests = intensityFlowOfRequests
        self.requestExecutionMinute = requestExecutionMinute
        self.endTimeMinute = endTimeMinute
        self.startServiceMomentMinute = 0
        self.timeBetweenTwoRequestsMinute = 0
        self.endServiceMomentMinute = 0
        self.requestsCounter = 0
        self.servedRequestsCounter = 0


    def generateRequest(self, value = None):
        if (value is None): r = random.uniform(0.0001, 1)
        else: r = value
        self.timeBetweenTwoRequestsMinute = -(1.0 / self.intensityFlowOfRequests) * math.log(r)
        self.startServiceMomentMinute += self.timeBetweenTwoRequestsMinute
        self.endServiceMomentMinute = self.startServiceMomentMinute + self.requestExecutionMinute

    def clearFields(self):
        self.canals = [0] * self.canalsCount
        self.startServiceMomentMinute = 0
        self.timeBetweenTwoRequestsMinute = 0
        self.endServiceMomentMinute = 0
        self.requestsCounter = 0
        self.servedRequestsCounter = 0

    def monteCarloMethodWithFailure(self, randomData = []):
        self.clearFields()
        self.endServiceMomentMinute = self.startServiceMomentMinute + self.requestExecutionMinute;
        if (self.endServiceMomentMinute > self.endTimeMinute):
            return self.servedRequestsCounter        
        if (self.endServiceMomentMinute > self.endTimeMinute):
            return self.servedRequestsCounter

        self.canals[0] = self.endServiceMomentMinute
        self.servedRequestsCounter += 1
        self.requestsCounter += 1
        index = 0
        while True:
            self.requestsCounter += 1
            if (len(randomData) == 0 or index >= len(randomData)): 
                self.generateRequest()
            else:
                self.generateRequest(randomData[index])
                index += 1
            
            if (self.endServiceMomentMinute > self.endTimeMinute):                
                break;
            
            for i in range(self.canalsCount):                     
                if (self.canals[i] < self.startServiceMomentMinute):
                    self.canals[i] = self.endServiceMomentMinute
                    self.servedRequestsCounter += 1
                    break;

            if (self.startServiceMomentMinute >= self.endTimeMinute):
                break

        return self.servedRequestsCounter

    def monteCarloMethodWithQueue(self, maxRequestInQueue, randomData = []):
        self.clearFields()
        self.endServiceMomentMinute = self.startServiceMomentMinute + self.requestExecutionMinute
        queue1 = []        
        if (self.endServiceMomentMinute > self.endTimeMinute):
            return self.servedRequestsCounter

        self.canals[0] = self.endServiceMomentMinute
        self.servedRequestsCounter += 1
        self.requestsCounter += 1
        index = 0
        while True:

            self.requestsCounter += 1
            if (len(randomData) == 0 or index >= len(randomData)): 
                self.generateRequest()
            else:
                self.generateRequest(randomData[index])
                index += 1
            
            if (self.endServiceMomentMinute > self.endTimeMinute):
                break

            for i in range(self.canalsCount):
                if len(queue1) > 0 and self.canals[i] <= queue1[0]:
                    self.canals[i] = queue1[0] + self.requestExecutionMinute
                    self.servedRequestsCounter += 1
                    queue1.pop(0)
                    if maxRequestInQueue is None or len(queue1) < maxRequestInQueue:
                        queue1.append(min(self.canals))
                    break

                if self.canals[i] <= self.startServiceMomentMinute:
                    self.canals[i] = self.endServiceMomentMinute
                    self.servedRequestsCounter += 1
                    break

                if i == self.canalsCount - 1 and (maxRequestInQueue is None or len(queue1) < maxRequestInQueue):
                    queue1.append(min(self.canals))
                    break

            if self.startServiceMomentMinute >= self.endTimeMinute:
                break
        return self.servedRequestsCounter


    def getMathematicalExpectationQSWithFailure(self, repeatCount, randomData = [[]]):
        result = 0
        for i in range(repeatCount):
            if (len(randomData) == 0 or i >= len(randomData)): result += self.monteCarloMethodWithFailure()
            else: result += self.monteCarloMethodWithFailure(randomData[i])

            
        return result / repeatCount;

    def getMathematicalExpectationQSWithQueue(self, repeatCount, maxRequestInQueue, randomData = [[]]):
        result = 0
        if (repeatCount is None or randomData is None):
            raise TypeError("NullPointerError")
        for i in range(repeatCount):
            if (len(randomData) == 0 or i >= len(randomData)): result += self.monteCarloMethodWithQueue(maxRequestInQueue)
            else: 
                result += self.monteCarloMethodWithQueue(maxRequestInQueue, randomData[i])
               
            
        return result / repeatCount;