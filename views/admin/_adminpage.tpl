<!DOCTYPE html>
<html lang="en">
  <head>
    <link type="text/css" rel="stylesheet" href="/view/bootstrap/css/bootstrap.min.css" />
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script>
      $(function () {                                      // Когда страница загрузится
        $('li a').each(function () {             // получаем все нужные нам ссылки
          var location = window.location.href; // получаем адрес страницы
          var link = this.href;                // получаем адрес ссылки
          if ($(this).hasClass('adminmenu') == true) {
            if (location == link) {               // при совпадении адреса ссылки и адреса окна
              $(this).parent().addClass('active');
            }
          }
        });
      });
    </script>
    <link type="text/css" rel="stylesheet" href="/view/css/admin.css" />
    % if defined("header_name"):
      % include(header_name)
    % end
  </head>

  <body>
    % include("_adminnavbar")
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          % include("_adminmenu")
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          % setdefault("error_description", '')
              % setdefault("traceback", '')
          % if defined('error') and error:
          %   include('error_dialog', error=error, error_description=error_description, traceback=traceback)
          % end
          {{!base}}
        </div>
      </div>
    </div>
  </body>
</html>