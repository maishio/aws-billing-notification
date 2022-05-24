import logging.config
import os

class LogSettings():
    def __init__(self):
        try:
            current_path = os.path.dirname(__file__)
            logging.config.fileConfig(current_path + '/logging.cfg')
        except Exception as err:
            raise Exception(str(err))

    @property
    def logging(self):
        return logging

LOG = LogSettings().logging
