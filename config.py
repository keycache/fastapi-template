from functools import lru_cache
import os
from typing import Optional

from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    # Database
    DATABASE_URL: str
    
    # API
    API_V1_STR: str = "/api/v1"
    
    class Config:
        case_sensitive = True
        # env_file = ".env"


@lru_cache()
def get_settings() -> Settings:
    return Settings()
