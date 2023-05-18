"""
Routes and views for the bottle application.
"""

from models.MonteCarlo import WorkingBlock, Node, ConnectionType
from bottle import route, view, post, request, response
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

@route('/smo')
@view('smo')
def smo():
    return dict(year=datetime.now().year)

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

    baseNode.addElement(node1)
    baseNode.addElement(node2)

    analitical = baseNode.analyticalProbability()
    empirical = baseNode.empiricalProbability(triesCount)
    errorRate = abs(analitical - empirical)

    # Возвращение значнеия
    return json.dumps({ "analitical": round(analitical, 4), "empirical": round(empirical, 4), "errorRate": round(errorRate, 8) })

def error(str):
    return json.dumps({ "error": str })