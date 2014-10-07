import bottle

import pages
import modules
import modules.dbutils
from models import users, cities, activation, images, usergames, games, ampluas


class Profile(pages.Page):
    def get_user_id(self):
        with modules.dbutils.dbopen() as db:
            user_id = int(bottle.request.query.user_id)
            user = users.get(user_id, detalized=True, dbconnection=db)
            if len(user) == 0:
                raise bottle.HTTPError(404)
            user['gameinfo'] = usergames.get_game_stats(user_id, dbconnection=db)
            return pages.PageBuilder('profile', user=user,
                                     myfriend=users.are_friends(pages.auth_dispatcher.getuserid(), user_id,
                                                               dbconnection=db))

    def get_edit(self):
        with modules.dbutils.dbopen() as db:
            _cities = cities.get(0, dbconnection=db)
            user = users.get(pages.auth_dispatcher.getuserid(), detalized=True, dbconnection=db)
            _ampluas = ampluas.get(0, dbconnection=db)
            _ampluas = {sport_type_title: list(filter(lambda x: x['sport_type']['title']==sport_type_title, _ampluas)) for sport_type_title in {i['sport_type']['title'] for i in _ampluas}}
            return pages.PageBuilder('editprofile', user=user, cities=_cities, ampluas = _ampluas,
                                     haveavatar=images.have_avatar(pages.auth_dispatcher.getuserid()))

    def get(self):
        if 'user_id' in bottle.request.query:
            if int(bottle.request.query.get('user_id')) == pages.auth_dispatcher.getuserid():
                raise bottle.redirect('/profile')
            return self.get_user_id()
        elif 'edit' in bottle.request.query and pages.auth_dispatcher.loggedin():
            return self.get_edit()
        elif 'addfriend' in bottle.request.query and pages.auth_dispatcher.loggedin():
            try:
                users.add_friend(pages.auth_dispatcher.getuserid(), int(bottle.request.query.get('addfriend')))
            except ValueError:
                pass
            return ''
        elif 'removefriend' in bottle.request.query and pages.auth_dispatcher.loggedin():
            try:
                users.remove_friend(pages.auth_dispatcher.getuserid(), int(bottle.request.query.get('removefriend')))
            except ValueError:
                pass
            return ''
        elif pages.auth_dispatcher.loggedin():
            with modules.dbutils.dbopen() as db:
                user_id = pages.auth_dispatcher.getuserid()
                user = users.get(user_id, detalized=True, dbconnection=db)
                user['gameinfo'] = usergames.get_game_stats(user_id, dbconnection=db)
                activated = activation.activated(user_id, dbconnection=db)
                page = pages.PageBuilder('profile', user=user, activated=activated)
                user_games = games.get_user_games(user_id, detalized=True,
                                                  fields=['game_id', 'datetime', 'description', 'sport_type',
                                                          'court_id',
                                                          'duration'], dbconnection=db)
                page.add_param('user_games', user_games)
                page.add_param('responsible_games', games.get_responsible_games(user_id, dbconnection=db))
                page.add_param('organizer_games', games.get_organizer_games(user_id, dbconnection=db))
                return page
        return pages.templates.permission_denied(
            '<p><a class="btn btn-main btn-lg btn-success" href="/registration" role="button">Зарегестрируйтесь</a></p>',
            'Чтобы иметь свой профиль, с блекджеком и аватаркой.')

    def post(self):
        if not pages.auth_dispatcher.loggedin():
            return pages.templates.permission_denied()
        params = {i: bottle.request.forms.get(i) for i in bottle.request.forms}

        city_title = params['city']
        params.pop('city')

        if 'ampluas[]' in params:
            params.pop('ampluas[]')
            params['ampluas'] = bottle.request.forms.getall('ampluas[]')
            params['ampluas'] = '|'+'|'.join(params['ampluas'])+'|'
        else:
            params['ampluas'] = ''

        if 'avatar' in params:
            if isinstance(params['avatar'], str):
                images.delete_avatar(pages.auth_dispatcher.getuserid())
            params.pop('avatar')
        elif 'avatar' in bottle.request.files:
            images.save_avatar(pages.auth_dispatcher.getuserid(), bottle.request.files.get('avatar'))

        with modules.dbutils.dbopen() as db:
            db.execute("SELECT city_id FROM cities WHERE title='{}'".format(city_title))
            if len(db.last()) > 0:
                params['city_id'] = db.last()[0][0]
            else:
                params['city_id'] = 1
            sql = "UPDATE users SET {} WHERE user_id={}".format(
                ', '.join(['{}="{}"'.format(i, params[i]) for i in params]),
                pages.auth_dispatcher.getuserid())
            db.execute(sql)
            raise bottle.redirect('/profile')

    get.route = '/profile'
    post.route = get.route