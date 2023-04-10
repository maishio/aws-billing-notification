import logging.config
import os


class LogConfig:
    """ログ設定

    ログ設定を行うクラス

    Attributes:
        logging (logging):ロギング
    """

    def __init__(self) -> None:
        """
        コンストラクタ
        """

        current_path = os.path.dirname(__file__)
        logging.config.fileConfig(current_path + "/logging.conf")

    @property
    def logging(self):
        return logging


logger = LogConfig().logging
