import json
import os

import requests

class Teams:

    def __init__(self, hookurl, timeout=60):
        try:
            self.hookurl = hookurl
            self.timeout = timeout

        except Exception as err:
            raise Exception(str(err))

    def post(self, data):
        try:
            headers = {"Content-Type": "application/json"}
            response = requests.post(
                self.hookurl,
                data=data,
                headers=headers,
                timeout=self.timeout
            )
            
            if response.status_code == requests.codes.ok and response.text == "1":
                return response
            else:
                raise Exception(response.text)
        except Exception as err:
            raise Exception(str(err))
