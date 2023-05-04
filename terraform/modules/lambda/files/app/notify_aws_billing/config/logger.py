import logging.config
import os


class LogConfig:
    def __init__(self) -> None:
        current_path = os.path.dirname(__file__)
        logging.config.fileConfig(current_path + "/logging.conf")

    @property
    def logging(self):
        return logging


logger = LogConfig().logging
