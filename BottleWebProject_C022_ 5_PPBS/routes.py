"""
Routes and views for the bottle application.
"""

from models.MonteCarlo import WorkingBlock, Node, ConnectionType
from models.QueuingSystemMonteCarlo import QueuingSystemMonteCarlo
from bottle import route, view, post, request, response, template
from datetime import datetime
import json


@route('/')
@route('/home')
@view('index')
def home():
    """ Отображение главной страницы """
    return dict(
        year=datetime.now().year
    )

@route('/about')
@view('about')
def about():
    """ Отображение страницы об авторах """
    return dict(
        year=datetime.now().year
    )

@route('/ons/<variant>')
@view('ons')
def ons(variant):
    """ Отображение ОНС по вариантам """
    firstVariant = variant == '1'
    return dict(year=datetime.now().year, firstBlock = 3 if firstVariant else 2, secondBlock = 2 if firstVariant else 3)

@route('/smoqueue')
@view('smoqueue')
def smo():
    return dict(year=datetime.now().year, canalsCount = "", intensityFlowOfRequests = "", requestExecutionMinute = "",
                endTimeMinute = "", repeatCount = "", requestInQueue = "",result = "")

@route('/smofailure')
@view('smofailure')
def smo():
    return dict(year=datetime.now().year, canalsCount = "", intensityFlowOfRequests = "",
               requestExecutionMinute = "", endTimeMinute = "", repeatCount = "", result = "")

@post('/ons')
def ons():
    """ Обработчик данных пользователя """
    response.content_type = 'application/json'

    try:
        postdata = request.body.read()
        userInput = json.loads(postdata)

        print(userInput)

        baseNode = Node(ConnectionType(userInput["baseConnection"]))
        node1 = Node(ConnectionType(userInput["blockOne"]["connection"]))
        node2 = Node(ConnectionType(userInput["blockTwo"]["connection"]))
        triesCount = userInput["triesCount"]
    except:
        return error("Ошибка запроса")

    try:
        for x in userInput["blockOne"]["blocks"]:
            if x > 1 or x < 0:
                raise ValueError()
            node1.addElement(WorkingBlock(x))

        for x in userInput["blockTwo"]["blocks"]:
            if x > 1 or x < 0:
                raise ValueError()
            node2.addElement(WorkingBlock(x))
    except:
        return error("Неверно указаны вероятности для блоков")

    if (triesCount > 1e6 or triesCount < 1):
        return error("Неправильное число испытаний")

    baseNode.addElement(node1)
    baseNode.addElement(node2)

    analitical = baseNode.analyticalProbability()
    empirical = baseNode.empiricalProbability(triesCount)
    errorRate = abs(analitical - empirical)

    # Возвращение значнеия
    return json.dumps({ "analitical": round(analitical, 4), "empirical": round(empirical, 4), "errorRate": round(errorRate, 8) })

@post('/SMOFailure')
def SMOFailure():
    try:
        canalsCount = int(request.forms.get('canalsCount'))
        intensityFlowOfRequests = float(request.forms.get('intensityFlowOfRequests'))
        requestExecutionMinute = float(request.forms.get('requestExecutionMinute'))
        endTimeMinute = float(request.forms.get('endTimeMinute'))
        repeatCount = int(request.forms.get('repeatCount'))
        qs = QueuingSystemMonteCarlo(canalsCount, intensityFlowOfRequests, requestExecutionMinute, endTimeMinute)
        result = qs.getMathematicalExpectationQSWithFailure(repeatCount)
        return template('SMOFailure', year=datetime.now().year, canalsCount = canalsCount, 
                        intensityFlowOfRequests = intensityFlowOfRequests, requestExecutionMinute = requestExecutionMinute,
                        endTimeMinute = endTimeMinute, repeatCount = repeatCount, result = "Математическое ожидание: %.2f" % result)
    except: 
         return template('SMOFailure', year=datetime.now().year, canalsCount = canalsCount, 
                        intensityFlowOfRequests = intensityFlowOfRequests, requestExecutionMinute = requestExecutionMinute,
                        endTimeMinute = endTimeMinute, repeatCount = repeatCount,result = "Неверный ввод")

@post('/SMOQueue')
def SMOQueue():
    try:
        canalsCount = int(request.forms.get('canalsCount'))
        intensityFlowOfRequests = float(request.forms.get('intensityFlowOfRequests'))
        requestExecutionMinute = float(request.forms.get('requestExecutionMinute'))
        endTimeMinute = float(request.forms.get('endTimeMinute'))
        repeatCount = int(request.forms.get('repeatCount'))
        requestInQueue = int(request.forms.get('requestInQueue'))
        if (requestInQueue == 0):
            requestInQueue = None
        qs = QueuingSystemMonteCarlo(canalsCount, intensityFlowOfRequests, requestExecutionMinute, endTimeMinute)
        result = qs.getMathematicalExpectationQSWithQueue(repeatCount, requestInQueue)
        return template('SMOQueue', year=datetime.now().year, canalsCount = canalsCount, 
                        intensityFlowOfRequests = intensityFlowOfRequests, requestExecutionMinute = requestExecutionMinute,
                        endTimeMinute = endTimeMinute, repeatCount = repeatCount, requestInQueue = requestInQueue,
                        result = "Математическое ожидание: %.2f" % result)
    except: 
         return template('SMOQueue', year=datetime.now().year, canalsCount = canalsCount, 
                        intensityFlowOfRequests = intensityFlowOfRequests, requestExecutionMinute = requestExecutionMinute,
                        endTimeMinute = endTimeMinute, repeatCount = repeatCount, requestInQueue = requestInQueue,
                        result = "Неверный ввод")

def error(str):
    return json.dumps({ "error": str })