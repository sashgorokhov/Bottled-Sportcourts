% rebase("_basicpage", title="Профиль")
      <div class="row profile">
        <div class="col-md-12">
          <form id="profileForm" method="post" class="form-horizontal" action="/profile"
            data-bv-message="This value is not valid"
            data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
            data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
            data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
                <div class="form-group">
                  <label for="photo" class="col-sm-2 control-label">Фото</label>
                  <div class="col-sm-10">
                    <img src="http://sportcourts.ru/avatars/{{str(user['user_id'])}}" alt="User avatar" width="120" style="max-width:170%">
                  </div>
                </div>
                <div class="form-group">
                  <label for="sex" class="col-sm-2 control-label">Пол</label>
                  <div class="col-sm-10">
                    <label class="checkbox-inline" style="margin-left:-17px;">
                      <input type="radio" name="sex" value="male" {{'checked' if user['sex']=='male' else ''}}
                      data-bv-message="Пожалуйста, выберите пол"
                      data-bv-notempty="true"> Мужской
                    </label>
                    <label class="checkbox-inline">
                      <input type="radio" name="sex" value="female" {{'checked' if user['sex']=='female' else ''}}> Женский
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label for="first_name" class="col-sm-2 control-label">Имя</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" name="first_name" placeholder="" value="{{user['first_name']}}"
                    data-bv-notempty="true"
                    data-bv-notempty-message="Поле имени не может быть пустым" />
                    <span id="valid"></span>
                  </div>
                </div>
                <div class="form-group">
                  <label for="last_name" class="col-sm-2 control-label">Фамилия</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" name="last_name" placeholder="" value="{{user['last_name']}}"
                    data-bv-notempty="true"
                    data-bv-notempty-message="Поле фамилии не может быть пустым" />
                    <span id="valid"></span>
                  </div>
                </div>
                <div class="form-group">
                  <label for="middle_name" class="col-sm-2 control-label">Отчество</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" name="middle_name" value="{{user['middle_name']}}"
                    data-bv-notempty="true"
                    data-bv-notempty-message="Поле отчества не может быть пустым" />
                    <span id="valid"></span>
                  </div>
                </div>
                <div class="form-group">
                  <label for="city" class="col-sm-2 control-label">Город</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" name="city" placeholder="" value="{{user['city']['title']}}"
                    data-bv-notempty="true"
                    data-bv-notempty-message="Укажите город" />
                    <span id="valid"></span>
                  </div>
                </div>
                <div class="form-group">
                  <label for="bdate" class="col-sm-2 control-label">Дата рождения</label>
                  <div class="col-sm-10">
                    <input type="date" class="form-control" name="bdate" value="{{user['bdate']}}"
                    data-bv-notempty="true"
                    data-bv-notempty-message="Укажите дату рождения" />
                  </div>
                </div>
                <div class="form-group">
                  <label for="height" class="col-sm-2 control-label">Рост</label>
                  <div class="col-sm-2">
                    <input type="text" class="form-control" name="height" value="{{user['height']}}"
                    min="150"
                    data-bv-greaterthan-inclusive="true"
                    data-bv-greaterthan-message="Это мало"

                    max="230"
                    data-bv-lessthan-inclusive="false"
                    data-bv-lessthan-message="Ты гигант?)"

                    data-bv-notempty="true"
                    data-bv-notempty-message="Укажите рост"

                    pattern="[0-9]"
                    data-bv-regexp-message="Рост указывается числом"
                    />
                  </div>
                </div>
                <div class="form-group">
                  <label for="weight" class="col-sm-2 control-label">Вес</label>
                  <div class="col-sm-2">
                    <input type="text" class="form-control" name="weight" value="{{user['weight']}}"
                    min="30"
                    data-bv-greaterthan-inclusive="true"
                    data-bv-greaterthan-message="Это мало"

                    max="230"
                    data-bv-lessthan-inclusive="false"
                    data-bv-lessthan-message="Ты гигант?)"

                    data-bv-notempty="true"
                    data-bv-notempty-message="Укажите вес"

                    pattern="[0-9]"
                    data-bv-regexp-message="Вес указывается числом"
                    />
                  </div>
                </div>
                <div class="form-group">
                  <label for="email" class="col-sm-2 control-label">Email</label>
                  <div class="col-sm-10">
                    <input type="email" class="form-control" name="email" placeholder="example@mail.com" id="email" value="{{user['email']}}"></input>
                    <span id="valid"></span>
                  </div>
                </div>
                <br>
                <hr>
                <br>
                <div class="form-group">
                  <label for="passwd" class="col-sm-2 control-label">Новый пароль</label>
                  <div class="col-sm-10">
                    <input type="password" class="form-control" name="passwd"
                    data-bv-notempty="true"
                    data-bv-notempty-message="Пароль обязателен и не может быть пустым"
                    data-bv-identical="true"
                    data-bv-identical-field="confirm_passwd"
                    data-bv-identical-message="Пароль и его подтверждение различаются">
                    <span id="valid"></span>
                  </div>
                </div>
                <div class="form-group">
                  <label for="confirm_passwd" class="col-sm-2 control-label">Подтвердите</label>
                  <div class="col-sm-10">
                    <input type="password" class="form-control" name="confirm_passwd"
                    data-bv-notempty="true"
                    data-bv-notempty-message="Пароль обязателен и не может быть пустым"
                    data-bv-identical="true"
                    data-bv-identical-field="passwd"
                    data-bv-identical-message="Пароль и его подтверждение различаются">
                    <span id="valid"></span>
                  </div>
                </div>
                <div class="form-group">
                  <div class="col-sm-offset-2 col-sm-8" style="text-align:center;">
                    <button type="submit" class="btn btn-primary" name="submit_profile">Редактировать информацию</button>
                  </div>
                </div>
            </form>
        </div>
      </div>