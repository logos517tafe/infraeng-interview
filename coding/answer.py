import json
import requests

# Infraeng Interview Coding Task 1: Read and validate the JSON file
def is_valid_json(json_data):
    try:
        json.loads(json_data)
        return True
    except ValueError as e:
        return False

with open("example.json", "r") as json_file:
    json_data = json_file.read()

if not is_valid_json(json_data):
    print("Invalid JSON file.")
    exit()

# Infraeng Interview Coding Task 2: Filter objects with "private" set to false
data = json.loads(json_data)

filtered_data = {key: value for key, value in data.items() if not value["private"]}

# Infraeng Interview Coding Task 3: Convert the filtered data to JSON
filtered_json = json.dumps(filtered_data, indent=2)

# Infraeng Interview Coding Task 4: Connect to the web service and make a REST POST call
web_service_url = "https://example.com/service/generate"  # Replace with the actual URL

response = requests.post(web_service_url, json=filtered_data)

# Infraeng Interview Coding Task 5: Parse the response and print keys with "valid" set to true
if response.status_code == 200:
    
    response_data = response.json()
    
    for key, value in response_data.items():
        if "child" in value and value["child"].get("valid") is True:
            print(f"Key: {key}")
else:
    print(f"Error: HTTP Status Code {response.status_code}")
