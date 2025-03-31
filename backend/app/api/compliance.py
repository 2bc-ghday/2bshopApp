from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from app.crud import create_compliance, delete_compliance, list_compliances
from app.models import Compliance, CompliancesPublic
from app.api.deps import get_db
import uuid
from pydantic import BaseModel

class ComplianceCreate(BaseModel):
    name: str

router = APIRouter(prefix="/compliances", tags=["compliances"])

@router.post("/", response_model=Compliance)
def create_compliance_endpoint(
    compliance: ComplianceCreate, session: Session = Depends(get_db)
):
    return create_compliance(session=session, name=compliance.name)

@router.delete("/{compliance_id}")
def delete_compliance_endpoint(compliance_id: uuid.UUID, session: Session = Depends(get_db)):
    delete_compliance(session=session, compliance_id=compliance_id)
    return {"message": "Compliance deleted successfully"}

@router.get("/", response_model=CompliancesPublic)
def list_compliances_endpoint(session: Session = Depends(get_db)):
    return list_compliances(session=session)