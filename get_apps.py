import json
import sys

data_file_name = sys.argv[1]

with open(data_file_name) as data_file:
    data = json.load(data_file)

# Fetch owner groups and convert to app name
groups = data['groups']
apps = [group.replace('--owners', '') for group in groups if 'owners' in group and 'gcp' not in group]

# Convert to json format alfred expects for list items
items = [ {'uid': app, 'title': app, 'arg': app} for app in apps ]
result = {'items': items}

print(json.dumps(result))
