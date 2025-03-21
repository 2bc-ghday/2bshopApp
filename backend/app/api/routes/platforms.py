from fastapi import APIRouter, HTTPException, Depends
from sqlmodel import Session, select

from app.models import Platform, PlatformCreate, PlatformUpdate, PlatformsPublic
from app.api.deps import get_db

router = APIRouter(prefix="/platforms", tags=["platforms"])


@router.post("/", response_model=Platform)
def create_platform(*, db: Session = Depends(get_db), platform_in: PlatformCreate):
    platform = Platform(name=platform_in.name)
    db.add(platform)
    db.commit()
    db.refresh(platform)
    return platform


@router.put("/{platform_id}", response_model=Platform)
def update_platform(
    *, db: Session = Depends(get_db), platform_id: int, platform_in: PlatformUpdate
):
    platform = db.get(Platform, platform_id)
    if not platform:
        raise HTTPException(status_code=404, detail="Platform not found")
    platform.name = platform_in.name
    db.add(platform)
    db.commit()
    db.refresh(platform)
    return platform


@router.delete("/{platform_id}", response_model=dict)
def delete_platform(*, db: Session = Depends(get_db), platform_id: int):
    platform = db.get(Platform, platform_id)
    if not platform:
        raise HTTPException(status_code=404, detail="Platform not found")
    db.delete(platform)
    db.commit()
    return {"message": "Platform deleted successfully"}


@router.get("/", response_model=PlatformsPublic)
def list_platforms(*, db: Session = Depends(get_db)):
    platforms = db.exec(select(Platform)).all()
    return PlatformsPublic(data=platforms, count=len(platforms))
