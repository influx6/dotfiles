import logging

from pyim import Wheel

logging.basicConfig(
    level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s"
)

instance = Wheel()

logging.info("WHeel name is: %s", instance.name)
