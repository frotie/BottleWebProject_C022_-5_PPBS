import math
import random

class QueuingSystemMonteCarlo:
    def __init__(self, canalsCount, intensityFlowOfRequests, requestExecutionMinute, endTimeMinute):         
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


    def generateRequest(self):
        r = random.uniform(0.0001, 1)               
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

    def monteCarloMethodWithFailure(self):
        self.clearFields()
        self.endServiceMomentMinute = self.startServiceMomentMinute + self.requestExecutionMinute;
        if (self.endServiceMomentMinute > self.endTimeMinute):
            return self.servedRequestsCounter

        self.canals[0] = self.endServiceMomentMinute
        while True:
            self.requestsCounter += 1
            self.generateRequest()
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

    def monteCarloMethodWithQueue(self, maxRequestInQueue):
        self.clearFields()
        self.endServiceMomentMinute = self.startServiceMomentMinute + self.requestExecutionMinute
        queue1 = []
        if (self.endServiceMomentMinute > self.endTimeMinute):
            return self.servedRequestsCounter

        self.canals[0] = self.endServiceMomentMinute
        while True:

            self.requestsCounter += 1
            self.generateRequest()
            if (self.endServiceMomentMinute > self.endTimeMinute):
                break

            for i in range(self.canalsCount):
                if queue1.count() > 0 and self.canals[i] <= queue1[0]:
                    self.canals[i] = queue1[0] + self.requestExecutionMinute
                    self.servedRequestsCounter += 1
                    queue1.remove(0)
                    if queue1.count() < maxRequestInQueue or maxRequestInQueue is not None:
                        queue1.append(min(self.canals))
                    break

                if self.canals[i] <= self.startServiceMomentMinute:
                    self.canals[i] = self.endServiceMomentMinute
                    self.servedRequestsCounter += 1
                    break

                if i == self.canalsCount - 1 and (queue1.count() < maxRequestInQueue or maxRequestInQueue is not None):
                    queue1.append(min(self.canals))
                    break

            if self.startServiceMomentMinute >= self.endTimeMinute:
                break
        return self.servedRequestsCounter


    def getMathematicalExpectationQSWithFailure(self, repeatCount):
        result = 0
        for i in range(repeatCount):
            result += self.monteCarloMethodWithFailure()
            
        return result / repeatCount;

    def getMathematicalExpectationQSWithQueue(self, repeatCount):
        result = 0
        for i in range(repeatCount):
            result += self.monteCarloMethodWithFailure()
            
        return result / repeatCount;