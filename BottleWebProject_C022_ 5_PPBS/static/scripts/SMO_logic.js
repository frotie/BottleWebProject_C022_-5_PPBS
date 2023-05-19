const styledSwal = Swal.mixin({
    background: 'linear-gradient(135deg, var(--gradient-one), var(--gradient-two))',
    customClass: {
        loader: 'popupLoader',
        confirmButton: 'btn btn-our-secondary'
    },
    buttonsStyling: false
});

// Функция инициализации валидации значений с плавающией точкой
function initializeHandlersFloat(obj) {
    obj.on('change keyup paste', function () {
        var txt = $(this).val();
        var number = Number(txt);        
        if (txt != '' && (number != txt || number <= 0 || number > 100)) {
            $(this).addClass('is-invalid');
            $(this).siblings(".invalid-feedback").text("Введите число больше 0 до 100");
        }
        else {
            $(this).removeClass('is-invalid');
        }
    });
}

// Функция инициализации валидации целых значений
function initializeHandlersInt(obj) {
    obj.on('change keyup paste', function () {
        var txt = $(this).val();
        var number = Number(txt);
        var remainder = number % 1;
        if (txt != '' && (remainder > 0 || txt.includes("."))) {
            $(this).addClass('is-invalid');           
            $(this).siblings(".invalid-feedback").text("Введите ближайшее целое число: " + (number - remainder).toString() + " или " + (number - remainder + 1).toString());            
        }
        else if (txt != '' && (number != txt || number <= 0 || number > 100)) {
            $(this).addClass('is-invalid');
            $(this).siblings(".invalid-feedback").text("Введите число больше 0 до 100");
        }
        else {
            $(this).removeClass('is-invalid');
        }
    });
}

// Функция инициализации валидации целых значений
function initializeHandlersQueue(obj) {
    obj.on('change keyup paste', function () {
        var txt = $(this).val();
        var number = Number(txt);
        var remainder = number % 1;        
        if (txt != '' && (remainder > 0 || txt.includes("."))) {
            $(this).addClass('is-invalid');
            $(this).siblings(".invalid-feedback").text("Введите ближайшее целое число: " + (number - remainder).toString() + " или " + (number - remainder + 1).toString());            
        }
        else if (txt != '' && (number != txt || number < 0 || number > 100)) {
            $(this).addClass('is-invalid');
            $(this).siblings(".invalid-feedback").text("Введите число больше 0 до 100");
        }
        else {
            $(this).removeClass('is-invalid');
        }
    });
}

// Событие отправки формы
$("#mainForm").submit(function (e) {
    // Нахождение невалидных полей
    if ($(this).find('.is-invalid').length > 0) {
        scrollTo($(this).find('.is-invalid'))
        e.preventDefault()
        return;
    }

    var emptyFields = $(this).find('input').filter(function () {
        return !this.value;
    });

    // Проверка пустых полей
    if (emptyFields.length > 0) {
        styledSwal.fire('Ошибка', 'Вы заполнили не все поля', 'error')
        scrollTo(emptyFields)
        e.preventDefault()
        return;
    }
})

function scrollTo(el) {
    $([document.documentElement, document.body]).animate({
        scrollTop: el.offset().top
    }, 2000);
}