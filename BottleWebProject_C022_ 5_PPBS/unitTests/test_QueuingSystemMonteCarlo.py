import unittest
from models.QueuingSystemMonteCarlo import QueuingSystemMonteCarlo

class Test_test_QueuingSystemMonteCarlo(unittest.TestCase):
    def test_monteCarloMethodWithFailure_ReturnsServedRequestsCount0(self):
        expected = 0
        canalsCount = 1
        intensityFlowOfRequests = 1 
        requestExecutionMinute = 1
        endTimeMinute = 0
        qs = QueuingSystemMonteCarlo(canalsCount, intensityFlowOfRequests, requestExecutionMinute, endTimeMinute)        
        actual = qs.monteCarloMethodWithFailure()
        self.assertEqual(expected, actual)

    def test_monteCarloMethodWithFailure_ReturnsServedRequestsCount8(self):
        expected = 8
        canalsCount = 2
        intensityFlowOfRequests = 4 
        requestExecutionMinute = 1
        endTimeMinute = 6
        randomData = [0.433127118442817, 0.147398306969176, 0.140886785250458, 0.624075090867704, 0.842161961673678,
                      0.467499601293727, 0.0100349948838334, 0.834529991503713, 0.780888520882574, 0.443250584911679,
                      0.647099725944487, 0.284808072301115, 0.556989353295255, 0.280566293124813, 0.134339574644093,
                      0.564246266297666, 0.737934837248049, 0.720646480532744, 0.743927924226483, 0.256818787310138,
                      0.0652560037386257, 0.406926587054207]
        qs = QueuingSystemMonteCarlo(canalsCount, intensityFlowOfRequests, requestExecutionMinute, endTimeMinute)        
        actual = qs.monteCarloMethodWithFailure(randomData)
        self.assertEqual(expected, actual)    

    def test_monteCarloMethodWithFailure_ReturnsMathematicalExpectation9(self):
            expected = 9
            canalsCount = 2
            intensityFlowOfRequests = 4 
            requestExecutionMinute = 1
            endTimeMinute = 6
            randomData = [
                          [0.433127118442817, 0.147398306969176, 0.140886785250458, 0.624075090867704, 0.842161961673678,
                           0.467499601293727, 0.0100349948838334, 0.834529991503713, 0.780888520882574, 0.443250584911679,
                           0.647099725944487, 0.284808072301115, 0.556989353295255, 0.280566293124813, 0.134339574644093,
                           0.564246266297666, 0.737934837248049, 0.720646480532744, 0.743927924226483, 0.256818787310138,
                           0.0652560037386257, 0.406926587054207],
                          [0.42014517202705, 0.0257474083441634, 0.173453466070415, 0.469980532615789, 0.896501653055935,
                           0.574195043175095, 0.365170639331275, 0.883207706477389, 0.349759020595234, 0.256623642559352,
                           0.13998891465152, 0.911423910034244, 0.455585575988971, 0.754416735386813, 0.868025529952248,
                           0.215570827532361, 0.109850965258734, 0.346689486202845, 0.514860423483426, 0.0561439823223822,
                           0.757513145455088, 0.419112243190009],
                          [0.147762117917857, 0.235255206692816, 0.326842570141065, 0.662054088095635, 0.315733603553143,
                           0.408899394509069, 0.521668680737184, 0.711156266545438, 0.830409996940205, 0.619604373839479,
                           0.076823843742992, 0.406734639480414, 0.511277432236623, 0.555450937826464, 0.234581498045167,
                           0.312662395906786, 0.70168325218441, 0.133305844096592, 0.161425016940845, 0.0344619870148627,
                           0.639534161525288, 0.939245326103878],
                          [0.435996821134792, 0.338995025387506, 0.444816855698304, 0.336220934148377, 0.238609399474494,
                           0.364811214006456, 0.992497735857367, 0.970605107771689, 0.0134783899042069, 0.773813061284735,
                           0.402250351139002, 0.0492619133922477,0.522771216095523, 0.171128984282891, 0.286404711982729,
                           0.556736212164014, 0.84893966373326, 0.676168956055683, 0.14228406904, 0.279198362442225,
                           0.314752844768595, 0.766590660674803],
                          [0.909309096820615, 0.591898489126608, 0.846401756771533, 0.70048063237924, 0.990182268582318,
                           0.617764928726381, 0.085832177610751, 0.0019527046561304, 0.1886573285662, 0.443479441989035,
                           0.821874941484397, 0.452085705777336, 0.583337925771257, 0.343546579692496, 0.816422091042129,
                           0.16516182468072, 0.372665529977627, 0.93061272747495, 0.168310761918401, 0.342547591649444,
                           0.082260270955564, 0.834923563179251],
                          [0.91303458064167, 0.0241963750141895, 0.343135947388317, 0.505785302895824, 0.843808750800646,
                           0.740481433345199, 0.18049773484345, 0.979978631701432, 0.402699639796471, 0.409661263001202,
                           0.293007129308403, 0.416024530249755, 0.0919151172035039, 0.475387978395466, 0.314698980091359,
                           0.741740894266554, 0.0966090209637157, 0.603764765964155, 0.727546884754965, 0.340666708879687,
                           0.0727592240498668, 0.275360381176619]
                         ]
            qs = QueuingSystemMonteCarlo(canalsCount, intensityFlowOfRequests, requestExecutionMinute, endTimeMinute)                
            actual = qs.getMathematicalExpectationQSWithFailure(len(randomData), randomData)
            self.assertEqual(expected, actual)

    def test_getMathematicalExpectationQSWithFailure_RaiseExceptionValueError(self):
        canalsCount = 1
        intensityFlowOfRequests = 1
        requestExecutionMinute = 1
        endTimeMinute = 6
        qs = QueuingSystemMonteCarlo(canalsCount, intensityFlowOfRequests, requestExecutionMinute, endTimeMinute)
        repeatCount = None
        randomData = None
        self.assertRaises(TypeError, qs.getMathematicalExpectationQSWithFailure, repeatCount, randomData)

    def test_QueuingSystemMonteCarloConstructor_RaiseExceptionValueError(self):
        canalsCount = 0
        intensityFlowOfRequests = 0
        requestExecutionMinute = 0
        endTimeMinute = 0
        self.assertRaises(ValueError, QueuingSystemMonteCarlo, canalsCount, intensityFlowOfRequests, requestExecutionMinute, endTimeMinute)        

if __name__ == '__main__':
    unittest.main()
