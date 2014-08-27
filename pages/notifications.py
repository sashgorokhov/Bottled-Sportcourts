import bottle

from modules.utils import beautifuldate, beautifultime, get_notifications
import pages
import modules.dbutils


class Notifications(pages.Page):
    def get(self):
        if not pages.auth_dispatcher.loggedin():
            raise bottle.HTTPError(404)
        notifications = get_notifications(pages.auth_dispatcher.getuserid())
        if len(notifications) == 0:
            with modules.dbutils.dbopen() as db:
                db.execute(
                    "SELECT * FROM notifications WHERE user_id='{}' AND datetime>NOW() - INTERVAL 1 DAY ORDER BY datetime DESC".format(
                        pages.auth_dispatcher.getuserid()), modules.dbutils.dbfields['notifications'])
                notifications = db.last()
        for i in notifications:
            modules.dbutils.strdates(i)
            i['datetime'] = '{} {}'.format(beautifuldate(i['datetime']), beautifultime(i['datetime']))
        return pages.PageBuilder("notifications", notifications=notifications, header_name='notifications_head')

    get.route = '/notifications'
