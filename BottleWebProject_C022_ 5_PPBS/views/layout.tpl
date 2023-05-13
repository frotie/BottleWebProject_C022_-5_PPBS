<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="/static/images/favicon.ico">
    <title>{{ title }} - Имитационное моделирование. Системы массового обслуживания</title>
    <link rel="stylesheet" type="text/css" href="/static/content/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/static/content/site.css" />
    <link rel="stylesheet" type="text/css" href="/static/content/font-awesome.min.css" />
    <script src="/static/scripts/modernizr-2.6.2.js"></script>
    <script src="/static/scripts/jquery-3.6.4.min.js"></script>
    <script src="/static/scripts/respond.js"></script>
</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-light main-nav">
        <div class="container">
            <a class="navbar-brand" href="/">Группа №5</a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a href="/" class="nav-link">Главная</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="onsDd" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Оценка надежности систем
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="onsDd">
                            <a class="dropdown-item" href="/ons/1">Вариант №1</a>
                            <a class="dropdown-item" href="/ons/4">Вариант №4</a>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a href="/about" class="nav-link">Об авторах</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container body-content mt-4">
        {{!base}}
        <hr />
        <footer>
            <p>&copy; {{ year }} - Имитационное моделирование. Системы массового обслуживания</p>
        </footer>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" type="text/javascript"></script>
    <script src="/static/scripts/bootstrap.min.js"></script>
    <script>
        jQuery(document).ready(function($){
            var parts = window.location.pathname.split("/")
            var nextpath = parts.pop();
            var path = nextpath
      
            do
            {
                console.log(path)
                var target = $('a[href="/' + path + '"]');
                if (target.length != 0)
                {
                    target.closest('.nav-item').children('a.nav-link').addClass('active');
                    break;
                }

                nextpath = parts.pop();
                path = nextpath + "/" + path;
            }
            while (nextpath != undefined && nextpath != null);

        });
    </script>
</body>
</html>
