from flask import current_app as app
from flask import jsonify
from ..decorators import require_authentication
from . import routes

@routes.route('/web/title/<title_id>')
@require_authentication
def download_title_info(client, title_id):
    try:
        resp = client.titlehub.get_title_info(title_id, 'image').json()
        return jsonify(resp['titles'][0])
    except KeyError:
        return app.error('Cannot find titles-node json response')
    except IndexError:
        return app.error('No info for requested title not found')
    except Exception as e:
        return app.error('Download of titleinfo failed, error: {0}'.format(e))

@routes.route('/web/titlehistory')
@require_authentication
def download_title_history(client):
    try:
        resp = client.titlehub.get_title_history(app.xbl_client.xuid).json()
        return jsonify(resp)
    except Exception as e:
        return app.error('Download of titlehistory failed, error: {0}'.format(e))
