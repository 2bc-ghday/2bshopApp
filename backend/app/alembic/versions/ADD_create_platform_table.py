"""Create platform table

Revision ID: ADD_create_platform_table
Revises: 1a31ce608336
Create Date: 2024-08-01 12:00:00.000000

"""
from alembic import op
import sqlalchemy as sa
import sqlmodel.sql.sqltypes


# revision identifiers, used by Alembic.
revision = 'ADD_create_platform_table'
down_revision = '1a31ce608336'
branch_labels = None
depends_on = None


def upgrade():
    op.create_table(
        'platform',
        sa.Column('id', sa.Integer, primary_key=True, autoincrement=True),
        sa.Column('name', sa.String(length=255), nullable=False)
    )


def downgrade():
    op.drop_table('platform')
