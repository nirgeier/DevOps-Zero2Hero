from typing import Optional
from pydantic import BaseModel, Field
from bson import ObjectId

class Book(BaseModel):
    id: Optional[str] = Field(alias="_id", default=None)
    title: str
    author: str
    status: str = "available"
    genre: str

    class Config:
        arbitrary_types_allowed = True
        json_encoders = {ObjectId: str}



