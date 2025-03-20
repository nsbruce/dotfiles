#!/usr/bin/env python3

"""Adapted from https://github.com/GilOliveira/rofi-web-search"""

import json
import re
import urllib.parse
import urllib.request
import sys
import os
import datetime
import gzip

import subprocess as sp

import html


SEARCH_ENGINE = 'duckduckgo'
BROWSER = 'firefox'
BROWSER_PATH = BROWSER
USER_AGENT = 'Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:69.0) Gecko/20100101 Firefox/69.0'
SEARCH_ENGINE_NAME = 'DuckDuckGo'
SEARCH_URL = 'https://duckduckgo.com/?q='
SUGGESTION_URL = 'https://duckduckgo.com/ac/?'

def cleanhtml(txt):
    return re.sub(r'<.*?>', '', txt)

def fetch_suggestions(search_string):
    if search_string.startswith('!'):
        bang_search = True
        search_string = search_string.lstrip('!')
    else:
        bang_search = False
    r = {
        'q' : search_string,
        'callback' : 'autocompleteCallback',
        'kl' : 'wt-wt',
        '_' : str(int((datetime.datetime.now().timestamp())*1000))
    }
    url = SUGGESTION_URL + urllib.parse.urlencode(r)
    if bang_search:
        url = url.replace('?q=', '?q=!')
    headers = {
        'pragma' : 'no-cache',
        'dnt' : '1',
        'accept-encoding' : 'gzip',
        'accept-language' : 'en-US;q=0.9,en;q=0.8',
        'user-agent' : USER_AGENT,
        'sec-fetch-mode' : 'no-cors',
        'accept' : '*/*',
        'cache-control' : 'no-cache',
        'authority' : 'duckduckgo.com',
        'referer' : 'https://duckduckgo.com/',
        'sec-fetch-site' : 'same-origin',
    }
    req = urllib.request.Request(url, headers=headers, method='GET')
    reply_data = gzip.decompress(urllib.request.urlopen(req).read()).decode('utf8')
    reply_data = json.loads(re.match(r'autocompleteCallback\((.*)\);', reply_data).group(1))
    return [ cleanhtml(res['phrase']).strip() for res in reply_data ]

def main():
    search_string = html.unescape((' '.join(sys.argv[1:])).strip())

    if search_string.endswith('!'):
        search_string = search_string.rstrip('!').strip()
        results = fetch_suggestions(search_string)
        for r in results:
            print(html.unescape(r))
    elif search_string == '':
        print('!!-- Type something and search it with %s' % SEARCH_ENGINE)
        print('!!-- Close your search string with "!" to get search suggestions')
    else:
        url = SEARCH_URL + urllib.parse.quote_plus(search_string)
        sp.Popen([BROWSER_PATH] + [url], stdout=sp.DEVNULL, stderr=sp.DEVNULL, shell=False)

if __name__ == "__main__":
    try:
        main()
    except:
        sys.exit(1)
