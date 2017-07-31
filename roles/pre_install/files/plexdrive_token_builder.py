#!/usr/bin/env python2.7
import argparse
import json
from urllib import urlencode

import requests

parser = argparse.ArgumentParser(description='Plexdrive CLI config.json/token.json builder')
parser.add_argument('client_id', metavar='client_id', type=str, help='Google Client ID')
parser.add_argument('client_secret', metavar='client_secret', type=str, help='Google Client Secret')
parser.add_argument('access_code', metavar='access_code', type=str, default=None, nargs='?',
                    help='Google Access Code from authorization url')


def authorize_url(client_id):
    payload = {
        'client_id': client_id,
        'redirect_uri': 'urn:ietf:wg:oauth:2.0:oob',
        'response_type': 'code',
        'access_type': 'offline',
        'scope': 'https://www.googleapis.com/auth/drive',
        'state': 'state-token'
    }
    url = 'https://accounts.google.com/o/oauth2/v2/auth?' + urlencode(payload)
    print(url)
    exit(0)


def get_token(access_code, client_id, client_secret):
    payload = {
        'code': access_code,
        'client_id': client_id,
        'client_secret': client_secret,
        'access_type': 'offline',
        'grant_type': 'authorization_code',
        'redirect_uri': 'urn:ietf:wg:oauth:2.0:oob',
        'state': 'state-token'
    }
    resp = requests.post('https://www.googleapis.com/oauth2/v4/token', data=payload)
    if resp.status_code == 200:
        cfg = {
            'ClientID': client_id,
            'ClientSecret': client_secret
        }
        # dump token.json
        with open('token.json', 'w') as fp:
            json.dump(resp.json(), fp)
        # dump config.json
        with open('config.json', 'w') as fp:
            json.dump(cfg, fp)
        exit(0)
    else:
        print(resp.json())
        exit(1)


if __name__ == "__main__":
    args = parser.parse_args()
    if not args.access_code:
        authorize_url(args.client_id)
    else:
        get_token(args.access_code, args.client_id, args.client_secret)
