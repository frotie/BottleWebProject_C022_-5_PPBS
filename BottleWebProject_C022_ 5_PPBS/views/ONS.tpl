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
                                <button type="button" class="btn btn-outline-secondary" id="addFirstBlock">
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
                                <button type="button" class="btn btn-outline-secondary" id="addSecondBlock">
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
                                <button type="submit" class="btn btn-outline-secondary" id="finish">
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
    const styledSwal = Swal.mixin({
        background: 'linear-gradient(135deg, var(--gradient-one), var(--gradient-two))',
        customClass:{
            loader: 'popupLoader'
        },
    });
    $(document).ready(function() {
        // Инициализация уже существущих полей в разметке
        $("#mainForm input[type=text]").each(function() {
            initializeHandlers($(this));
        });

        // Функция инициализации валидации
        function initializeHandlers(obj)
        {
            obj.on('change keyup paste', function() {
                var txt = $(this).val();
                var number = Number(txt);
                if (txt != '' && (number != txt || number > 100 || number < 0)) {
                    $(this).addClass('is-invalid');
                    $(this).siblings(".invalid-feedback").text("Введите значение вероятности от 0 до 100");
                }
                else {
                    $(this).removeClass('is-invalid');   
                }
            });

            obj.parent().children(".removeElement").click(function() {
                obj.closest(".inputProbability").remove()
            });
        }

        // Создать новое поле ввода вероятности
        function createBlock(index, container, tempalte){
            var clone = tempalte.clone()
            clone.removeAttr("id")
            clone.find('input').val('')
            var input = clone.find('input');
            var label = clone.find('label');
            var oldName = input.prop('name');
            var newName = oldName.replace(/\d/, index)
            input.prop('name', newName);
            input.prop('id', newName);
            label.prop('for', newName);
            label.text(label.text().replace(/\d/, index))

            if (index != 1)
            {
                clone.find(".removeElement").removeAttr('disabled')
            }

            container.append(clone)
            initializeHandlers(clone.find('input'))
        }

        var firstBlockIndex = 2
        var secondBlockIndex = 2
        $("#addFirstBlock").click(function()
        {
            createBlock(firstBlockIndex++, $("#block1Container"), $("#firstBlockTemplate"))
        });

        $("#addSecondBlock").click(function() {
            createBlock(secondBlockIndex++, $("#block2Container"), $("#secondBlockTemplate"))
        })

        for (let i = 0; i < {{ firstBlock }} - 1; i++)
        {
            createBlock(firstBlockIndex++, $("#block1Container"), $("#firstBlockTemplate"))
        }

        for (let i = 0; i < {{ secondBlock }} - 1; i++)
        {
            createBlock(secondBlockIndex++, $("#block2Container"), $("#secondBlockTemplate"))
        }

        // Событие отправки формы
        $("#mainForm").submit(function(e) {
            e.preventDefault()

            // Нахождение невалидных полей
            if ($(this).find('.is-invalid').length > 0)
            {
                scrollTo($(this).find('.is-invalid'))
                return;
            }

            var emptyFields = $(this).find('input').filter(function() {
                return !this.value;
            });

            // Проверка пустых полей
            if (emptyFields.length > 0)
            {
                styledSwal.fire('Ошибка', 'Вы заполнили не все поля', 'error')
                scrollTo(emptyFields)
                return;
            }

            // Отключение формы на момент загрузки
            var submit = $(this).find('button[type=submit]')
            var submitText = submit.html()
            submit.html('<div class="spinner-border text-secondary" style="width: 25px; height: 25px" role="status"></div>')
            var disabled = $("#mainForm input[disabled], button[disabled], select[disabled]")
            $("#mainForm input, button, select").prop('disabled', 'disabled')
            $(".results").html('')

            // Подготовка данных для отправки
            dataArr = {
                triesCount: 0,
                baseConnection: '',
                blockOne: {
                    connection: '',
                    blocks: []
                },
                blockTwo: {
                    connection: '',
                    blocks: []
                }
            };

            dataArr.triesCount = Number($("#triesCount").val())
            dataArr.baseConnection = Number($("#baseConnection").val())

            dataArr.blockOne.connection = Number($("#block1Connection").val())
            dataArr.blockTwo.connection = Number($("#block2Connection").val())

            $(".firstBlockProbability").each(function(el) {
                dataArr.blockOne.blocks.push(Number($(this).val()) / 100)
            });

            $(".secondBlockProbability").each(function(el) {
                dataArr.blockTwo.blocks.push(Number($(this).val()) / 100)
            });

            // Отправка данных
            $.ajax({
                url: "/ons",
                method: 'post',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(dataArr),
                success: function(ans){
                    if ('error' in ans)
                    {
                        styledSwal.fire('Ошибка', ans['error'], 'error')
                    }
                    else {
                        $(".results").html('Аналитическая вероятность: <span class="h6">' + ans['analitical'] + '</span><br>Эмпирическая вероятность: <span class="h6">' + ans['empirical'] + '</span><br>Абсолютная погрешность: <span class="h6">' + ans['errorRate'] + '</span>')
                    }
                },
                error: function(err)
                {
                    styledSwal.fire('Ошибка', err.statusText, 'error')
                },
                complete: function()
                {
                    // Включение формы обратно
                    $("#mainForm input, button, select").removeAttr('disabled')
                    disabled.prop('disabled', 'disabled')
                    submit.html(submitText)
                }
            });

            function scrollTo(el)
            {
                $([document.documentElement, document.body]).animate({
                    scrollTop: el.offset().top
                }, 2000);
            }
        })
    });
</script>