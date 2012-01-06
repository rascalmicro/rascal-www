## Basic tutorial: something ##

## Sending data from the Rascal to Pachube ##

import json, requests
key = 'insert key string here'

requests.put('http://api.pachube.com/v2/feeds/43684.json', data='{"version":"1.0.0","datastreams":[ {"current_value":"422", "id":"squid"} ]}', headers={'X-PachubeApiKey': key})

<Response [200]>

## Pulling data from Pachube to the Rascal ##

import json, requests

r = requests.get('https://api.pachube.com/v2/feeds/43684', headers={'X-PachubeApiKey': key})

r.content

print json.dumps(json.loads(r.content), indent=4)

If you find errors in this tutorial, please drop a note in the [forums][1], and we'll fix it up.

[1]: /forum/
