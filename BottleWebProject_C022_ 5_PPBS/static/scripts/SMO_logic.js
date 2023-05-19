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
        if (txt != '' && (number != txt || number < 1 || number > 100)) {
            $(this).addClass('is-invalid');
            $(this).siblings(".invalid-feedback").text("Введите значение больше 0 до 100");
        }
        else {
            $(this).removeClass('is-invalid');
        }
    });

    obj.parent().children(".removeElement").click(function () {
        obj.closest(".inputProbability").remove()
    });
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
})