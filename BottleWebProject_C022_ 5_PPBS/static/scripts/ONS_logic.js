const styledSwal = Swal.mixin({
    background: 'linear-gradient(135deg, var(--gradient-one), var(--gradient-two))',
    customClass: {
        loader: 'popupLoader',
        confirmButton: 'btn btn-our-secondary'
    },
    buttonsStyling: false
});

// Функция инициализации валидации
function initializeHandlers(obj) {
    obj.on('change keyup paste', function () {
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

    obj.parent().children(".removeElement").click(function () {
        obj.closest(".inputProbability").remove()
    });
}

// Создать новое поле ввода вероятности
function createBlock(index, container, tempalte) {
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

    if (index != 1) {
        clone.find(".removeElement").removeAttr('disabled')
    }

    container.append(clone)
    initializeHandlers(clone.find('input'))
}

// Событие отправки формы
$("#mainForm").submit(function (e) {
    e.preventDefault()

    // Нахождение невалидных полей
    if ($(this).find('.is-invalid').length > 0) {
        scrollTo($(this).find('.is-invalid'))
        return;
    }

    var emptyFields = $(this).find('input').filter(function () {
        return !this.value;
    });

    // Проверка пустых полей
    if (emptyFields.length > 0) {
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

    $(".firstBlockProbability").each(function (el) {
        dataArr.blockOne.blocks.push(Number($(this).val()) / 100)
    });

    $(".secondBlockProbability").each(function (el) {
        dataArr.blockTwo.blocks.push(Number($(this).val()) / 100)
    });

    // Отправка данных
    $.ajax({
        url: "/ons",
        method: 'post',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(dataArr),
        success: function (ans) {
            if ('error' in ans) {
                styledSwal.fire('Ошибка', ans['error'], 'error')
            }
            else {
                $(".results").html('Аналитическая вероятность: <span class="h6">' + ans['analitical'] + '</span><br>Эмпирическая вероятность: <span class="h6">' + ans['empirical'] + '</span><br>Абсолютная погрешность: <span class="h6">' + ans['errorRate'] + '</span>')
            }
        },
        error: function (err) {
            styledSwal.fire('Ошибка', err.statusText, 'error')
        },
        complete: function () {
            // Включение формы обратно
            $("#mainForm input, button, select").removeAttr('disabled')
            disabled.prop('disabled', 'disabled')
            submit.html(submitText)
        }
    });
})

function scrollTo(el) {
    $([document.documentElement, document.body]).animate({
        scrollTop: el.offset().top
    }, 2000);
}