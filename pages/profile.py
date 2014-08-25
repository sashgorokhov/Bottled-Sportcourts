import os
import datetime

from PIL import Image
import bottle

from modules.utils import beautifuldate, beautifultime
import pages
import modules
import modules.dbutils


class Profile(pages.Page):
    def get_user_id(self):
        with modules.dbutils.dbopen() as db:
            user = modules.dbutils.get(db).user(bottle.request.query.user_id)
            if len(user) == 0:
                raise bottle.HTTPError(404)
            user = user[0]
            modules.dbutils.strdates(user)
            user['bdate'] = str(round((datetime.date.today() - datetime.date(
                *list(map(int, user['bdate'].split('-'))))).total_seconds() // 31556926)) + ' лет'
            user['lasttime'] = '{} в {}'.format(beautifuldate(user['lasttime']), beautifultime(user['lasttime']))
            user['city'] = modules.dbutils.get(db).city(user['city_id'])[0]
            user.pop('city_id')
            return pages.PageBuilder('profile', user=user)

    def get_edit(self):
        with modules.dbutils.dbopen() as db:
            cities = db.execute("SELECT city_id, title FROM cities", ['city_id', 'title'])
            user = modules.dbutils.get(db).user(pages.auth_dispatcher.getuserid())[0]
            modules.dbutils.strdates(user)
            user['city'] = modules.dbutils.get(db).city(user['city_id'])[0]
            user.pop('city_id')
            return pages.PageBuilder('editprofile', user=user, cities=cities)

    def get(self):
        if 'user_id' in bottle.request.query:
            return self.get_user_id()
        elif 'edit' in bottle.request.query and pages.auth_dispatcher.loggedin():
            return self.get_edit()
        elif pages.auth_dispatcher.loggedin():
            with modules.dbutils.dbopen() as db:
                user = modules.dbutils.get(db).user(pages.auth_dispatcher.getuserid())[0]
                modules.dbutils.strdates(user)
                user['bdate'] = str(round((datetime.date.today() - datetime.date(
                    *list(map(int, user['bdate'].split('-'))))).total_seconds() // 31556926)) + ' лет'
                user['lasttime'] = '{} в {}'.format(beautifuldate(user['lasttime']), beautifultime(user['lasttime']))
                user['city'] = modules.dbutils.get(db).city(user['city_id'])[0]
                user.pop('city_id')
                db.execute("SELECT user_id FROM activation WHERE user_id={}".format(user['user_id']))
                if len(db.last()) > 0:
                    activated = False
                else:
                    activated = True
                return pages.PageBuilder('profile', user=user, activated=activated)
        raise bottle.redirect('/auth')

    def post(self):
        if not pages.auth_dispatcher.loggedin():
            raise bottle.HTTPError(404)
        params = {i: bottle.request.forms.get(i) for i in bottle.request.forms}
        params.pop("submit_profile")

        params['first_name'] = bottle.request.forms.get('first_name')
        params['middle_name'] = bottle.request.forms.get('middle_name')
        params['last_name'] = bottle.request.forms.get('last_name')
        params['city'] = bottle.request.forms.get('city')
        city_title = params['city']
        params.pop('city')

        if 'avatar' in params:
            params.pop('avatar')

        if 'avatar' in bottle.request.files:
            filename = str(pages.auth_dispatcher.getuserid()) + '.jpg'
            dirname = '/bsp/data/avatars'
            fullname = os.path.join(dirname, filename)
            if os.path.exists(fullname):
                os.remove(fullname)
            bottle.request.files.get('avatar').save(fullname)
            im = Image.open(fullname)
            im.crop().resize((200, 200)).save(fullname)
            im.close()

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