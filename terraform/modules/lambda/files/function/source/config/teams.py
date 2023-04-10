import requests


class Teams:

    def __init__(self, hookurl, timeout=60):
        self.hookurl = hookurl
        self.timeout = timeout

    def post(self, data):
        headers = {"Content-Type": "application/json"}
        response = requests.post(
            self.hookurl,
            json=data,
            headers=headers,
            timeout=self.timeout
        )
        response.raise_for_status()
        if response.text == "1":
            return response
        else:
            raise Exception(response.text)
