<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ title }} - Имитационное моделирование. Системы массового обслуживания</title>
    <link rel="stylesheet" type="text/css" href="/static/content/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/static/content/site.css" />
    <script src="/static/scripts/modernizr-2.6.2.js"></script>
    <script src="/static/scripts/jquery-3.6.4.min.js"></script>
    <script src="/static/scripts/bootstrap.min.js"></script>
    <script src="/static/scripts/respond.js"></script>
</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-light" style="background: linear-gradient(45deg, rgba(228,162,174,1) 0%, rgba(241,193,121,1) 100%);">
        <div class="container">
            <a class="navbar-brand" href="/">Группа №5</a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                <div class="navbar-nav">
                    <a class="nav-item nav-link" href="/">Главная</a>
                    <a class="nav-item nav-link" href="/about">Об авторах</a>
                </div>
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
    
    <script>
        jQuery(document).ready(function($){
          var path = window.location.pathname.split("/").pop();
      
          var target = $('a.nav-link[href="/'+path+'"]');

          target.addClass('active');
        });
    </script>
</body>
</html>
