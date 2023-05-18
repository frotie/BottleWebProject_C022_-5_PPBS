% rebase('layout.tpl', title='Оценка надёжности систем', year=year, firstBlock=firstBlock, secondBlock=secondBlock)

<div class="row">
    <div class="col-md-4 d-none d-md-block">
        <img src="/static/images/SittingCat.png" alt="" class="img-fluid">
    </div>

    <div class="col-md-8">
        <h3>Оценка надежности систем</h3>
        <p>Для повышения качества работы технических средств, в частности автомобилей и технических средств организации дорожного движения,  снижения стоимости их обслуживания необходимо добиться обеспечения оптимальной надежности этих средств. На решение данных задач направ лено развитие и совершенствование теории и практики расчета и экспе риментального определения надежности.</p>
        <p>Теория надежности является прикладной технической наукой. Она изучает общие закономерности, которых следует придерживаться при проектировании, изготовлении, испытаниях и эксплуатации объектов для по лучения максимальной эффективности и безопасности их использования</p>
        
        <div class="card profile-card shadow-sm border-0 mt-2">
            <div class="card-body">
                <form action="/ons" method="post" class="needs-validation" id="mainForm">
                    <div class="row">
                        <div class="col-md-4 mb-2">
                            <div id="block1Container">
                                <span class="h6">Блок 1</span>
                                <div class="mb-3 mt-2">
                                    <label for="block1Connection" class="form-label">Тип соединения между элементами</label>
                                    <select name="block1Connection" id="block1Connection" class="form-select">
                                        <option value="0" selected>Параллельное</option>
                                        <option value="1">Последовательное</option>
                                    </select>
                                </div>

                                <div class="mb-3 inputProbability" id="firstBlockTemplate">
                                    <label for="block1" class="form-label">Вероятность 1 элемента</label>
                                    <div class="input-group has-validation">
                                        <input type="text" name="[blockOne][blocks][1]" id="block1" class="form-control firstBlockProbability">
                                        <span class="input-group-text">%</span>
                                        <button type="button" class="btn btn-danger removeElement" style="background: #CF7996; border: #CF7996;" disabled>
                                            <i class="fa fa-trash"></i>
                                        </button>
                                        <div class="invalid-feedback"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3 text-center">
                                <button type="button" class="btn btn-our-secondary" id="addFirstBlock">
                                    <i class="fa fa-plus"></i> Добавить элемент
                                </button>
                            </div>
                        </div>
                        <div class="col-md-4 mb-2">
                            <div id="block2Container">
                                <span class="h6">Блок 2</span>
                                <div class="mb-3 mt-2">
                                    <label for="block2Connection" class="form-label">Тип соединения между элементами</label>
                                    <select name="block2Connection" id="block2Connection" class="form-select">
                                        <option value="0" selected>Параллельное</option>
                                        <option value="1">Последовательное</option>
                                    </select>
                                </div>

                                <div class="mb-3 inputProbability" id="secondBlockTemplate">
                                    <label for="secondBlock1" class="form-label">Вероятность 1 элемента</label>
                                    <div class="input-group has-validation">
                                        <input type="text" name="[blockTwo][blocks][1]" id="secondBlock1" class="form-control secondBlockProbability">
                                        <span class="input-group-text">%</span>
                                        <button type="button" class="btn btn-danger removeElement" style="background: #CF7996; border: #CF7996;" disabled>
                                            <i class="fa fa-trash"></i>
                                        </button>
                                        <div class="invalid-feedback"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3 text-center">
                                <button type="button" class="btn btn-our-secondary" id="addSecondBlock">
                                    <i class="fa fa-plus"></i> Добавить элемент
                                </button>
                            </div>
                        </div>
                        <div class="col-md-4 mb-2">
                            <span class="h6">Результат</span>
                            <div class="mb-3 mt-2">
                                <label for="baseConnection" class="form-label">Тип соединения между двумя блоками</label>
                                <select name="baseConnection" id="baseConnection" class="form-select">
                                    <option value="0">Параллельное</option>
                                    <option value="1" selected>Последовательное</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="triesCount" class="form-label">Количество испытаний</label>
                                <input type="number" id="triesCount" class="form-control" value="100">

                            </div>

                            <div class="mb-3 text-center">
                                <button type="submit" class="btn btn-our-result" id="finish">
                                    <i class="fa fa-calculator"></i> Рассчитать
                                </button>
                            </div>

                            <div class="mb-3">
                                <p class="results"></p>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
var firstBlockIndex = 2
var secondBlockIndex = 2

$(document).ready(function(){
    // Создание блоков по вариантам
    for (let i = 0; i < {{ firstBlock }} - 1; i++)
    {
        createBlock(firstBlockIndex++, $("#block1Container"), $("#firstBlockTemplate"))
    }

    for (let i = 0; i < {{ secondBlock }} - 1; i++)
    {
        createBlock(secondBlockIndex++, $("#block2Container"), $("#secondBlockTemplate"))
    }

    // Инициализация уже существущих полей в разметке
    $("#mainForm input[type=text]").each(function () {
        initializeHandlers($(this));
    });

    // Обработчики добавления блоков
    $("#addFirstBlock").click(function () {
        createBlock(firstBlockIndex++, $("#block1Container"), $("#firstBlockTemplate"))
    });

    $("#addSecondBlock").click(function () {
        createBlock(secondBlockIndex++, $("#block2Container"), $("#secondBlockTemplate"))
    });
});
</script>

<script src="/static/scripts/ONS_logic.js"></script>