import bottle
import modules

bottle.TEMPLATE_PATH.append('views')
bottle.debug(modules.config['debug'])

import pages
import modules.backuper

@bottle.error(404)
def error404(error):
    return pages.PageBuilder('404').template()


application = bottle.default_app()

bottle.install(modules.exec_time_measure)