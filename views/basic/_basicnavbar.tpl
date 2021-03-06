
      <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
          <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                  <span class="sr-only">Toggle navigation</span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/" style="padding:0">
                  <img src="/images/static/logo.png" alt="" height="55">
                </a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li><a class="topmenu" href="/games">Игры</a></li>
                    <li><a class="topmenu" href="/users">Игроки</a></li>
                    <li><a class="topmenu" href="/courts"><span class="glyphicon glyphicon-globe"></span> Карта</a></li>
                    <!-- <li><a class="topmenu" href="/blog">Блог</a></li> -->
                    % if loggedin:
                        <li>
                          <a class="topmenu" href="/profile">

                            <img src="/images/avatars/{{current_user.user_id()}}?sq_sm" class="img-circle header_avatar" width="30" height="30" >
                            &nbsp;
                            Мой профиль
                          </a>
                        </li>
                        % if current_user.userlevel.admin():
                        <li>
                          <a class="topmenu" href="/admin">
                            Админка
                          </a>
                        </li>
                        % end
                        <li>
                            <a class="topmenu" href="/notifications">
                                <span class="glyphicon glyphicon-bell"></span>
                                % if notifycount>0:
                                    <span class="badge notify">{{notifycount}}
                                % end
                            </span>
                            </a>
                        </li>
                        <li><a class="topmenu" href="/logout">Выход</a></li>
                    % end
                    % if not loggedin:
                        <li><a class="topmenu" href="#" data-toggle="modal" data-target="#loginModal">Вход</a></li>
                    % end
                </ul>
            </div>
          </div>
      </div>