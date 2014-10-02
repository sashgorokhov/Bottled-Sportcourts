% rebase("_fatpage", title="Главная")
      <div class="row hidden-xs">
        <div class="row">
          <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
            <!-- Indicators -->
            <ol class="carousel-indicators">
              <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
              <li data-target="#carousel-example-generic" data-slide-to="1"></li>
              <li data-target="#carousel-example-generic" data-slide-to="2"></li>
            </ol>
            <div class="text-center" style="position:absolute; top:15%; left:25%; z-index:100; width:50%; color: rgb(255, 255, 255); text-shadow: rgba(0, 0, 0, 0.6) 0px 1px 2px;">
              <h1>SportCourts</h1>
              <p class="lead">Ваш проводник в мире любительского спорта.</p>
              <p class="lead">Наша бета-версия стартовала!</p>
              % if not loggedin:
                  <p><a class="btn btn-main btn-lg btn-success" href="/registration" role="button">Зарегистрироваться</a></p>
                  <p class="text-center">или</p>
                  <p><a class="btn btn-main btn-lg btn-primary" href="https://oauth.vk.com/authorize?client_id=443655&scope=email&redirect_uri=http://{{serverinfo['ip']}}:{{serverinfo['port']}}/auth&response_type=code&v=5.21" role="button">Войти через ВКонтакте</a></p>
                  <p>&nbsp;</p>
              % end
            </div>
            <!-- Wrapper for slides -->
            <div class="carousel-inner" style="overflow:hidden">
              <div class="item active" style="background-color:black; max-height:450px;">
                <img src="/images/courts/1" alt="..." style="width:100%; opacity:0.5;">
                <div class="carousel-caption">
                </div>
              </div>
              <div class="item" style="background-color:black; max-height:450px;">
                <img src="/images/courts/8" alt="..." style="width:100%; opacity:0.5;">
                <div class="carousel-caption">
                </div>
              </div>
              <div class="item" style="background-color:black; max-height:450px;">
                <img src="/images/courts/10" alt="..." style="width:100%; opacity:0.5;">
                <div class="carousel-caption">
                </div>
              </div>
            </div>

            <!-- Controls -->
            <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
              <span class="glyphicon glyphicon-chevron-left"></span>
            </a>
            <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
              <span class="glyphicon glyphicon-chevron-right"></span>
            </a>
          </div>
        </div>
      </div>
      <script>
        $('.carousel').carousel();
      </script>
      <div class="jumbotron visible-xs">
        <h1>SportCourts</h1>
        <p class="lead">Ваш проводник в мире любительского спорта.</p>
        <p class="lead">Наша бета-версия стартовала!</p>
        % if not loggedin:
            <p><a class="btn btn-main btn-lg btn-success" href="/registration" role="button">Зарегистрироваться</a></p>
            <p class="text-center">или</p>
            <p><a class="btn btn-main btn-lg btn-primary" href="https://oauth.vk.com/authorize?client_id=4436558&scope=email&redirect_uri=http://{{serverinfo['ip']}}:{{serverinfo['port']}}/auth&response_type=code&v=5.21" role="button">Войти через ВКонтакте</a></p>
        % end
      </div>

      <div class="container">
        <div class="row marketing">
          <div class="col-lg-4 text-center">
            <p>Увлекаешься спортом? Ищешь друзей для совместных занятий или соперников для твоей команды? Хочешь быть в курсе спортивных событий твоего города?</p>
          </div>

          <div class="col-lg-4 text-center">
            <p>Выбери из сотен спортивных событий совего города. Найди подходящую площадку и время. Общайся с участниками и приглашай друзей.</p>
          </div>

          <div class="col-lg-4 text-center">
            <p>Занимайся спортом. Делись своими достижениями с друзьями. Находи новые площадки и узнавай о том, что происходит вокруг.</p>
          </div>
        </div>
      </div>