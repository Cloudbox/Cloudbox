#!/usr/bin/env python3
import logging
import os
import sys
import time
from urllib.parse import urljoin

import requests

############################################################
# INIT
############################################################

# Setup logger
log_filename = os.path.join(os.path.dirname(sys.argv[0]), 'cloudflared.log')
log_formatter = '[%(asctime)s] %(levelname)s - %(message)s'
logging.basicConfig(
    filename=log_filename,
    level=logging.DEBUG,
    format=log_formatter,
    datefmt='%H:%M:%S'
)
logging.getLogger('urllib3').setLevel(logging.ERROR)
console = logging.StreamHandler()
console.setLevel(logging.DEBUG)
console.setFormatter(logging.Formatter(log_formatter))
logging.getLogger('').addHandler(console)
log = logging.getLogger("CloudFlared")

# CloudFlare
api_link = 'https://api.cloudflare.com/client/v4/'
subdomains = {
    'sonarr': False,
    'radarr': False,
    'nzbhydra': False,
    'jackett': False,
    'nzbget': False,
    'rutorrent': False,
    'plex': True,
    'plexpy': False,
    'plexrequests': False,
    'organizr': False,
    'portainer': False
}


############################################################
# CLASS
############################################################

class CloudFlare:
    def __init__(self, email, api_key, domain):
        self.email = email
        self.api_key = api_key
        self.domain = domain
        self.headers = {'X-Auth-Email': email, 'X-Auth-Key': api_key, 'Content-Type': 'application/json'}

    def get_zone(self, domain):
        log.info("Retrieving zone for domain: %s", domain)
        try:
            payload = {'name': domain, 'per_page': 50}
            resp = requests.get(urljoin(api_link, 'zones'), params=payload, headers=self.headers)
            if resp.status_code != 200:
                log.error(
                    "Unexpected response when retrieving zones from CloudFlare, response_code=%d, response_text:\n%s",
                    resp.status_code, resp.text)
                return None
            for item in resp.json()['result']:
                if item['name'].lower() == domain.lower():
                    log.info("Found zone zone: %r", item['id'])
                    return item['id']
            log.error("Could not find zone for domain: %s", domain)
            return None
        except:
            log.exception("Exception finding zone for %s: ", domain)
        return None

    def get_records(self, zone):
        log.info("Retrieving records for zone: %s", zone)
        try:
            payload = {'per_page': 100, 'page': 1}
            records = []
            while True:
                resp = requests.get(urljoin(api_link, 'zones/%s/dns_records' % zone), params=payload,
                                    headers=self.headers)
                if resp.status_code != 200:
                    log.error(
                        "Unexpected response when retrieving records from CloudFlare, "
                        "response_code=%d, response_text:\n%s", resp.status_code, resp.text)
                    return {}
                for item in resp.json()['result']:
                    if item['type'] == 'A':
                        log.debug("Found A record: %s, ip: %s, proxied: %s", item['name'], item['content'],
                                  'True' if item['proxied'] else False)
                        records.append(item)
                result_info = resp.json()['result_info']
                if result_info['page'] < result_info['total_pages']:
                    payload['page'] += 1
                    log.info("Set page to: %d of %d", payload['page'], result_info['total_pages'])
                    time.sleep(5)
                else:
                    break
            return records
        except:
            log.exception("Exception retrieving zones for zone %s:", zone)
        return []

    def create_record(self, zone, name, ip, proxied):
        try:
            payload = {
                'type': 'A',
                'name': name,
                'content': ip,
                'proxied': proxied,
                'ttl': 1
            }
            resp = requests.post(urljoin(api_link, 'zones/%s/dns_records' % zone), json=payload,
                                 headers=self.headers)
            if resp.status_code != 200:
                log.error(
                    "Unexpected response when creating record from CloudFlare, response_code=%d, response_text:\n%s",
                    resp.status_code, resp.text)
                return False
            return resp.json()['success']
        except:
            log.exception("Exception creating record %s:", name)
        return False

    def update_record(self, zone, dns_id, name, ip, proxied):
        try:
            payload = {
                'type': 'A',
                'name': name,
                'content': ip,
                'proxied': proxied,
                'ttl': 1
            }
            resp = requests.put(urljoin(api_link, 'zones/%s/dns_records/%s' % (zone, dns_id)), json=payload,
                                headers=self.headers)
            if resp.status_code != 200:
                log.error(
                    "Unexpected response when updating record from CloudFlare, response_code=%d, response_text:\n%s",
                    resp.status_code, resp.text)
                return False
            return resp.json()['success']
        except:
            log.exception("Exception updating record %s:", name)
        return False


############################################################
# FUNCS
############################################################

def has_subdomain(subdomain, records):
    for item in records:
        if item['name'].lower() == subdomain.lower():
            return True, item
    return False, None


############################################################
# MAIN
############################################################

if __name__ == "__main__":
    # Retrieve required CloudFlare information
    log.info("Please enter your account email below:")
    email = input()
    log.info("Please paste your API Key below:")
    api_key = input()
    log.info("Please enter your domain below (e.g. cloudbox.com):")
    domain = input()
    log.info("Please enter the IP for the subdomains:")
    ip = input()

    cf = CloudFlare(email, api_key, domain)

    # Determine zone from domain
    zone = cf.get_zone(domain)
    if not zone:
        exit(1)

    # Retrieve existing DNS
    records = cf.get_records(zone)
    if not len(records):
        exit(1)
    # Create/Update DNS
    for dns, proxied in subdomains.items():
        has_sub, the_sub = has_subdomain('%s.%s'.strip() % (dns, domain), records)
        if has_sub:
            if ip.strip() == the_sub['content'].strip() and proxied == the_sub['proxied']:
                log.info("Nothing to change for %s.%s", dns, domain)
                continue

            # update dns record
            log.info("Updating subdomain %s.%s to %s, proxied: %s", dns, domain, ip, 'True' if proxied else 'False')
            if cf.update_record(zone, the_sub['id'], '%s.%s'.strip() % (dns, domain), ip, proxied):
                log.info("Successfully updated %s.%s", dns, domain)
            else:
                log.error("Failed updating %s.%s", dns, domain)

        else:
            # create dns record
            log.info("Creating subdomain %s.%s to %s, proxied: %s", dns, domain, ip, 'True' if proxied else 'False')
            if cf.create_record(zone, '%s.%s'.strip() % (dns, domain), ip, proxied):
                log.info("Successfully created %s.%s", dns, domain)
            else:
                log.error("Failed creating %s.%s", dns, domain)
                exit(1)
    log.info("Finished!")
